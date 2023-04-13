vim.g.mapleader = " ";

vim.keymap.set("i", "<C-l>", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")

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
vim.keymap.set("n", "<leader>l", "<cmd>b#<CR>", { desc = "last edited buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>bd<CR>", { desc = "close buffer" })
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

-- start searching
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- MOVE TO FUNCTIONS FILE
-- The below lua script keeps track of buffers that have been "touched" (entered insert mode or modified the buffer).
-- (leader-C) will close all untouched buffers except the one you are currently in.
local id = vim.api.nvim_create_augroup("startup", {
    clear = false
})

local persistbuffer = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    vim.fn.setbufvar(bufnr, 'bufpersist', 1)
end

vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = id,
    pattern = { "*" },
    callback = function()
        vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
            buffer = 0,
            once = true,
            callback = function()
                persistbuffer()
            end
        })
    end
})

vim.keymap.set('n', '<Leader>C',
    function()
        local curbufnr = vim.api.nvim_get_current_buf()
        local buflist = vim.api.nvim_list_bufs()
        for _, bufnr in ipairs(buflist) do
            if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, 'bufpersist') ~= 1) then
                vim.cmd('bd ' .. tostring(bufnr))
            end
        end
    end, { silent = true, desc = 'Close unused buffers' })
