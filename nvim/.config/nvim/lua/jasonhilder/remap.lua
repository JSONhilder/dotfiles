vim.g.mapleader = " ";

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

-- Buffer management
vim.keymap.set("n", "<leader>l", "<cmd>bp<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<leader>C", "<cmd>!%bd<CR><cmd>intro<CR>", { desc = "reset buffers" })
vim.keymap.set("n", "<S-h>", "<cmd>bp<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bn<CR>", { desc = "next buffer" })

-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })

-- Move selection and format
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- File manager
vim.keymap.set("n", "<leader>e", ":Lf <CR>", { desc = "LF Filemanager" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", ":Lazygit <CR>", { desc = "Lazygit" })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', '<M-a>', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', '<M-d>', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
