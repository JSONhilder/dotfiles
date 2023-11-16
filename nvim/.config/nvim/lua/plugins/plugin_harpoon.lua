---------------------------------------------------------------------------------
-- Harpoon 
---------------------------------------------------------------------------------
return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>m", ":lua require('harpoon.mark').add_file() <CR>", desc = "Harpoon Add File" },
        { "<leader><leader>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",  desc = "Harpoon Menu" }
    }
}
