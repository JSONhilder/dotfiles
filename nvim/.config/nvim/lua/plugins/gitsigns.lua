return {
    ---------------------------------------------------------------------------------
    -- Git releated signs to the gutter
    ---------------------------------------------------------------------------------
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "sindrets/diffview.nvim",        -- optional - Diff integration
            -- "nvim-telescope/telescope.nvim", -- optional
        },
        keys = {
            {'<leader>gg', '<cmd>Neogit<CR>',  desc = "Open Neogit" }
        },
        config = true
    }
}
