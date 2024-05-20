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
vim.cmd([[au BufNewFile,BufRead *.v set filetype=v]])
---------------------------------------------------------------------------------
-- [[ FUNCTIONS ]]
---------------------------------------------------------------------------------
-- Function to toggle to/from a terminal buffer named "t1"
local function toggle_terminal()
    local term_buf_var = 'is_t1_terminal'
    local bufnr_t1 = nil

    -- Search for the buffer marked as 't1'
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local success, is_t1 = pcall(vim.api.nvim_buf_get_var, bufnr, term_buf_var)
        if success and is_t1 then
            bufnr_t1 = bufnr
            break
        end
    end

    if bufnr_t1 then
        -- If buffer 't1' exists, check if it's the current buffer
        if vim.api.nvim_get_current_buf() == bufnr_t1 then
            -- If current buffer is 't1', switch to the last accessed buffer
            vim.cmd("b#")
        else
            -- If not, switch to 't1'
            vim.cmd("buffer " .. bufnr_t1)
        end
    else
        -- If no buffer 't1', create it and start a terminal
        vim.cmd("enew")
        local new_bufnr = vim.api.nvim_get_current_buf()
        vim.cmd("terminal")
        vim.api.nvim_buf_set_var(new_bufnr, term_buf_var, true)  -- Mark this buffer as 't1'
        vim.cmd("startinsert")
    end
end
-- Register the function globally so it can be called from vim commands
_G.toggle_terminal = toggle_terminal
---------------------------------------------------------------------------------
-- [[ FUNCTIONS ]]
---------------------------------------------------------------------------------
-- Function to toggle to/from a terminal buffer named "t1"
local function toggle_terminal()
    local term_buf_var = 'is_t1_terminal'
    local bufnr_t1 = nil

    -- Search for the buffer marked as 't1'
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local success, is_t1 = pcall(vim.api.nvim_buf_get_var, bufnr, term_buf_var)
        if success and is_t1 then
            bufnr_t1 = bufnr
            break
        end
    end

    if bufnr_t1 then
        -- If buffer 't1' exists, check if it's the current buffer
        if vim.api.nvim_get_current_buf() == bufnr_t1 then
            -- If current buffer is 't1', switch to the last accessed buffer
            vim.cmd("b#")
        else
            -- If not, switch to 't1'
            vim.cmd("buffer " .. bufnr_t1)
        end
    else
        -- If no buffer 't1', create it and start a terminal
        vim.cmd("enew")
        local new_bufnr = vim.api.nvim_get_current_buf()
        vim.cmd("terminal")
        vim.api.nvim_buf_set_var(new_bufnr, term_buf_var, true)  -- Mark this buffer as 't1'
        vim.cmd("startinsert")
    end
