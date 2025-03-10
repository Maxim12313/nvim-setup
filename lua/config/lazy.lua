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
		{ "sainnhe/sonokai" },
		{ "navarasu/onedark.nvim" },
		{ "jacoborus/tender.vim" },
		{ "tanvirtin/monokai.nvim" },
		{ "ellisonleao/gruvbox.nvim" },
		{ "neanias/everforest-nvim" },
		{ "ishan9299/nvim-solarized-lua" },
		{ "projekt0n/github-nvim-theme" },
		{ "Shatur/neovim-ayu" },
		{ "Mofiqul/vscode.nvim" },
		{ "folke/tokyonight.nvim" },

		{
			"Wansmer/treesj",
			dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		},
		{
			"folke/zen-mode.nvim",
			opts = {
				window = {
					backdrop = 0.8,
				},
				plugins = {
					options = {
						laststatus = 1,
					},
					gitsigns = {
						enabled = true,
					},
				},
			},
		},

		{
			"vhyrro/luarocks.nvim",
			priority = 1001, -- this plugin needs to run before anything else
			opts = {
				rocks = { "magick" },
			},
		},

		-- peak lines
		{
			"nacro90/numb.nvim",
			config = function()
				require("numb").setup()
			end,
		},

		-- lsp manager
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- base lsp
		{ "neovim/nvim-lspconfig" },

		-- completion and suggestions
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		{ "ray-x/lsp_signature.nvim" },
		{ "luckasRanarison/tailwind-tools.nvim", lazy = true },
		{ "brenoprata10/nvim-highlight-colors", lazy = true },

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
		{ "windwp/nvim-ts-autotag", lazy = true },

		-- file navigation harpoon
		-- {
		-- 	"ThePrimeagen/harpoon",
		-- 	branch = "harpoon2",
		-- },
		{
			"akinsho/bufferline.nvim",
			version = "*",
			dependencies = "nvim-tree/nvim-web-devicons",
		},

		-- surround editing
		{ "kylechui/nvim-surround" },

		-- debugger
		-- { "mfussenegger/nvim-dap" },
		-- { "rcarriga/nvim-dap-ui" },

		-- persistence
		{
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			opts = {
				-- add any custom options here
			},
		},

		{
			"nvimdev/dashboard-nvim",
			event = "VimEnter",
			dependencies = { { "nvim-tree/nvim-web-devicons" } },
		},

		-- files
		-- { "stevearc/oil.nvim" },
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			},
		},

		-- status line
		{ "nvim-lualine/lualine.nvim" },

		-- cpp
		{
			"xeluxee/competitest.nvim",
			dependencies = "MunifTanjim/nui.nvim",
			lazy = true,
		},

		-- leetcode
		{
			"kawre/leetcode.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
				-- "ibhagwan/fzf-lua",
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
			},
			opts = {
				-- image_support = true,
				lang = "python3",
				injector = {
					python3 = {
						before = {
							"from typing import List, Dict",
							"from collections import defaultdict",
							"from sortedcontainers import SortedDict, SortedSet",
						},
					},
					cpp = {
						before = { "#include <bits/stdc++.h>", "using namespace std;" },
						after = "int main() {}",
					},
					java = {
						before = "import java.util.*;",
					},
				},
				storage = {
					home = "~/cpp/leetcode",
					cache = vim.fn.stdpath("cache") .. "/leetcode",
				},
			},
		},

		-- git
		{ "lewis6991/gitsigns.nvim", lazy = true },
		{ "tpope/vim-fugitive", lazy = true },
		--
		-- {
		-- 	"3rd/image.nvim",
		-- 	build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		-- 	opts = {},
		-- },
		-- run jupyter in md
		{
			"benlubas/molten-nvim",
			version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
			dependencies = { "3rd/image.nvim" },
			build = ":UpdateRemotePlugins",
			init = moltSetup,
		},
		-- lsp for md
		{
			"quarto-dev/quarto-nvim",
			dependencies = {
				"jmbuhr/otter.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			ft = { "markdown", "qmd", "ipynb" },
		},
		-- convert between jupyter md
		{
			"GCBallesteros/jupytext.nvim",
			config = true,
			lazy = false,
		},

		-- games
		{
			"Eandrju/cellular-automaton.nvim",
		},
		{
			"nvzone/typr",
			dependencies = "nvzone/volt",
			opts = {},
			cmd = { "Typr", "TyprStats" },
		},

		-- {
		-- 	"dccsillag/magma-nvim",
		-- 	build = ":UpdateRemotePlugins",
		-- },
		-- off
		-- { "rktjmp/lush.nvim" },
		-- { "nvim-treesitter/playground" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
})

