---------------------------------------------------------------------------------
-- Harpoon 
---------------------------------------------------------------------------------
return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        lazy = false,
        event = "BufEnter",
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>m", function() harpoon:list():append() end, {desc = "Harpoon Mark"})

            vim.keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoon List"})
        end,
    }
}
