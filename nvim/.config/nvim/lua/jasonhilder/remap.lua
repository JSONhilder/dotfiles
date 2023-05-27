vim.g.mapleader = " ";

vim.keymap.set("i", "<C-l>", "<Esc>")
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
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action() <CR>", { desc = "Code actions" })
vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename() <CR>", { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cf", ":lua vim.lsp.buf.format() <CR>", { desc = "Format code" })

-- Terminal mode
vim.keymap.set('t', '<C-w>h', "<C-\\><C-n><C-w>h", { silent = true })