end
-- Register the function globally so it can be called from vim commands
_G.toggle_terminal = toggle_terminal
---------------------------------------------------------------------------------
-- [[ OPTIONS ]]
---------------------------------------------------------------------------------
vim.g.loaded_netrw = 1                 -- Disables the default Netrw file browser
vim.g.loaded_netrwPlugin = 1           -- Disables the Netrw plugin
vim.opt.mouse = 'a'                    -- Enables mouse support in all modes
vim.opt.nu = true                      -- Enables line numbers
vim.opt.relativenumber = true          -- Displays relative line numbers in the buffer
vim.opt.tabstop = 4                    -- Sets the number of spaces that a tab character represents
vim.opt.softtabstop = 4                -- Sets the number of spaces per tab in the editor's buffer
vim.opt.shiftwidth = 4                 -- Sets the width for autoindents
vim.opt.expandtab = true               -- Converts tabs to spaces
vim.opt.smartindent = true             -- Enables intelligent autoindenting for new lines
vim.opt.wrap = false                   -- Disables text wrapping
vim.opt.swapfile = false               -- Disables swap file creation
vim.opt.backup = false                 -- Disables making a backup before overwriting a file
vim.opt.ignorecase = true              -- Makes searches case insensitive
vim.opt.smartcase = true               -- Makes searches case sensitive if there's a capital letter
vim.opt.hlsearch = true                -- Highlights all matches of the search pattern
vim.opt.incsearch = true               -- Starts searching before typing is finished
vim.opt.termguicolors = true           -- Enables true color support
vim.opt.scrolloff = 8                  -- Keeps 8 lines visible above/below the cursor
vim.opt.signcolumn = "yes"             -- Always show the sign column
vim.opt.isfname:append("@-@")          -- Allows '@' in filenames
vim.opt.clipboard = "unnamedplus"      -- Uses the system clipboard for all yank, delete, change and put operations
vim.opt.undofile = true                -- Enables persistent undo
vim.opt.updatetime = 50                -- Sets the time after which the swap file is written (in milliseconds)
vim.o.breakindent = true               -- Makes wrapped lines visually indented
vim.o.termguicolors = true             -- Enables true color support (duplicated setting)
vim.o.completeopt = 'menuone,noselect' -- Configures how the completion menu works
vim.o.splitright = true
vim.o.splitbelow = true
---------------------------------------------------------------------------------
-- [[ KEYMAPS ]]
---------------------------------------------------------------------------------
vim.g.mapleader = " ";
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")
-- clear search highlights
vim.keymap.set("n", "<leader>h", ":noh<CR>", { desc = "Clear highlights" })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Buffer management
vim.keymap.set("n", "<leader>p", "<cmd>b#<CR>", { desc = "Last edited buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bp<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bn<CR>", { desc = "next buffer" })
-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })
-- Move selection and format
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
-- Search for highlighted text in visual mode
vim.keymap.set("v", "/", "y/<C-R>\"<CR>N", { desc = "Search highlighted text" })
-- Notes management
vim.keymap.set("n", "<leader>nd", ":exe 'r!date \"+\\%A, \\%Y-\\%m-\\%d\"' <CR>", { desc = "Insert Date" })
-- Terminal
vim.keymap.set("n", "<leader>j", ":lua toggle_terminal() <CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
---------------------------------------------------------------------------------
-- [[ PLUGIN CONFIGS ]]
---------------------------------------------------------------------------------
require('lazy').setup({ { import = 'plugins' } })
------------------------------------------------------------------------------
-- LSP CONFIG
------------------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        -- Create your keybindings here...
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
        nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        nmap('gi', vim.lsp.buf.implementation, 'Goto Implementation')
        -- LSP binds
        vim.keymap.set("n", "<leader>lr", ":lua vim.lsp.buf.rename() <CR>", { desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>lf", ":lua vim.lsp.buf.format() <CR>", { desc = "Format code" })
        vim.keymap.set("n", "<leader>la", ":lua vim.lsp.buf.code_action() <CR>", { desc = "Code actions" })
        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end
})
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
    ensure_installed = {
        'lua_ls',
        'gopls',
        -- 'intelephense',
        -- 'tsserver',
        -- 'rust_analyzer',
        -- 'zls'
    },
}
-- Create border for lsp hover windows
local lspconfig = require "lspconfig"
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
local border = {
      {"┌", "FloatBorder"},
      {"─", "FloatBorder"},
      {"┐", "FloatBorder"},
      {"│", "FloatBorder"},
      {"┘", "FloatBorder"},
      {"─", "FloatBorder"},
      {"└", "FloatBorder"},
      {"│", "FloatBorder"},
}
-- LSP settings (for overriding per client)
local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}
------------------------------------------------------------------------------
-- SERVERS: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

------------------------------------------------------------------------------
-- LUA
------------------------------------------------------------------------------
lspconfig.lua_ls.setup {
    handlers = handlers,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
------------------------------------------------------------------------------
-- ZIG 
------------------------------------------------------------------------------
lspconfig.zls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "zls",
        "--enable-debug-log",
    },
}
------------------------------------------------------------------------------
-- Golang
------------------------------------------------------------------------------
lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
------------------------------------------------------------------------------
-- V
------------------------------------------------------------------------------
lspconfig.v_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
------------------------------------------------------------------------------
-- RUST
------------------------------------------------------------------------------
-- lspconfig.rust_analyzer.setup {
--     handlers = handlers,
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "rust" },
--     root_dir = lspconfig.util.root_pattern("Cargo.toml")
-- }
------------------------------------------------------------------------------
-- PHP
------------------------------------------------------------------------------
-- lspconfig.intelephense.setup {
--     handlers = handlers,
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         files = {
--             maxSize = 2000000,
--         }
--     }
-- }
------------------------------------------------------------------------------
-- Javascript/Typescript
------------------------------------------------------------------------------
-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
