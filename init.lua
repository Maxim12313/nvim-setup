require("config.lazy")

-- must have options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = 'unnamed'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.guifont = 'Input Mono 13'
vim.o.swapfile = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"

-- windows
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.equalalways = true

-- file navigation
vim.keymap.set('i', '<C-c>', '<ESC>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', "<C-^>", { noremap = true, silent = true })

-- non overwrite registers
vim.keymap.set('v', '<leader>p', '"_dP', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>c', '"_c', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>d', '"_d', { noremap = true, silent = true })

--emacs bindings 
vim.keymap.set('i', '<C-f>', '<Right>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-b>', '<Left>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-n>', '<Down>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-p>', '<Up>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-a>', '<ESC>I', {noremap = true, silent = true})
vim.keymap.set('i', '<C-e>', '<ESC>A', {noremap = true, silent = true})
vim.keymap.set('i', '<C-k>', '<Right><ESC>C', { noremap = true, silent = true })
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })

--custom insert
vim.keymap.set('i', '<C-d>', '<Right><ESC>ea', { noremap = true, silent = true })
vim.keymap.set('i', '<C-h>', '<ESC>bi', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Delete>', { noremap = true, silent = true })

-- vertical movement
vim.keymap.set('n', 'K', '4k', { noremap = true, silent = true })
vim.keymap.set('n', 'J', '4j', { noremap = true, silent = true })
vim.keymap.set('v', 'K', '4k', { noremap = true, silent = true })
vim.keymap.set('v', 'J', '4j', { noremap = true, silent = true })

-- indent
vim.keymap.set('n', "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set('n', "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set('v', "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set('v', "<S-Tab>", "<gv", { noremap = true, silent = true })

--color
vim.cmd.colorscheme "tender"