vim.keymap.set("n", "<leader>fml1", ":CellularAutomaton game_of_life<CR>", { silent = true })
vim.keymap.set("n", "<leader>fml2", ":CellularAutomaton make_it_rain<CR>", { silent = true })
vim.keymap.set("n", "<leader>fml3", ":CellularAutomaton scramble<CR>", { silent = true })
----------------------------------------------lsp setup--------------------------------------------------

local tsj = require("treesj")
tsj.setup({
	use_default_keymaps = false,
})
vim.keymap.set("n", "<C-j>", ":lua require('treesj').toggle()<CR>", { silent = true })

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
		vim.keymap.set("n", "gr", "<cmd>cexpr []<cr><cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gu", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set("n", "L", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
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
	severity_sort = true,
	-- virtual_text = {
	-- 	prefix = "▲",
	-- 	severity = {
	-- 		min = vim.diagnostic.severity.ERROR,
	-- 	},
	-- },
	signs = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	virtual_lines = false,
	underline = false,
	-- underline = {
	-- 	severity = {
	-- 		min = vim.diagnostic.severity.WARN,
	-- 		max = vim.diagnostic.severity.ERROR,
	-- 	},
	-- },
	update_in_insert = false,
	float = { border = "rounded" },
})

vim.fn.sign_define("DiagnosticSignError", { text = "●", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "●", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "●", texthl = "DiagnosticSignHint" })

require("tailwind-tools").setup({})

----------------------------------------------mason setup--------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"lua_ls",
		"ts_ls",
		"html",
		"cssls",
		"jdtls",
		"clangd",
	},
	handlers = {
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities, -- Apply to all LSPs
			})
		end,
	},
})

lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})
lspconfig.verible.setup({
	cmd = { "verible-verilog-ls" },
	root_dir = function(fname)
		return vim.fn.getcwd() -- Use current working directory
	end,
	settings = {
		verible = {
			lint = {
				arguments = { "--rules=-no-tabs" }, -- Customize enabled rules
			},
		},
	},
})

----------------------------------------------suggestion setup--------------------------------------------------
local cmp = require("cmp")
local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load() -- friendly snipp
ls.filetype_extend("javascript", { "javascriptreact", "html", "css" }) -- Extending for CSS
ls.filetype_extend("markdown", { "plaintext", "mdx", "latex" })

require("nvim-highlight-colors").setup({})

