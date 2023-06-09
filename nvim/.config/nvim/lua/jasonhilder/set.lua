-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--
vim.opt.mouse = 'a'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

vim.opt.updatetime = 50

vim.o.breakindent = true

vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.o.cmdheight = 0

vim.cmd.colorscheme "mellifluous"
vim.cmd [[
    Mellifluous mountain
]]
