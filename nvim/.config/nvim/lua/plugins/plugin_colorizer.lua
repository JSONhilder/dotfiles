---------------------------------------------------------------------------------
-- Colorizer
---------------------------------------------------------------------------------
return {
    'norcalli/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function()
        require 'colorizer'.setup {
            "css",
            "scss"
        }
    end
}
