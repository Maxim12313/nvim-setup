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
		{ "Mofiqul/dracula.nvim" },
		{ "projekt0n/github-nvim-theme" },
		{ "rose-pine/neovim" },
		{ "folke/tokyonight.nvim" },
		{ "ribru17/bamboo.nvim" },
		{ "navarasu/onedark.nvim" },
		{ "wilmanbarrios/palenight.nvim" },
		{ "askfiy/visual_studio_code" },


		-- lsp manager
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- base lsp
		{ "neovim/nvim-lspconfig" },

		-- completion and suggestions
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "L3MON4D3/LuaSnip" },
		{
		  "ray-x/lsp_signature.nvim",
		  event = "VeryLazy",
		  opts = {},
		  config = function(_, opts) require'lsp_signature'.setup(opts) end
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

		-- folder
		{'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'},

		-- todo comments
		{ "folke/todo-comments.nvim" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

----------------------------------------------lsp setup--------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts) 
  end
})

vim.diagnostic.config({
	virtual_text = {
		prefix = '▲',
		severity = { 
			min = vim.diagnostic.severity.ERROR,
			max = vim.diagnostic.severity.ERROR,
		}
	},
	signs = {
		severity = { 
			min = vim.diagnostic.severity.ERROR,
			max = vim.diagnostic.severity.ERROR,
		}
	},
	virtual_lines = true,
	underline = true,
	update_in_insert = false,
	float = { border = "rounded" },
})

vim.fn.sign_define('DiagnosticSignError', { text = '●', texthl = 'DiagnosticSignError' })

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
	floating_window_above_cur_line = true,
	max_height = 2,
	floating_window_off_y = -3,
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
	default_format_opts = {
		lsp_format = "fallback",
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
vim.keymap.set("n", "<leader>f", builtin.find_files, {})


-------------------------------------------folder setup--------------------------------------------
vim.keymap.set('n', '-', 'za', { noremap = true, silent = true })
vim.keymap.set('v', '-', 'zf', { noremap = true, silent = true })
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.fillchars = [[eob: ,fold: ,foldopen:-,foldsep: ,foldclose:+]]
vim.o.foldcolumn = '0' -- '0' is not bad

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup({
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
