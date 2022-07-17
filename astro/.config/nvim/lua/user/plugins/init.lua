return {
  -- disable default plugins:
  ["declancm/cinnamon.nvim"] = { disable = true },
  ["goolord/alpha-nvim"] = { disable = true },
  ["feline-nvim/feline.nvim"] = { disable = true },
  ["akinsho/bufferline.nvim"] = { disable = true },
  -- add new plugins:
  {
    "widatama/vim-phoenix",
  },
  {
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/Mega/docs',
          syntax = 'markdown',
          ext = '.md',
        }
      }
    end
  },
  { "mg979/vim-visual-multi" },
  { "nelsyeung/twig.vim" },
}
