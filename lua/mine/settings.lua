-- must have options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.number = false
vim.o.scrolloff = 8
vim.o.guifont = "Input Mono 13"
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.wrap = false
vim.o.ignorecase = true
-- vim.g.python3_host_prog = "/Users/maximkim/.config/nvim/env/bin/python3"
vim.o.numberwidth = 3
vim.o.winheight = 10
vim.o.signcolumn = "yes"
vim.o.showtabline = 0

vim.o.list = false
vim.o.listchars = "tab:> ,trail:·,nbsp:+"
vim.opt.fillchars = { eob = " " }

vim.o.cursorline = true

-- cursor
-- vim.o.guicursor = "n-c-i-ve-ci-v:block,r-cr-o:hor20"
-- vim.o.guicursor = "n-c-i-ve-ci-v:blinkon10"
-- vim.opt.guicursor = "n-v-c:block,i:ver25,r:hor50"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- indent
-- Default to 4 spaces per tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- windows
vim.o.splitbelow = true
vim.o.splitright = true