cmp.setup({
	formatting = {
		format = require("nvim-highlight-colors").format,
	},
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-n>"] = cmp.config.disable,
		["<C-p>"] = cmp.config.disable,
		["<C-e>"] = cmp.config.disable,
		["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-l>"] = cmp.mapping.select_next_item(),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	performance = {
		debounce = 60,
		throttle = 30,
		fetching_timeout = 200,
		max_view_entries = 4,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

require("lsp_signature").setup({
	floating_window = true,
	floating_window_above_cur_line = true,
	max_height = 3,
	hint_enable = false,
})

-------------------------------------------tree-sitter setup--------------------------------------------
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
})
-- vim.api.nvim_set_hl(0, "@variable.parameter", { link = "Identifier" })

require("treesitter-context").setup({
	max_lines = 2,
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-------------------------------------------conform setup--------------------------------------------------
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "ruff_format" },
		javascript = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		["_"] = { "trim_whitespace" },
		["verible-verilog-format"] = {
			args = { "--wrap_ports=0" },
		},
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

-------------------------------------------fuzzy finder setup--------------------------------------------
local telescope = require("telescope")
telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				width = 0.90,
				height = 0.95,
				preview_cutoff = 0,
				preview_width = 0.6,
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
vim.keymap.set("n", "<leader>f", builtin.buffers)
vim.keymap.set("n", ";f", builtin.find_files)
vim.keymap.set("n", ";c", function()
	builtin.diagnostics({ severity_limit = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "<leader>g", builtin.live_grep)

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

vim.keymap.set("n", ";t", "<CMD>Trouble diagnostics toggle<CR>")
-------------------------------------------todo setup--------------------------------------------
local todo = require("todo-comments").setup({
	signs = false,
})

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", ";g", "<CMD>TodoTelescope<CR>")

-------------------------------------------scrolling setup--------------------------------------------

neoscroll = require("neoscroll")

neoscroll.setup({
	easing = "linear",
	cursor_scrolls_alone = true,
	mappings = {},
})

local keymap = {
	["<C-u>"] = function()
		neoscroll.scroll(-0.25, { move_cursor = false, duration = 75 })
	end,
	["<A-Right>"] = function()
		neoscroll.scroll(0.25, { move_cursor = false, duration = 75 })
	end,
	["<M-f>"] = function()
		neoscroll.scroll(0.25, { move_cursor = false, duration = 75 })
	end,
	["<C-b>"] = function()
		neoscroll.ctrl_u({ duration = 100 })
	end,
	["<C-f>"] = function()
		neoscroll.ctrl_d({ duration = 100 })
	end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
	vim.keymap.set(modes, key, func)
end

-------------------------------------------autopairs setup--------------------------------------------
local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.setup({
	map_bs = false, -- map the <BS> key
	map_c_w = true, -- Map the <C-h> key to delete a pair
	check_ts = true, -- Enable treesitter integration
	enable_afterquote = false, -- add bracket pairs after quote
	fast_wrap = {
		map = "<C-j>",
		end_key = "l",
		manual_position = false,
		keys = "asdfghjk",
		-- cursor_pos_before = treu,
	},
	ignored_next_char = "[%w%(%{%[%'%\"]",
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

function rule1(a1, ins, a2, lang)
	autopairs.add_rule(Rule(ins, ins, lang)
		:with_pair(function(opts)
			return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
		end)
		:with_move(cond.none())
		:with_cr(cond.none())
		:with_del(function(opts)
			local col = vim.api.nvim_win_get_cursor(0)[2]
			return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
		end))
end
rule1("(", " ", ")")
rule1("{", " ", "}")
rule1("[", " ", "]")

-- vim.keymap.set("i", "{;<CR>", "{<DOWN>;<UP>")

-- autopairs.remove_rule("{")
-- better { rules
-- vim.keymap.set("i", "{", "{}<left>", { noremap = true, silent = true })
-- vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true, silent = true })
vim.keymap.set("i", "@{<CR>", "{<CR>};<ESC>O", { noremap = true, silent = true })
-- vim.keymap.set("i", "{,<CR>", "{<CR>},<ESC>O", { noremap = true, silent = true })
-- vim.keymap.set("i", "{ ", "{}<Left><Space><Left><Space>", { noremap = true, silent = true })
--

require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
})

-------------------------------------------file navigation setup--------------------------------------------

require("bufferline").setup({
	options = {
		-- Custom sorting, most recent on the left
		tab_size = 18,
		sort_by = "insert_at_end",
		show_buffer_icons = true,
		diagnostics = "nvim_lsp",
		color_icons = true,
		always_show_bufferline = false,
		auto_toggle_bufferline = true,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})

vim.keymap.set("n", ";q", "<C-^>", { noremap = true, silent = true })
vim.keymap.set("n", ";e", "<CMD>BufferLineTogglePin<CR>")
vim.keymap.set("n", ";r", "<CMD>bd<CR>")
vim.keymap.set("n", ";w", "<CMD>BufferLineCloseOthers<CR>")
vim.keymap.set("n", ";d", "<CMD>BufferLineMoveNext<CR>")
vim.keymap.set("n", ";a", "<CMD>BufferLineMovePrev<CR>")

for i = 1, 9 do
	local str = tostring(i)
	vim.keymap.set("n", ";" .. str, "<CMD>BufferLineGoToBuffer " .. str .. "<CR>")
end

-- local harpoon = require("harpoon")
--
-- harpoon.setup({
-- })
--
-- vim.keymap.set("n", ";a", function()
-- 	harpoon:list():add()
-- end)
-- vim.keymap.set("n", ";w", function()
-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
-- end)
--
-- vim.keymap.set("n", ";1", function()
-- 	harpoon:list():select(1)
-- end)
-- vim.keymap.set("n", ";2", function()
-- 	harpoon:list():select(2)
-- end)
-- vim.keymap.set("n", ";3", function()
-- 	harpoon:list():select(3)
-- end)
-- vim.keymap.set("n", ";4", function()
-- 	harpoon:list():select(4)
-- end)
--
-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", ";q", function()
-- 	harpoon:list():prev()
-- end)
-- vim.keymap.set("n", ";e", function()
-- 	harpoon:list():next()
-- end)

-------------------------------------------surround setup--------------------------------------------
require("nvim-surround").setup({
	move_cursor = false,
	keymaps = {
		normal = "vs",
		normal_cur = "vss",
		normal_line = "vS",
		normal_cur_line = "vSS",
		visual = "s",
		visual_line = "gs",
		delete = "ds",
		change = "cs",
		change_line = "cS",
	},
})

-------------------------------------------debugger setup--------------------------------------------
-- local dap = require("dap")
-- dap.adapters.gdb = {
-- 	type = "executable",
-- 	command = "gdb",
-- 	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
-- }
--
-- vim.keymap.set("n", "<C-l>w", function()
-- 	dap.continue()
-- end)
-- vim.keymap.set("n", "<C-l>q", function()
-- 	dap.step_over()
-- end)
-- vim.keymap.set("n", "<C-l>i", function()
-- 	dap.step_into()
-- end)
-- vim.keymap.set("n", "<C-l>o", function()
-- 	dap.step_out()
-- end)
-- vim.keymap.set("n", "<C-l>k", function()
-- 	dap.toggle_breakpoint()
-- end)
-- vim.keymap.set("n", "<C-l>j", function()
-- 	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end)
-- vim.keymap.set("n", "<C-l>r", function()
-- 	dap.repl.open()
-- end)
-- vim.keymap.set("n", "<C-l>l", function()
-- 	dap.run_last()
-- end)
-- vim.keymap.set({ "n", "v" }, "<C-l>n", function()
-- 	require("dap.ui.widgets").hover()
-- end)
-- vim.keymap.set({ "n", "v" }, "<C-l>m", function()
-- 	require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "<Leader>df", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.scopes)
-- end)

-------------------------------------------persistence setup--------------------------------------------
-- load the session for the current directory
vim.keymap.set("n", ";s", function()
	require("persistence").load()
end)

require("dashboard").setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				desc = " Session",
				group = "DiagnosticHint",
				action = "lua require('persistence').load()",
				key = "s",
			},
			{
				desc = " dotfiles",
				group = "Number",
				action = "lua vim.api.nvim_set_current_dir('~/.config/nvim'); require('telescope.builtin').find_files()",
				key = "d",
			},
		},

		change_to_vcs_root = true,
		mru = { enable = false },
		footer = { "", "", "🏆 Make the complex appear simple" }, -- footer
	},
})

