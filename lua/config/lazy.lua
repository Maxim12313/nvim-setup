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


		-- lsp manager
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},

		-- base lsp
		{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
		{'neovim/nvim-lspconfig'},

		-- completion and suggestions
		-- {'hrsh7th/cmp-nvim-lsp'},
		-- {'hrsh7th/nvim-cmp'},
		-- {'L3MON4D3/LuaSnip'},

		-- formatter
		{ 'stevearc/conform.nvim', opts = {}, },

		-- tree-siter
		{ 'nvim-treesitter/nvim-treesitter' },
		{ 'nvim-treesitter/nvim-treesitter-context' },

		-- comment
		{ 'numToStr/Comment.nvim', opts = {}},

		-- playtime
		{
			"Aityz/usage.nvim",
			config = function()
				require('usage').setup()
			end
		}

	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})


----------------------------------------------lsp setup--------------------------------------------------
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	signs = false,
	underline = true,
	update_in_insert = false,
})

----------------------------------------------mason setup--------------------------------------------------
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

-------------------------------------------tree-sitter setup--------------------------------------------------
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })


-------------------------------------------conform setup--------------------------------------------------
require("conform").setup({
	formatters_by_ft = {
		cpp = { 'clang-format' }
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_set_keymap('n', '==', 'gq', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '=', 'gq', { noremap = true, silent = true })


-------------------------------------------comment setup--------------------------------------------------
require('Comment').setup({
	toggler = {
		line = "<C-s>"
	},
	opleader = {
		line = "<C-s>"
	}
})

-------------------------------------------usage setup--------------------------------------------------
require("usage").setup({
    mode = "float" -- One of "float", "notify", or "print"
})

