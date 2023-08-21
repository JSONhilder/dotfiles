local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
------------------------------------------------------------------------------
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
