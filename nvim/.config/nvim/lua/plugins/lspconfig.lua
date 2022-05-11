-- lsp setup
-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "✗",
      spacing = 0,
    },
    signs = true,
    underline = true,
    update_in_insert = false
  }
)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

local opts = {noremap = true, silent = true}
local _buffer = vim.api.nvim_get_current_buf()

local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(_buffer, ...)
end

-- Mappings.
buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float(nil, { source = 'always' })<CR>", opts)
buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)

vim.api.nvim_buf_set_option(_buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

local function documentHighlight(client, _buffer)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end

require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

function lspconfig.common_on_attach(client, _buffer)
    documentHighlight(client, _buffer)
    require "lsp_signature".on_attach({
        use_lspsaga = true,
        hint_enable = true,
        floating_window = false,
    }, _buffer)
end
function lspconfig.tsserver_on_attach(client, _buffer)
    lsp_config.common_on_attach(client, _buffer)
    client.resolved_capabilities.document_formatting = false
end

local function setup_servers()
    lspconfig.rust_analyzer.setup {}
    lspconfig.gopls.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.html.setup {}
end

setup_servers()
