------------------------------------------------------------------------------
-- SETUP
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

    if client.server_capabilities.signatureHelpProvider then
        require("nvchad.signature").setup(client)
    end
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

        nmap('<leader>cr', vim.lsp.buf.rename, 'Rename Symbol')
        nmap('<leader>ca', require('fzf-lua').lsp_code_actions, 'Code Actions')
        nmap('<leader>cs', require('fzf-lua').lsp_document_symbols, 'Document Symbols')

        nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
        nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        nmap('gr', require('fzf-lua').lsp_definitions, 'Goto [R]eferences')
        nmap('gi', vim.lsp.buf.implementation, 'Goto Implementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end
})

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
    ensure_installed = {
        'rust_analyzer',
        'tsserver',
        'lua_ls',
        'intelephense',
        'gopls'
    },
}

local lspconfig = require "lspconfig"

------------------------------------------------------------------------------
-- SERVERS: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- RUST
------------------------------------------------------------------------------
lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_dir = lspconfig.util.root_pattern("Cargo.toml")
}
------------------------------------------------------------------------------
-- Golang
------------------------------------------------------------------------------
lspconfig.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
------------------------------------------------------------------------------
-- PHP
------------------------------------------------------------------------------
lspconfig.intelephense.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
------------------------------------------------------------------------------
-- Javascript/Typescript
------------------------------------------------------------------------------
lspconfig.tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
------------------------------------------------------------------------------
-- LUA
------------------------------------------------------------------------------
lspconfig.lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
