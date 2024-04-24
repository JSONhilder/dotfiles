---------------------------------------------------------------------------------
-- Colorscheme
---------------------------------------------------------------------------------
return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000 ,
        config = function()
            vim.cmd("colorscheme gruvbox")
            vim.cmd [[highlight CursorLine guibg=#282828]]
        end
    },
    -- Vlang syntax highlighting
    { "ollykel/v-vim" }
}

