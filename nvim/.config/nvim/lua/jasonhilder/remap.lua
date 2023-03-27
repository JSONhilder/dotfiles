vim.g.mapleader = " ";

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window management
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Move to left split"})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Move to below split"})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Move to above split"})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Move to right split"})
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", {desc = "Resize split up"})
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", {desc = "Resize split down"})
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", {desc = "Resize split left"})

-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })

-- File manager
vim.keymap.set("n", "<leader>e", ":Lf <CR>", { desc = "LF Filemanager" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", ":Lazygit <CR>", { desc = "Lazygit" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<CMD> Telescope find_files<CR>", { desc = "LF Filemanager" })
