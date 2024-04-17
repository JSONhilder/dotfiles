---------------------------------------------------------------------------------
-- Colorscheme
---------------------------------------------------------------------------------
return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd("colorscheme kanagawa")
        end
    },
    { "xiyaowong/transparent.nvim" },
    -- Vlang syntax highlighting
    { "ollykel/v-vim" }
}
