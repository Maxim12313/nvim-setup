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
		{ "morhetz/gruvbox" },
		{ "neanias/everforest-nvim" },
		{ "ishan9299/nvim-solarized-lua" },
		{ "projekt0n/github-nvim-theme" },
		{ "Mofiqul/vscode.nvim" },
		{ "folke/tokyonight.nvim" },

		{
			"nvim-pack/nvim-spectre",
		},

		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function()
				vim.fn["mkdp#util#install"]()
			end,
		},

		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			---@module "ibl"
			---@type ibl.config
			opts = {},
		},

		{
			"Wansmer/treesj",
			dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
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
		-- { "karb94/neoscroll.nvim" },
		{ "petertriho/nvim-scrollbar" },

		--auto pairs
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
		{ "windwp/nvim-ts-autotag", lazy = true },

		-- file navigation harpoon
		-- {
		--     "ThePrimeagen/harpoon",
		--     branch = "harpoon2",
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
				lang = "cpp",
				injector = {
					python3 = {
						before = {
							"from typing import List, Dict, Optional",
							-- "from collections import defaultdict",
							-- "from sortedcontainers import SortedDict, SortedSet",
							-- "from bisect import bisect_left, bisect_right",
						},
					},
					cpp = {
						before = { '#include "headers.hpp"' },
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
		{ "akinsho/git-conflict.nvim", version = "*", config = true },
		{ "tpope/vim-fugitive" },

		-- off
		-- { "rktjmp/lush.nvim" },
		-- { "nvim-treesitter/playground" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
})

----------------------------------------------replacer setup--------------------------------------------------
require("spectre").setup()

----------------------------------------------indent setup--------------------------------------------------
-- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "NONE", nocombine = true })
require("ibl").setup({
	enabled = true,
	indent = {
		char = "┆",
	},
	scope = {
		enabled = false,
	},
	-- whitespace = {
	-- 	remove_blankline_trail = false,
	-- },
})

----------------------------------------------lsp setup--------------------------------------------------

local tsj = require("treesj")
tsj.setup({
	use_default_keymaps = false,
})
vim.keymap.set("n", "<C-j>", ":lua require('treesj').toggle()<CR>", { silent = true })

----------------------------------------------lsp setup--------------------------------------------------
function hoverLook()
	vim.lsp.buf.hover({
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "<C-k>", hoverLook, opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>cexpr []<cr><cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", ";r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
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
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.HINT] = "●",
			[vim.diagnostic.severity.INFO] = "●",
		},
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

require("tailwind-tools").setup({})

----------------------------------------------mason setup--------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_enable = true,
})

-- lspconfig.pyright.setup({
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				typeCheckingMode = "off",
-- 			},
-- 		},
-- 	},
-- })
-- lspconfig.asm_lsp.setup({
-- 	settings = {
-- 		cmd = { "asm-lsp" },
-- 	},
-- })

----------------------------------------------suggestion setup--------------------------------------------------
local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load() -- friendly snipp
ls.filetype_extend("javascript", { "javascriptreact", "html", "css" }) -- Extending for CSS
ls.filetype_extend("markdown", { "plaintext", "mdx", "latex" })

require("nvim-highlight-colors").setup({})

