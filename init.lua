require("config.lazy")
-- must have options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.scrolloff = 8
vim.o.guifont = "Input Mono 13"
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.wrap = false
vim.o.ignorecase = true
-- vim.g.python3_host_prog = "/Users/maximkim/.config/nvim/env/bin/python3"
vim.o.numberwidth = 12
vim.o.winheight = 10
vim.o.signcolumn = "yes"
vim.o.showtabline = 2

vim.o.list = false
vim.o.listchars = "tab:> ,trail:·,nbsp:+"
vim.opt.fillchars = { eob = " " }

vim.o.cursorline = false

-- vim.lsp.set_log_level("off")

-- cursor
vim.o.guicursor = "n-c-i-ve-ci-v:block,r-cr-o:hor20"
-- vim.o.guicursor = "n-c-i-ve-ci-v:blinkon10"

-- indent
-- Default to 4 spaces per tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Use 2 spaces per tab for HTML, CSS, and JavaScript
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"cmake",
	},
	command = "setlocal tabstop=2 shiftwidth=2",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.opt_local.cindent = true
		vim.opt_local.cinoptions = "l1,(s"
		vim.opt_local.cinwords = "if,else,switch,case,for,while,do"
	end,
})

-- windows
vim.o.splitbelow = true
vim.o.splitright = true

-- work on this

-- vim.keymap.set("n", "<C-w>l", "<C-w>l:vertical resize 100<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-w>h", "<C-w>h:vertical resize 100<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-w>k", "<C-w>k:horizontal resize 25<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-w>j", "<C-w>j:horizontal resize 25<CR>", { noremap = true, silent = true })
--
vim.keymap.set("n", ";q", "<C-^>")

-- misc

vim.keymap.set("n", "<C-Space>", "<NOP>")
vim.keymap.set("i", "<C-c>", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", "_", ":e!<CR>", { noremap = true, silent = true })

-- non overwrite registers
vim.keymap.set("v", "P", '"_dP', { noremap = true, silent = true })
vim.keymap.set("v", "C", '"_c', { noremap = true, silent = true })
vim.keymap.set("v", "D", '"_d', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>p", '"_dP', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", '"_c', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true, silent = true })

--insert editing bindings
vim.keymap.set("i", "<C-f>", "<Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-b>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-n>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-p>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<C-o>I", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = true })

vim.keymap.set("i", "<A-b>", "<S-Left>")
vim.keymap.set("i", "<A-f>", "<S-Right>")
vim.keymap.set("i", "<C-d>", "<delete>")

-- for delete
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("c", "<A-BS>", "<C-w>", { noremap = true, silent = true })

-- command
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-a>", "<C-o>I")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<A-BS>", "<C-w>")

vim.keymap.set("c", "<A-b>", "<S-Left>")
vim.keymap.set("c", "<A-f>", "<S-Right>")
vim.keymap.set("c", "<C-d>", "<Delete>")

-- vertical movement
vim.keymap.set("n", "K", "5k", { noremap = true, silent = true })
vim.keymap.set("n", "J", "5j", { noremap = true, silent = true })
vim.keymap.set("v", "K", "5k", { noremap = true, silent = true })
vim.keymap.set("v", "J", "5j", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-e>", "10<C-e>", { noremap = true })
-- vim.keymap.set("v", "<C-e>", "10<C-e>", { noremap = true })
-- vim.keymap.set("n", "<C-y>", "10<C-y>", { noremap = true })
-- vim.keymap.set("v", "<C-y>", "10<C-y>", { noremap = true })

-- indent
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })

-- quick fix better defaults

function deleteItemsQF()
	local items = vim.fn.getqflist()
	local line = vim.fn.line(".")
	table.remove(items, line)
	vim.fn.setqflist(items, "r")
	vim.api.nvim_win_set_cursor(0, { line, 0 })
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR><C-w>j", true, true, true), "n", true)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "j", "j<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "k", "k<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "J", "5j<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "K", "5k<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "D", deleteItemsQF, { buffer = 0, noremap = true })
	end,
})

-- if exists fg, then preserve it when changing
local function setBG(group, bg_color)
	local current_hl = vim.api.nvim_get_hl_by_name(group, true)
	local fg_color = current_hl.foreground or "NONE"
	vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
end

