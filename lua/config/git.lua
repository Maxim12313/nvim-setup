function git_setup()
	local function has_conflict()
		return vim.fn.search([[^\(<<<<<<<\|=======\|>>>>>>>\)]], "nw") > 0
	end

	local gitsigns = require("gitsigns")
	local function gitsign_maps(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", ";a", gitsigns.reset_hunk)
		map("n", ";s", function()
			gitsigns.blame_line({ full = true })
		end)

		map("n", ";d", function()
			if vim.wo.diff then
				vim.cmd("wincmd o")
			else
				gitsigns.diffthis()
			end
		end)
		map("n", ";D", function()
			if vim.wo.diff then
				vim.cmd("wincmd o")
			else
				gitsigns.diffthis("~")
			end
		end)

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk)
	end

	gitsigns.setup({
		preview_config = {
			-- Options passed to nvim_open_win
			style = "minimal",
			border = "rounded",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		current_line_blame = true,
		on_attach = gitsign_maps,
	})

	local actions = require("diffview.actions")
	require("diffview").setup({
		view = {
			default = {
				layout = "diff2_horizontal",
				winbar_info = true,
			},
			merge_tool = {
				layout = "diff3_horizontal",
				winbar_info = true,
			},
			file_history = {
				winbar_info = true,
			},
		},
		file_panel = {
			listing_style = "list",
			win_config = {
				position = "left",
				width = 25,
				win_opts = {},
			},
		},
		file_history_panel = {
			win_config = {
				position = "bottom",
				height = 10,
				win_opts = {},
			},
		},
	})

	vim.opt.diffopt:append("vertical")

	function exists_file_type(filetype)
		local exists = false

		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			-- loaded and visible
			if vim.api.nvim_buf_is_loaded(buf) then
				local type = vim.bo[buf].filetype
				local res = type == filetype
				if type == filetype then
					exists = true
					break
				end
			end
		end
		return exists
	end

	-- toggle open
	function toggle(func)
		if exists_file_type("DiffviewFileHistory") or exists_file_type("DiffviewFiles") then
			vim.cmd("DiffviewClose")
		elseif vim.b.jj_diff_conflicts_running then
			vim.cmd("wincmd o")
			vim.cmd("e!")
			vim.b.jj_diff_conflicts_running = false
		else
			func()
		end
	end

	vim.keymap.set("n", "<leader>d", function()
		toggle(function()
			if has_conflict() then
				vim.cmd("JJDiffConflicts")
			else
				vim.cmd("DiffviewOpen -uno")
			end
		end)
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>D", function()
		toggle(function()
			if has_conflict() then
				vim.cmd("JJDiffConflicts")
			else
				vim.cmd("DiffviewOpen -uno HEAD~1")
			end
		end)
	end, { noremap = true, silent = true })

	vim.g.jj_diffconflicts_show_usage_message = false
	vim.api.nvim_create_autocmd("User", {
		pattern = "JJDiffConflictsReady",
		callback = function()
			vim.b.jj_diff_conflicts_running = true
		end,
	})
end