vim.keymap.set("n", ";v", ":Dashboard<CR>")

-------------------------------------------file manager setup--------------------------------------------
local neotree = require("neo-tree")
neotree.setup({
	filesystem = {
		hijack_netrw_behavior = "open_current",
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true, -- Auto-refresh
		filtered_items = {
			visible = true,
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true,
		},
	},
})
vim.keymap.set("n", "-", ":Neotree toggle float reveal<CR>", { silent = true })
-- vim.keymap.set("n", "-", ":Neotree toggle current reveal<CR>", { silent = true })
-------------------------------------------cpp setup--------------------------------------------
local args = {
	"-std=c++20",
	"-g",
	"$(FNAME)",
	"-o",
	"$(FNOEXT)",
	"-Wall",
	"-Wextra",
	"-Wshadow",
	"-Wconversion",
	"-Wno-sign-conversion",
	"-Wno-sign-compare",
	"-Wfloat-equal",
	"-fsanitize=undefined",
}
require("competitest").setup({
	compile_command = {
		cpp = { exec = "g++", args = args },
		python = { exec = "pypy3" },
	},
	-- replace_received_testcases = true,
	popup_ui = {
		total_width = 0.9,
		total_height = 0.95,
		layout = {
			{
				1,
				{
					{ 1, "so" },
					{ 1, {
						{ 1, "tc" },
						{ 1, "se" },
					} },
				},
			},
			{ 1, {
				{ 1, "eo" },
				{ 1, "si" },
			} },
		},
	},
	template_file = {
		cpp = "~/cpp/template/setup.cpp",
		py = "~/cpp/template/setup.py",
	},
	received_contests_directory = "contest",
	received_problems_path = "contest",
	evaluate_template_modifiers = true,
})
vim.keymap.set("n", "<leader>q", ":CompetiTest run<CR>")
vim.keymap.set("n", "<leader>eq", ":CompetiTest receive contest<CR>")

