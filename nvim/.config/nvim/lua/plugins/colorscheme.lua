---------------------------------------------------------------------------------
-- Colorscheme
---------------------------------------------------------------------------------
return {
    {
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup({
                extra_groups = {
                    "NormalFloat"
                }
            })
        end
    },
    {
        "kabouzeid/nvim-jellybeans",
        dependencies = {
            "rktjmp/lush.nvim"
        },
        config = function()
            vim.cmd("colorscheme jellybeans")
        end
    }
}
