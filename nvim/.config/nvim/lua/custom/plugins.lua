local plugins = {
  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "gopls",
        "intelephense",
        "typescript-language-server",
        "rust-analyzer"
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "php",
        "twig",
       -- low level
        "go",
        "rust"
      },
    },
  },
  -----------------------------------------------------------------------------
  -- Vim Wiki
  -----------------------------------------------------------------------------
  {
    "vimwiki/vimwiki",
    event = "VeryLazy",
    init = function()
        vim.g.vimwiki_list = {
            {
                path = '~/Mega/vim_wiki/',
                syntax = 'markdown',
                ext = '.md'
            }
        }
    end
  },
  -----------------------------------------------------------------------------
  -- spectre
  -----------------------------------------------------------------------------
  { 'nvim-pack/nvim-spectre' },
  -----------------------------------------------------------------------------
  -- Harpoon
  -----------------------------------------------------------------------------
  { 'ThePrimeagen/harpoon' },
  -----------------------------------------------------------------------------
  -- Multi Cursor
  -----------------------------------------------------------------------------
  { "mg979/vim-visual-multi", event = "VeryLazy"},
  -----------------------------------------------------------------------------
  -- Disabled Plugins
  -----------------------------------------------------------------------------
  -- { "folke/which-key.nvim", enabled = false, }
}
return plugins
