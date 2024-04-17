return {
    {
        'stevearc/oil.nvim',
        keys = {
            { "<leader>o", "<cmd>Oil<cr>", desc = 'Oil Nvim'},
        },
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                }
            })
        end,
    }
}
