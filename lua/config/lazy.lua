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
		{ "sainnhe/gruvbox-material" },
		{ "Mofiqul/dracula.nvim" },
		{ "projekt0n/github-nvim-theme" },
		{ "rose-pine/neovim" },
		{ "folke/tokyonight.nvim" },
		{ "rebelot/kanagawa.nvim" },

		-- lsp manager
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- base lsp
		{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
		{ "neovim/nvim-lspconfig" },

		-- completion and suggestions
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "L3MON4D3/LuaSnip" },
		{
			"ray-x/lsp_signature.nvim",
			event = "VeryLazy",
			opts = {},
			config = function(_, opts)
				require("lsp_signature").setup(opts)
			end,
		},

		-- formatter
		{ "stevearc/conform.nvim", opts = {} },

		-- tree-siter
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-treesitter/nvim-treesitter-context" },

		-- comment
		{ "numToStr/Comment.nvim", opts = {} },

		-- playtime
		{ "Aityz/usage.nvim" },

		-- fuzzy finder
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

----------------------------------------------lsp setup--------------------------------------------------
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	signs = false,
	underline = true,
	update_in_insert = false,
})

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
	mapping = {
		["<C-n>"] = {
			c = cmp.config.disable,
		},
		["<C-p>"] = {
			c = cmp.config.disable,
		},
		["<C-e>"] = {
			c = cmp.config.disable,
		},
		["<TAB>"] = {
			i = cmp.mapping.confirm({ select = true }),
		},
		["<C-Space>"] = {
			i = cmp.mapping.complete(),
		},
	},
	-- completion = {
	-- 	autocomplete = false,
	-- },
	performance = {
		debounce = 60,
		throttle = 30,
		fetching_timeout = 200,
		max_view_entries = 3, -- Show only the first 5 suggestions
	},
	sources = {
		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				local res = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
				return res == "Function" or res == "Text"
			end,
		},
	},
})

require("lsp_signature").setup({
	hint_enable = false,
})

-------------------------------------------tree-sitter setup--------------------------------------------------
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
		default_format_opts = {
			lsp_format = "fallback",
		},
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_set_keymap("n", "==", "gq", { noremap = true, silent = true })
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

-------------------------------------------usage setup--------------------------------------------------
require("usage").setup({
	mode = "float", -- One of "float", "notify", or "print"
})

-------------------------------------------fuzzy finder setup--------------------------------------------
require("telescope").setup({
	defaults = {
		layout_config = {
			horizontal = {
				preview_cutoff = 0,
			},
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
