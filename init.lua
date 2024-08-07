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

-- windows
vim.o.splitbelow = true
vim.o.splitright = true

-- file navigation
vim.api.nvim_set_keymap('i', '<C-c>', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', '<Cmd>Exp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', "<C-^>", { noremap = true, silent = true })

-- non overwrite registers
vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>d', '"_d', { noremap = true, silent = true })

-- emacs mappings
vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-n>', '<Down>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-p>', '<Up>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-a>', '<ESC>I', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-e>', '<ESC>A', {noremap = true, silent = true})

-- pairing mapping
vim.api.nvim_set_keymap('i', '"', '""<left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', "'", "''<left>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '(', '()<left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '[', '[]<left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '{', '{}<left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '{;<CR>', '{<CR>};<ESC>O', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '{ ', '{}<Left><Space><Left><Space>', {noremap = true, silent = true})

-- vertical movement
vim.api.nvim_set_keymap('n', 'H', '4k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', '4j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', 'H6k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', 'L6j', { noremap = true, silent = true })

-- vertical movement
vim.api.nvim_set_keymap('v', 'H', '4k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'L', '4j', { noremap = true, silent = true })

vim.cmd.colorscheme "tokyonight"