vim.keymap.set("n", "<leader>lq", ":Leet console<CR>")
vim.keymap.set("n", "<leader>le", ":Leet run<CR>")
vim.keymap.set("n", "<leader>lw", ":Leet desc<CR>")
vim.keymap.set("n", "<leader>lf", ":Leet list<CR>")
vim.keymap.set("n", "<leader>ld", ":Leet tabs<CR>")
vim.keymap.set("n", "<leader>ls", ":Leet submit<CR>")

-------------------------------------------git setup--------------------------------------------
require("gitsigns").setup({
	current_line_blame = true,
})
-------------------------------------------image setup--------------------------------------------
-- require("image").setup({
-- 	backend = "ueberzug",
-- 	processor = "magick_rock",
-- integrations = {}, -- do whatever you want with image.nvim's integrations
-- max_width = 100, -- tweak to preference
-- max_height = 12, -- ^
-- max_height_window_percentage = math.huge, -- this is necessary for a good experience
-- max_width_window_percentage = math.huge,
-- window_overlap_clear_enabled = true,
-- window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
-- markdown = {
-- 	enabled = true,
-- 	clear_in_insert_mode = false,
-- 	download_remote_images = true,
-- 	only_render_image_at_cursor = false,
-- 	floating_windows = false, -- if true, images will be rendered in floating markdown windows
-- 	filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
-- },
-- })

-------------------------------------------molten setup--------------------------------------------

function moltSetup()
	-- these are examples, not defaults. Please see the readme
	-- vim.g.molten_image_provider = "image.nvim"
	vim.g.molten_virt_lines_off_by_1 = true
	vim.g.molten_output_win_max_height = 20
	vim.g.molten.wrap_output = true
end

local quarto = require("quarto")
quarto.setup({
	lspFeatures = {
		-- NOTE: put whatever languages you want here:
		languages = { "r", "python", "rust" },
		chunks = "all",
		diagnostics = {
			enabled = true,
			triggers = { "BufWritePost" },
		},
		completion = {
			enabled = true,
		},
	},
	keymap = {
		-- NOTE: setup your own keymaps:
		hover = "H",
		definition = "gd",
		rename = "<leader>rn",
		references = "gr",
		format = "<leader>gf",
	},
	codeRunner = {
		enabled = true,
		default_method = "molten",
	},
})

vim.keymap.set("n", "[e", "<CMD>MoltenPrev>", { desc = "prev molten", silent = true })
vim.keymap.set("n", "]e", "<CMD>MoltenNext<CR>", { desc = "next molten", silent = true })
vim.keymap.set("n", "<leader>ri", function()
	vim.cmd("MoltenInit")
	vim.cmd("QuartoActivate")
end, { desc = "init molten", silent = true })

vim.keymap.set("n", "<leader>rh", "<CMD>MoltenHideOutput<CR>", { desc = "open output window", silent = true })
vim.keymap.set("n", "<leader>re", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })

local runner = require("quarto.runner")
vim.keymap.set("n", "<leader>rq", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<leader>rw", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<leadr>ra", runner.run_all, { desc = "run all cells", silent = true })

require("jupytext").setup({
	style = "markdown",
	output_extension = "md",
	force_ft = "markdown",
	-- style = "light",
})

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
	local path = filename .. ".ipynb"
	local file = io.open(path, "w")
	if file then
		file:write(default_notebook)
		file:close()
		vim.cmd("edit " .. path)
	else
		print("Error: Could not open new notebook file for writing.")
	end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
	new_notebook(opts.args)
end, {
	nargs = 1,
	complete = "file",
})
-------------------------------------------theme setup--------------------------------------------

require("everforest").setup({
	background = "hard",
})

require("vscode").setup({
	style = "light",
})
