---------------------------------------------------------------------------------
-- Colorscheme
---------------------------------------------------------------------------------
return {
    {
        "askfiy/visual_studio_code",
        priority = 100,
        config = function()
            vim.cmd([[colorscheme visual_studio_code]])
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme('tokyonight-night')
        end
    }
}
