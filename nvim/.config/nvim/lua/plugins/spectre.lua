---------------------------------------------------------------------------------
-- spectre
---------------------------------------------------------------------------------
return {
    {
        'nvim-pack/nvim-spectre',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        keys = {
            {'<leader>ss', '<cmd>lua require("spectre").open()<CR>',  desc = "Open Spectre" },
            {'<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" },
            {'<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search on current file" },
            {'<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" }
        }
    },
}
