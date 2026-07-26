vim.g.lsp_disable_default_keymaps = true

function lsp_setup_config()
	require("mason").setup({})

	vim.keymap.set("n", ";c", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })

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
		warn_no_results = false,
		auto_close = true,
		open_no_results = false,
		focus = true,
		modes = {
			diagnostics = {
				group = false,
				position = "bottom",
				height = 10,
			},
		},
	})

	-- python
	vim.lsp.config("pyright", {
		settings = {
			["python"] = {
				analysis = {
					typeCheckingMode = "basic",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
					extraPaths = { "." },
					venvPath = ".",
				},
			},
		},
	})

	vim.lsp.config("pyright", {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
					extraPaths = { "." },
					venvPath = ".",
				},
			},
		},
	})

	vim.lsp.config("protobuf_language_server", {
		cmd = { "protobuf-language-server" },
		filetypes = { "proto", "cpp" },
		root_dir = vim.fs.root(0, { ".jj", ".git" }),
		single_file_support = true,
		settings = {},
	})

	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	vim.lsp.config("rust-analyzer", {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		settings = {
			["rust-analyzer"] = {
				imports = {
					granularity = { group = "module" },
					prefix = "self",
				},
				cargo = {
					buildScripts = { enable = true },
				},
				procMacro = { enable = true },
			},
		},
	})

	vim.lsp.config("bashls", {
		cmd = { "bash-language-server", "start" },
		filetypes = { "bash", "sh", "zsh" },
	})

	vim.lsp.config("marksman", {})
	vim.lsp.config("gopls", {})
	vim.lsp.config("clangd", {})
	vim.lsp.config("cmake", {})

	local ls_to_setup = {
		"pyright",
		"clangd",
		"lua_ls",
		"cmake",
		"rust-analyzer",
		"gopls",
		"bashls",
		"marksman",
		"protobuf_language_server",
	}

	for _, server in ipairs(ls_to_setup) do
		vim.lsp.enable(server)
	end

	-- vim.lsp.set_log_level("off")
	vim.lsp.set_log_level("WARN")

	function hoverLook()
		vim.lsp.buf.hover({
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		})
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "LSP actions",
		callback = function(event)
			local opts = { buffer = event.buf }

			-- set
			vim.keymap.set("n", "<C-k>", hoverLook, opts)
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)

			-- has split in dir
			-- returns the id if exists
			--  else -1
			local function has_split(dir)
				local win1 = vim.api.nvim_get_current_win()
				vim.cmd("wincmd " .. dir)
				local win2 = vim.api.nvim_get_current_win()
				return win1 ~= win2 and win2 or -1
			end

			local function open()
				local win1 = vim.api.nvim_get_current_win()

				-- pos
				local buf = vim.api.nvim_get_current_buf()
				local cursor = vim.api.nvim_win_get_cursor(win1)

				-- if has split in either dir
				local left = has_split("h")
				local right = has_split("l")

				local function follow(other)
					vim.api.nvim_win_set_buf(other, buf)
					vim.api.nvim_win_set_cursor(other, cursor)
					vim.api.nvim_set_current_win(other)
				end

				if left ~= -1 then
					-- left
					follow(left)
				elseif right ~= -1 then
					-- right
					follow(right)
				else
					-- no split, we make
					vim.cmd("vsplit")
				end

				-- jump
				vim.cmd("lua vim.lsp.buf.definition()")
			end

			-- ga (gives char hex and octal)

			-- open buffer in side bar and goto
			vim.keymap.set("n", "<C-w>K", open, opts)

			-- code actions
			vim.keymap.set("n", "ge", vim.lsp.buf.code_action, {})
			vim.keymap.set("v", "ge", function()
				vim.lsp.buf.code_action({ range = vim.api.nvim_buf_get_extmark_by_id(0, "visual_selection", 0, 0, {}) })
			end, {})

			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
			vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
			vim.keymap.set("n", "gk", "<cmd>cexpr []<cr><cmd>lua vim.lsp.buf.references()<cr>", opts)
			vim.keymap.set("n", ";r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
			vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
		end,
	})

	vim.lsp.buf.hover({ border = "rounded" })

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		signs = {
			severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.INFO },
			text = {
				[vim.diagnostic.severity.ERROR] = "●",
				[vim.diagnostic.severity.WARN] = "●",
				[vim.diagnostic.severity.HINT] = "●",
				[vim.diagnostic.severity.INFO] = "●",
			},
		},
		virtual_lines = false,
		underline = false,
		update_in_insert = true,
		float = { border = "rounded" },
	})
end
