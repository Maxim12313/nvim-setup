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

require("config.misc")
require("config.harpoon")
require("config.git")
require("config.search")
require("config.lsp_config")
require("config.conform")
require("config.suggest")
require("config.ufo")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- themes
		{ "widatama/vim-phoenix" },
		{ "yorickpeterse/vim-paper" },
		{ "NLKNguyen/papercolor-theme" },
		{ "Mofiqul/vscode.nvim" },
		{ "maxmx03/solarized.nvim" },

		-- fold
		{
			"kevinhwang91/nvim-ufo",
			dependencies = "kevinhwang91/promise-async",
			init = ufo_init,
			event = "BufReadPost",
			config = ufo_setup,
		},
		-- rainbow coded params etc
		{ "hiphish/rainbow-delimiters.nvim", event = "BufReadPost", config = rainbow_setup },

		-- toggle bool
		{ "nat-418/boole.nvim", event = "BufReadPost", config = bool_setup },

		{
			"Wansmer/treesj",
			keys = { "<C-h>", "<C-H>" },
			dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
			config = treejs_setup,
		},

		--
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = "VeryLazy",
			config = harpoon_setup,
		},
		{ "rcarriga/nvim-notify", event = "VeryLazy", config = notify_setup },

		-- hub + icons
		{
			"stevearc/oil.nvim",
			config = oil_setup,
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
		},

		-- debugger
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			event = "VeryLazy",
			config = debug_setup,
		},

		-- find and replace
		{ "nvim-pack/nvim-spectre", cmd = { "Spectre" }, config = spectre_setup },

		-- LSP
		{
			"neovim/nvim-lspconfig",
			event = "BufReadPre",
			dependencies = {
				"williamboman/mason.nvim",
				"Decodetalkers/csharpls-extended-lsp.nvim",
			},
			config = lsp_setup_config,
		},

		-- formatter
		{ "stevearc/conform.nvim", event = "BufWritePre", opts = {}, config = conform_setup },

		-- completion
		{
			"hrsh7th/nvim-cmp",
			event = "BufReadPost",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"saadparwaiz1/cmp_luasnip",
				"L3MON4D3/LuaSnip",
				"rafamadriz/friendly-snippets",
				"ray-x/lsp_signature.nvim",
			},
			config = suggestion_setup,
		},

		-- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			build = ":TSUpdate",
			event = "BufReadPre",
			dependencies = { "nvim-treesitter/nvim-treesitter-context" },
			config = treesitter_setup,
			keys = telescope_keys,
		},

		-- comment
		{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {}, config = comment_setup },

		-- search
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"folke/todo-comments.nvim",
				"folke/trouble.nvim",
				"mollerhoj/telescope-recent-files.nvim",
			},
			event = { "BufReadPre" },
			cmd = { "Telescope" },
			config = telescope_setup,
		},

		-- editing helpers
		{ "windwp/nvim-autopairs", event = "InsertEnter", config = autopairs_setup },
		{ "windwp/nvim-ts-autotag", event = "InsertEnter", config = autotag_setup },
		{ "kylechui/nvim-surround", event = "InsertEnter", config = surround_setup },

		-- status line
		{ "nvim-lualine/lualine.nvim" },

		-- cpp / contest
		{
			"kawre/leetcode.nvim",
			build = ":TSUpdate html",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
			},
			lazy = "leetcode.nvim" ~= vim.fn.argv(0, -1),
			opts = { arg = "leetcode.nvim", lang = "python3" },
			init = cpp_setup,
		},

		-- vcs
		{
			"lewis6991/gitsigns.nvim",
			event = "VeryLazy",
			dependencies = {
				"rafikdraoui/jj-diffconflicts",
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
				"nvim-telescope/telescope.nvim",
			},
			config = git_setup,
		},
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
})
