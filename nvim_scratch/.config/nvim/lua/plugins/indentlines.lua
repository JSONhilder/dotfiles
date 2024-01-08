---------------------------------------------------------------------------------
-- Add indentation guides
---------------------------------------------------------------------------------
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { highlight = { "LineNr" }, char = "│" },
            scope = { enabled = false },
        }
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        config = function()
            local ms = require('mini.indentscope')
            ms.setup({
                -- symbol = "▏",
                symbol = "│",
                options = {
                    try_as_border = true
                },
                draw = {
                    delay = 10,
                    animation = ms.gen_animation.none()
                }
            })
        end,
    }
}