local cmp = require("cmp")
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
		-- ["_"] = { "trim_whitespace" },
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
vim.keymap.set("n", ";f", builtin.find_files)
vim.keymap.set("n", ";c", function()
	builtin.diagnostics({ severity_limit = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", ";g", builtin.live_grep)

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

-- vim.keymap.set("n", ";t", "<CMD>Trouble diagnostics toggle<CR>")
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

vim.keymap.set("n", ";t", "<CMD>TodoTelescope<CR>")

-------------------------------------------scrolling setup--------------------------------------------

require("scrollbar").setup({
	show_in_active_only = true,
	handle = {
		text = " ",
		blend = 0,
		color = "#FFFFFF",
		highlight = "CursorColumn",
		hide_if_all_visible = true,
	},
	excluded_filetypes = {
		"dropbar_menu",
		"dropbar_menu_fzf",
		"DressingInput",
		"cmp_docs",
		"cmp_menu",
		"noice",
		"prompt",
		"TelescopePrompt",
		"leetcode.nvim",
	},
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = true, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
		ale = false, -- Requires ALE
	},
})

vim.keymap.set("n", "<C-u>", "10<C-y>")
vim.keymap.set("n", "<C-d>", "10<C-e>")

-------------------------------------------autopairs setup--------------------------------------------
local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.setup({
	map_bs = true, -- map the <BS> key
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
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

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

vim.keymap.set("i", "@{<CR>", "{<CR>};<ESC>O", { noremap = true, silent = true })
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
		sort_by = "insert_after_current",
		show_buffer_icons = true,
		diagnostics = "nvim_lsp",
		color_icons = true,
		-- always_show_bufferline = true,
		-- auto_toggle_bufferline = true,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})

vim.keymap.set("n", ";w", function()
	local bufferline = require("bufferline.groups")

	-- Get a list of all open buffers
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	print(vim.inspect(buffers))
end)

-- vim.keymap.set("n", ";d", "<CMD>bd<CR>")
vim.keymap.set("n", ";w", "<CMD>BufferLineCloseOthers<CR>")
vim.keymap.set("n", ";a", "<CMD>BufferLineCyclePrev<CR>")
vim.keymap.set("n", ";d", "<CMD>BufferLineCycleNext<CR>")

for i = 1, 9 do
	local str = tostring(i)
	vim.keymap.set("n", ";" .. str, "<CMD>BufferLineGoToBuffer " .. str .. "<CR>")
end

-- local harpoon = require("harpoon")
--
-- harpoon.setup({
--     settings = {
--         -- sync_on_ui_close = true,
--         save_on_toggle = true,
--     },
-- })
--
-- vim.keymap.set("n", ";e", function()
--     harpoon:list():add()
-- end)
-- vim.keymap.set("n", ";w", function()
--     harpoon.ui:toggle_quick_menu(harpoon:list())
-- end)
--
-- vim.keymap.set("n", ";1", function()
--     harpoon:list():select(1)
-- end)
-- vim.keymap.set("n", ";2", function()
--     harpoon:list():select(2)
-- end)
-- vim.keymap.set("n", ";3", function()
--     harpoon:list():select(3)
-- end)
-- vim.keymap.set("n", ";4", function()
--     harpoon:list():select(4)
-- end)
--
--
-- local harpoon_extensions = require("harpoon.extensions")
-- harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
--
-- -- basic telescope configuration
-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
--     local file_paths = {}
--     for _, item in ipairs(harpoon_files.items) do
--         table.insert(file_paths, item.value)
--     end
--
--     require("telescope.pickers")
--         .new({}, {
--             prompt_title = "Harpoon",
--             finder = require("telescope.finders").new_table({
--                 results = file_paths,
--             }),
--             previewer = conf.file_previewer({}),
--             sorter = conf.generic_sorter({}),
--         })
--         :find()
-- end
--
-- vim.keymap.set("n", ";d", function()
--     toggle_telescope(harpoon:list())
-- end, { desc = "Open harpoon window" })

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
	"-std=c++23",
	"-O0",
	"$(FNAME)",
	"-o",
	"$(FNOEXT)",
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
					{
						1,
						{
							{ 1, "tc" },
							{ 1, "se" },
						},
					},
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

local once = true

local function set_leet_keymaps()
	if not once then
		return
	end
	once = false
	vim.keymap.set("n", "<leader>lr", ":Leet random<CR>")
	vim.keymap.set("n", "<leader>lq", ":Leet console<CR>")
	vim.keymap.set("n", "<leader>le", ":Leet run<CR>")
	vim.keymap.set("n", "<leader>lw", ":Leet desc<CR>")
	vim.keymap.set("n", "<leader>lf", ":Leet list<CR>")
	vim.keymap.set("n", "<leader>ld", ":Leet tabs<CR>")
	vim.keymap.set("n", "<leader>ls", ":Leet submit<CR>")
	vim.keymap.set("n", "<leader>ll", ":Leet lang<CR>")
end

local function set_competi_keymaps()
	if not once then
		return
	end
	once = false
	vim.keymap.set("n", "<leader>le", ":CompetiTest run<CR>")
	vim.keymap.set("n", "<leader>lw", ":CompetiTest receive contest<CR>")
	vim.keymap.set("n", "<leader>lq", ":CompetiTest show_ui<CR>")
end

-- Auto-detect if a LeetCode buffer is active and change keymaps
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0) -- Get current buffer name
		if bufname:match("leetcode.nvim") then
			set_leet_keymaps() -- Apply LeetCode keymaps
		else
			set_competi_keymaps() -- Apply CompetiTest keymaps
		end
	end,
})

-------------------------------------------git setup--------------------------------------------
vim.keymap.set("n", ";z", ":Git<CR><C-w>T", { noremap = true, silent = true })
require("gitsigns").setup({
	current_line_blame = true,
})
require("git-conflict").setup({
	default_mappings = true, -- disable buffer local mapping created by this plugin
	default_commands = true, -- disable commands created by this plugin
	disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	list_opener = "copen", -- command or function to open the conflicts list
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "DiffAdd",
		current = "DiffText",
	},
	default_mappings = {
		ours = "1",
		theirs = "2",
		both = "3",
		none = "4",
		next = "<C-p>",
		prev = "<C-n>",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "GitConflictDetected",
	callback = function()
		vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
		vim.keymap.set("n", "cww", function()
			engage.conflict_buster()
			create_buffer_local_mappings()
		end)
	end,
})
-------------------------------------------theme setup--------------------------------------------

require("everforest").setup({
	background = "hard",
})

require("vscode").setup({
	style = "dark",
})
