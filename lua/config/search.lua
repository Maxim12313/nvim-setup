local function setBG(group, bg_color)
	local current_hl = vim.api.nvim_get_hl_by_name(group, true)
	local fg_color = current_hl.foreground or "NONE"
	vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
end

function telescope_setup()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			preview = {
				treesitter = false,
			},
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					width = 0.9,
					height = 0.8,
					preview_cutoff = 0,
					preview_width = 0.3,
				},
			},
			file_ignore_patterns = {
				".git/",
				"%.o",
				"%.out",
				"%.dSYM/",
				"__pycache__",
				"build",
				"venv",
				".venv",
				"env",
				".env",
			},
		},
	})

	setBG("TelescopeSelection", "#3a3d45")
	local builtin = require("telescope.builtin")
	local utils = require("telescope.utils")

	-------------------------------------------------------------- trouble / todo

	vim.keymap.set("n", ";c", function()
		builtin.diagnostics({ severity_limit = vim.diagnostic.severity.ERROR })
	end)

	require("trouble").setup({
		win = {
			size = 5,
		},
		filter = {
			severity = {
				min = vim.diagnostic.severity.ERROR,
				max = vim.diagnostic.severity.ERROR,
			},
		},
		update_in_insert = true,
	})

	require("todo-comments").setup({
		signs = false,
		highlight = {
			multiline = false,
		},
	})

	vim.keymap.set("n", "]t", function()
		require("todo-comments").jump_next()
	end, { desc = "Next todo comment" })

	vim.keymap.set("n", "[t", function()
		require("todo-comments").jump_prev()
	end, { desc = "Previous todo comment" })
end

function telescope_keys()
	local themes = require("telescope.themes")
	local opt = {}

	return {
		{
			";l",
			function()
				require("telescope.builtin").git_status(opt)
			end,
			desc = "Search Modified",
		},
		{
			";g",
			function()
				require("telescope.builtin").live_grep(opt)
			end,
			desc = "Search Grep",
		},
		{
			";f",
			function()
				require("telescope.builtin").find_files(opt)
			end,
			desc = "Search Recent",
		},
		{
			";t",
			":TodoTelescope<CR>",
			desc = "Search Todo",
		},
		{
			";c",
			function()
				require("telescope.builtin").diagnostics({ severity_limit = vim.diagnostic.severity.ERROR })
			end,
		},
		{
			";z",
			function()
				require("telescope.builtin").oldfiles({ only_cwd = true })
			end,
		},
	}
end
