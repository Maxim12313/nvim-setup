-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- themes
		{ "catppuccin/nvim", name = "catppuccin" },
		{
			"sainnhe/sonokai",
			lazy = false,
			config = function()
				vim.g.gonokai_style = "atlantis"
				vim.g.sonokai_enable_italic = false
			end,
		},
		{ "projekt0n/github-nvim-theme" },
		{ "rose-pine/neovim" },
		{ "folke/tokyonight.nvim" },
		{ "navarasu/onedark.nvim" },
		{ "askfiy/visual_studio_code" },
		{ "jacoborus/tender.vim" },
		{ "tanvirtin/monokai.nvim" },

		-- lsp manager
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- base lsp
		{ "neovim/nvim-lspconfig" },

		-- completion and suggestions
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "L3MON4D3/LuaSnip" },
		{ "ray-x/lsp_signature.nvim" },

		-- formatter
		{ "stevearc/conform.nvim", opts = {} },

		-- tree-siter
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-treesitter/nvim-treesitter-context" },

		-- comment
		{ "numToStr/Comment.nvim", opts = {} },

		-- fuzzy finder
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = {
				"BurntSushi/ripgrep",
				"nvim-lua/plenary.nvim",
			},
		},

		-- diagnostcs finder
		{ "folke/trouble.nvim" },

		-- file manager
		{ "stevearc/oil.nvim" },

		-- folder
		{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

		-- todo comments
		{ "folke/todo-comments.nvim" },

		-- icons
		{ "nvim-tree/nvim-web-devicons" },

		--scrolling
		{ "karb94/neoscroll.nvim" },

		--auto pairs
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},

		-- file navigation harpoon
		{ "ThePrimeagen/harpoon" },

		-- pair binds
		{ "tpope/vim-unimpaired" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

----------------------------------------------lsp setup--------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		-- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
	end,
})

-- make hover rounded window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.diagnostic.config({
	virtual_text = false,
	-- virtual_text = {
	-- 	prefix = "▲",
	-- 	severity = {
	-- 		min = vim.diagnostic.severity.ERROR,
	-- 	},
	-- },
	signs = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
	virtual_lines = false,
	-- underline = false,
	underline = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
	update_in_insert = false,
	float = { border = "rounded" },
})

vim.fn.sign_define("DiagnosticSignError", { text = "●", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "●", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "●", texthl = "DiagnosticSignHint" })

----------------------------------------------mason setup--------------------------------------------------
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

----------------------------------------------suggestion setup--------------------------------------------------
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-n>"] = cmp.config.disable,
		["<C-p>"] = cmp.config.disable,
		["<C-e>"] = cmp.config.disable,
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	performance = {
		debounce = 60,
		throttle = 30,
		fetching_timeout = 200,
		max_view_entries = 3,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})

require("lsp_signature").setup({
	floating_window = true,
	floating_window_above_cur_line = true,
	max_height = 3,
	floating_window_off_y = -3,
	hint_enable = false,
})

-------------------------------------------tree-sitter setup--------------------------------------------
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-------------------------------------------conform setup--------------------------------------------------
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		cpp = { "clang-format" },
		python = { "ruff_format" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_set_keymap("n", "==", "gqq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "=", "gq", { noremap = true, silent = true })

-------------------------------------------comment setup--------------------------------------------------
require("Comment").setup({
	toggler = {
		line = "<C-s>",
	},
	opleader = {
		line = "<C-s>",
	},
})

-------------------------------------------file manager setup--------------------------------------------
local oil = require("oil")
oil.setup({
	view_options = {
		show_hidden = true,
	},
	skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-------------------------------------------fuzzy finder setup--------------------------------------------
local telescope = require("telescope")
telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				width = 0.90,
				height = 0.95,
				preview_cutoff = 0,
				preview_width = 0.55,
			},
		},
		file_ignore_patterns = {
			".git/",
			"%.o",
			"%.out",
			"%.dSYM/",
		},
	},
})

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)

--run relative search from oil dir if in oil or telescope curr buffer if in normal file
function relativeSearch()
	if vim.bo.filetype == "oil" then
		builtin.find_files({ cwd = oil.get_current_dir(), hidden = true })
	else
		builtin.find_files({ cwd = utils.buffer_dir(), hidden = true })
	end
end

vim.keymap.set("n", "<leader>r", relativeSearch)

require("trouble").setup({
	win = {
		size = 5,
	},
	filter = {
		severity = {
			min = vim.diagnostic.severity.WARN,
			max = vim.diagnostic.severity.ERROR,
		},
	},
})

