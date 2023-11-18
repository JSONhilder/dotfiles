---------------------------------------------------------------------------------
-- Surround
---------------------------------------------------------------------------------
return {
    'echasnovski/mini.surround',
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("mini.surround").setup({})
    end
}
