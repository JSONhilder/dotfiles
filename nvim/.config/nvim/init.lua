---------------------------------------------------------------------------------
-- Bootstrap Package Manager
-- https://github.com/folke/lazy.nvim `:help lazy.nvim.txt` for more info
---------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------------------------
-- [[ AUTOCMDS ]]
---------------------------------------------------------------------------------
-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
-- Clear white space on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})
-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursorGrp,
})
vim.api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)
-- cmd height 0 recording message
vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 ]]
vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 ]]

-- Vlang
vim.cmd([[au BufNewFile,BufRead *.v set filetype=vlang]])

---------------------------------------------------------------------------------
-- [[ OPTIONS ]]
---------------------------------------------------------------------------------
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

---------------------------------------------------------------------------------
-- [[ KEYMAPS ]]
---------------------------------------------------------------------------------
vim.g.mapleader = " ";

vim.keymap.set("i", "<C-l>", "<Esc>")
vim.keymap.set("i", "<M-;>", ":")
vim.keymap.set("i", "jj", "<Esc>")

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear highlights" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window management
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })

-- Buffer management
vim.keymap.set("n", "<leader>l", "<cmd>b#<CR>", { desc = "last edited buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "close buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bp<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bn<CR>", { desc = "next buffer" })

-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })

-- Move selection and format
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- File manager
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle <CR>", { desc = "Nvim Tree" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", ":Lazygit <CR>", { desc = "Lazygit" })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', '<M-a>', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', '<M-d>', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Spectre Searching
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', { desc = "Open Spectre" })
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
vim.keymap.set('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    { desc = "Search on current file" })
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { desc = "Search current word" })

-- Harpoon
vim.keymap.set("n", "<leader><leader>", ":lua require('harpoon.ui').toggle_quick_menu() <CR>", { desc = "Harpoon List" })
vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file() <CR>", { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>hh", ":lua require('harpoon.ui').nav_prev() <CR>", { desc = "Harpoon previous file" })
vim.keymap.set("n", "<leader>hl", ":lua require('harpoon.ui').nav_next() <CR>", { desc = "Harpoon next file" })

-- LSP binds
vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename() <CR>", { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cf", ":lua vim.lsp.buf.format() <CR>", { desc = "Format code" })
-- LSP binds WITH FZF
vim.keymap.set("n", "<leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { desc = "Code actions" })

-- FZF picker
vim.keymap.set("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<C-o>", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
vim.keymap.set("n", "<C-b>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<C-g>", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", { silent = true })

-- Terminal mode
vim.keymap.set('t', '<C-w>h', "<C-\\><C-n><C-w>h", { silent = true })

---------------------------------------------------------------------------------
-- [[ PLUGIN CONFIGS ]]
---------------------------------------------------------------------------------
require('lazy').setup({
    { import = 'plugins' }
})

---------------------------------------------------------------------------------
-- [[ COLORSCHEME ]]
---------------------------------------------------------------------------------
vim.cmd.colorscheme "tokyonight"

---------------------------------------------------------------------------------
-- [[ STATUSLINE ]]
---------------------------------------------------------------------------------
require("statusline")