vim.keymap.set("n", "<leader>we", "<cmd>Trouble diagnostics toggle<CR>")
vim.keymap.set("n", "<leader>wq", "copen 8")

-------------------------------------------folder setup--------------------------------------------
vim.keymap.set("n", "<leade>e", "za", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>e", "zf", { noremap = true, silent = true })
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:-,foldsep: ,foldclose:+]]
vim.o.foldcolumn = "0" -- '0' is not bad

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
	require("lspconfig")[ls].setup({
		capabilities = capabilities,
		-- you can add other fields for setting up lsp server in this table
	})
end
require("ufo").setup({
	open_fold_hl_timeout = 0,
})

-------------------------------------------todo setup--------------------------------------------
local todo = require("todo-comments").setup({
	signs = false,
})

vim.keymap.set("n", "]t", function()
	todo.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	todo.jump_prev()
end, { desc = "Previous todo comment" })

-------------------------------------------scrolling setup--------------------------------------------

neoscroll = require("neoscroll")

neoscroll.setup({
	easing = "linear",
	cursor_scrolls_alone = false,
	mappings = {},
})

local keymap = {
	["<C-u>"] = function()
		vim.cmd("normal!H")
		neoscroll.ctrl_u({ duration = 100 })
	end,
	["<A-Right>"] = function()
		vim.cmd("normal!L")
		neoscroll.ctrl_d({ duration = 100 })
	end,
	["<C-b>"] = function()
		neoscroll.ctrl_b({ duration = 300 })
	end,
	["<C-f>"] = function()
		neoscroll.ctrl_f({ duration = 300 })
	end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
	vim.keymap.set(modes, key, func)
end

-------------------------------------------autopairs setup--------------------------------------------
local autopairs = require("nvim-autopairs")
autopairs.remove_rule("{")

-- better { rules
vim.keymap.set("i", "{", "{}<left>", { noremap = true, silent = true })
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true, silent = true })
vim.keymap.set("i", "{;<CR>", "{<CR>};<ESC>O", { noremap = true, silent = true })
vim.keymap.set("i", "{,<CR>", "{<CR>},<ESC>O", { noremap = true, silent = true })
vim.keymap.set("i", "{ ", "{}<Left><Space><Left><Space>", { noremap = true, silent = true })

-------------------------------------------harpoon setup--------------------------------------------
local harpoon = require("harpoon").setup({
	tabline = true,
})
local harpoonUI = require("harpoon.ui")
local harpoonMark = require("harpoon.mark")

vim.keymap.set("n", ";a", harpoonMark.add_file)
vim.keymap.set("n", ";q", harpoonUI.nav_prev)
vim.keymap.set("n", ";e", harpoonUI.nav_next)
vim.keymap.set("n", ";w", harpoonUI.toggle_quick_menu)

for i = 1, 9 do
	vim.keymap.set("n", ";" .. i, function()
		harpoonUI.nav_file(i)
	end)
end

-------------------------------------------theme setup--------------------------------------------
require("tokyonight").setup({
	style = "storm", -- "night" or "storm"
	on_highlights = function(hl, c)
		hl.DiagnosticUnderlineWarn.undercurl = nil
		hl.DiagnosticUnderlineWarn.underline = true
		hl.DiagnosticUnderlineError.undercurl = nil
		hl.DiagnosticUnderlineError.underline = true
		hl.DiagnosticUnderlineHint.undercurl = nil
		hl.DiagnosticUnderlineHint.underline = true
	end,
})
require("visual_studio_code").setup({
	mode = "dark", -- light | dark
})

require("onedark").setup({
	highlights = {
		["@operator"] = { fg = "#89BEFA" },
	},
	diagnostics = {
		undercurl = false,
	},
})

--remove italics always
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Remove italic from all highlight groups
		for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
			local highlight = vim.api.nvim_get_hl_by_name(group, true)
			if highlight and highlight.italic then
				highlight.italic = nil
				vim.api.nvim_set_hl(0, group, highlight)
			end
		end
	end,
})

-- remove undercurls
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Function to get the existing highlight attributes
		local function get_hl(name)
			return vim.api.nvim_get_hl_by_name(name, true)
		end

		-- Update diagnostic highlight groups
		for _, group in ipairs({
			"DiagnosticUnderlineError",
			"DiagnosticUnderlineWarn",
			"DiagnosticUnderlineInfo",
			"DiagnosticUnderlineHint",
		}) do
			local hl = get_hl(group)
			vim.api.nvim_set_hl(0, group, {
				undercurl = false,
				underline = true,
				sp = hl["special"], -- Preserve the original 'sp' color
			})
		end
	end,
})