local function themeChanges()
	vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", fg = "NONE" })

	-- print("theme changed!")
	local theme
	if vim.opt.background:get() == "light" then
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#FF00FF" })
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#495057" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#D0E0E3", blend = 50 })
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#D0E0E3", blend = 50 })
		vim.api.nvim_set_hl(0, "Normal", { bg = "#F7F7F7", fg = "#495057" })
		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#D2691E" })

		vim.api.nvim_set_hl(0, "leetcode_dyn_p", { fg = "#000000" })
		vim.api.nvim_set_hl(0, "leetcode_dyn_pre", { fg = "#000000" })
		vim.api.nvim_set_hl(0, "leetcode_ok", { fg = "#77B254" })
		vim.api.nvim_set_hl(0, "leetcode_case_ok", { fg = "#77B254" })
		vim.api.nvim_set_hl(0, "leetcode_case_focus_ok", { bg = "#77B254", fg = "#000000" })

		-- local normal = "#F7F7F7"
		local normal = "#FFFFFF"
		vim.api.nvim_set_hl(0, "Normal", { bg = normal, fg = "#000000" })
		setBG("SignColumn", normal)
		setBG("LineNr", normal)
		setBG("NormalNC", normal)
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = normal, fg = "#cc0000" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = normal, fg = "#e0af00" })
		setBG("DiagnosticSignHint", normal)

		local line = "#E7E7E7"
		setBG("CursorLineNr", line)
		setBG("CursorLine", line)
		setBG("TelescopeSelection", line)
		theme = "iceberg_light"
	else
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#FF66CC" })
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#FFFFFF" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#335E5E", blend = 80 })
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#335E5E", blend = 80 })

		-- local normal = "#2A2B2F"
		local normal = "#212229"
		-- local normal = "#1A1B1F"

		-- vim.api.nvim_set_hl(0, "Normal", { bg = normal, fg = "#FFFFFF" })
		setBG("Normal", normal)
		setBG("SignColumn", normal)
		setBG("LineNr", normal)
		setBG("NormalNC", normal)
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = normal, fg = "#ff5f5f" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = normal, fg = "#e0af00" })
		setBG("DiagnosticSignInfo", normal)
		setBG("DiagnosticSignHint", normal)

		vim.api.nvim_set_hl(0, "Search", { bg = "#FFD700", fg = "#000000", bold = true }) -- Normal search highlight
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ffb86c", fg = "#282a36", bold = true }) -- While typing in search mode

		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFD700", bg = "#335E5E" })

		vim.api.nvim_set_hl(0, "leetcode_dyn_p", { fg = "#B0B0B0" })
		vim.api.nvim_set_hl(0, "leetcode_dyn_pre", { fg = "#B0B0B0" })
		vim.api.nvim_set_hl(0, "leetcode_ok", { fg = "#228B22" })
		vim.api.nvim_set_hl(0, "leetcode_case_ok", { fg = "#228B22" })
		vim.api.nvim_set_hl(0, "leetcode_case_focus_ok", { bg = "#228B22", fg = "#FFFFFF" })

		setBG("CursorLine", "#2f323b")
		setBG("CursorLineNr", "#2f323b")
		setBG("TelescopeSelection", "#3a3d45")
		theme = "iceberg_dark"
	end

	vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
	vim.api.nvim_set_hl(0, "@parameter", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@variable.parameter", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
	vim.api.nvim_set_hl(0, "@member", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@property", { link = "Identifier" })

	require("lualine").setup({
		options = {
			theme = theme,
			component_separators = "",
			section_separators = "",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "filename", path = 1 } },
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
				},
			},
			lualine_x = { "filetype" },
			lualine_y = { "" },
			lualine_z = { "" },
		},
	})

	-- set cursor to default terminal
	vim.cmd("highlight Cursor guifg=NONE guibg=NONE")

	-- Remove italic and bold from all highlight groups
	for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
		local highlight = vim.api.nvim_get_hl_by_name(group, true)
		if highlight then
			highlight.italic = nil
			highlight.bold = nil
			vim.api.nvim_set_hl(0, group, highlight)
		end
	end
end

function toggleLightDark()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	themeChanges()
end

vim.keymap.set("n", "<leader>wr", toggleLightDark)

vim.api.nvim_create_autocmd("Colorscheme", {
	callback = themeChanges,
})
vim.cmd.colorscheme("vscode")
