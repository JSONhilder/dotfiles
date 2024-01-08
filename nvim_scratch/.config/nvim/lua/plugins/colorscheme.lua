---------------------------------------------------------------------------------
-- Colorscheme
---------------------------------------------------------------------------------
return {
    "rebelot/kanagawa.nvim",
    dependencies = {
        "xiyaowong/transparent.nvim"
    },
    config = function()
        require('kanagawa').setup({
            commentStyle = { italic = false },
            transparent = false,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            }
        })

        vim.cmd([[
            colorscheme kanagawa
            highlight CursorLine guibg=bg guifg=fg
        ]])
    end,
}
