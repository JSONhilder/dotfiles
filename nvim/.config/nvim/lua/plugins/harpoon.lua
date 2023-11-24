---------------------------------------------------------------------------------
-- Harpoon 
---------------------------------------------------------------------------------
return {
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        keys = {
            {"<leader><leader>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Harpoon List" },
            {"<leader>m", ":lua require('harpoon.mark').add_file()<CR>", desc = "Harpoon Add File" },
            {"<leader>t", ":lua require('harpoon.term').gotoTerminal(1)<CR>", desc = "Harpoon Terminal" }
        }
    }
}
