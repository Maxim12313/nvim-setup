require("config.lazy")
-- must have options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = "unnamed"
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.guifont = "Input Mono 13"
vim.o.swapfile = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.undofile = true
vim.g.python3_host_prog = "/Users/maximkim/.config/nvim/env/bin/python3"

-- vim.lsp.set_log_level("off")

-- cursor
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20"

-- indent
-- Default to 4 spaces per tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Use 2 spaces per tab for HTML, CSS, and JavaScript
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	command = "setlocal tabstop=2 shiftwidth=2",
})

-- windows
vim.o.splitbelow = true
vim.o.splitright = true

-- misc

vim.keymap.set("i", "<C-c>", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", ";r", "<C-^>", { noremap = true, silent = true })
vim.keymap.set("n", "_", ":e!<CR>", { noremap = true, silent = true })

function toggleQF()
	local isOpen = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			isOpen = true
		end
	end
	if isOpen then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

vim.keymap.set("n", "<leader>wq", toggleQF, { noremap = true, silent = true })
vim.keymap.set("n", "gn", ":%s/")
vim.keymap.set("n", "<leasder>j", "", { noremap = true })

-- non overwrite registers
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", '"_c', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>c", '"_c', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true, silent = true })

--insert editing bindings
vim.keymap.set("i", "<C-f>", "<Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-b>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-n>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-p>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = true })
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true, silent = true })

-- for mac system
vim.keymap.set("i", "<A-Right>", "<S-Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<A-Left>", "<S-Left>", { noremap = true, silent = true })

-- for tmux system
vim.keymap.set("i", "<M-f>", "<S-Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<M-b>", "<S-Left>", { noremap = true, silent = true })

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
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "j", "j<CR><C-w>j", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "k", "k<CR><C-w>j", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "J", "5j<CR><C-w>j", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "K", "5k<CR><C-w>j", { noremap = true, silent = true })
	end,
})

--color
vim.cmd.colorscheme("tokyonight")

-- if exists fg, then preserve it when changing
local function setBG(group, bg_color)
	local current_hl = vim.api.nvim_get_hl_by_name(group, true)
	local fg_color = current_hl.foreground or "NONE"
	vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
end

local function themeChanges()
	-- set highlight orange

	local theme
	if vim.opt.background:get() == "light" then
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#FF00FF" })
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#495057" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#D0E0E3", blend = 50 })
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#D0E0E3", blend = 50 })
		vim.api.nvim_set_hl(0, "Normal", { bg = "#F7F7F7", fg = "#495057" })
		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFD700", bg = "#D0E0E3" })
		setBG("SignColumn", "#F7F7F7")
		setBG("LineNr", "#F7F7F7")
		setBG("CursorLine", "#F0F0F0")
		setBG("TelescopeSelection", "#EDEDED")
		theme = "iceberg_light"
	else
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#FF66CC" })
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#FFFFFF" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#335E5E", blend = 80 })
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#335E5E", blend = 80 })
		vim.api.nvim_set_hl(0, "Normal", { bg = "#212229", fg = "#FFFFFF" })
		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFD700", bg = "#335E5E" })
		setBG("SignColumn", "#212229")
		setBG("LineNr", "#212229")
		setBG("CursorLine", "#2f323b")
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
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "filename", path = 1 } },
			lualine_c = { "diagnostics" },
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})

	-- set cursor to default terminal
	vim.cmd("highlight Cursor guifg=NONE guibg=NONE")

	-- Remove italic from all highlight groups
	for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
		local highlight = vim.api.nvim_get_hl_by_name(group, true)
		if highlight and highlight.italic then
			highlight.italic = nil
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

vim.api.nvim_create_autocmd("Colorscheme", { callback = themeChanges })
themeChanges()
