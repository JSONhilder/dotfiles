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
        'clangd'
        -- 'intelephense',
        -- 'tsserver',
        -- 'rust_analyzer',
        -- 'zls'
    },
}
-- Create border for lsp hover windows
local lspconfig = require "lspconfig"
local util = require('lspconfig/util')
local configs = require('lspconfig.configs')

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
    ["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
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
-- Clang
------------------------------------------------------------------------------
lspconfig.clangd.setup {
    handlers = handlers,
    settings = {
        clangd = {
            diagnostics = {
                severity = {
                    ["unresolved"] = "warning",
                    ["undeclared"] = "error",
                }
            }
        }
    }
}
------------------------------------------------------------------------------
-- Golang
------------------------------------------------------------------------------
lspconfig.gopls.setup {
    handlers = handlers
}

------------------------------------------------------------------------------
-- C3
------------------------------------------------------------------------------
if not configs.c3_lsp then
    configs.c3_lsp = {
        default_config = {
            cmd = {
                "/usr/local/bin/c3lsp" ,
                "--stdlib-path", "/usr/local/lib/c3/std/",
                "--diagnostics-delay", "500"
            },
            filetypes = { "c3", "c3i" },
            root_dir = function(fname)
                return util.find_git_ancestor(fname)
            end,
            settings = {},
            name = "c3_lsp"
        }
    }
end

lspconfig.c3_lsp.setup{
    handlers = handlers
}
