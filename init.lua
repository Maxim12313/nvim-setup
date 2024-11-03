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
vim.lsp.set_log_level("off")

-- cursor
vim.opt.guicursor = "n-v-i-c:block-Cursor"

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

vim.keymap.set("n", "H", ":nohlsearch<CR>", { silent = true, noremap = true })

-- misc
function toggleLightDark()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end

vim.keymap.set("n", "<leader>wr", toggleLightDark)
vim.keymap.set("i", "<C-c>", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", ";r", "<C-^>", { noremap = true, silent = true })

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

-- indent
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })

--color
vim.cmd.colorscheme("tender")

-- theme changes
local function themeChanges()
	-- set highlight orange
	vim.api.nvim_set_hl(0, "Visual", { bg = "#FFA500", blend = 80 })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#FFA500", blend = 80 })

	-- set cursor to default terminal
	vim.cmd("highlight Cursor guifg=NONE guibg=NONE")

	-- set telescope highlight color
	vim.cmd([[
        highlight TelescopeSelection guibg=#707070
    ]])

	-- Remove italic from all highlight groups
	for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
		local highlight = vim.api.nvim_get_hl_by_name(group, true)
		if highlight and highlight.italic then
			highlight.italic = nil
			vim.api.nvim_set_hl(0, group, highlight)
		end
	end
end

vim.api.nvim_create_autocmd("Colorscheme", { callback = themeChanges })
themeChanges()
