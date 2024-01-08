---------------------------------------------------------------------------------
-- Surround
---------------------------------------------------------------------------------
return {
    'echasnovski/mini.surround',
    event = "BufEnter",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("mini.surround").setup({})
    end
}
