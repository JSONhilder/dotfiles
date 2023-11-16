---------------------------------------------------------------------------------
-- nvim tree
---------------------------------------------------------------------------------
return {
    'nvim-tree/nvim-tree.lua',
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Nvim Tree" },
    },
    config = function()
        vim.g.nvim_tree_show_icons = {
            git = 0,
            folders = 0,
            files = 0,
            folder_arrows = 0,
        }
        require("nvim-tree").setup {
            view = {
                width = 40
            },
            filters = {
                dotfiles = false,
            },
            git = {
                ignore = false,
            }
        }
    end,
}
