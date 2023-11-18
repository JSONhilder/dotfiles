return {
    ---------------------------------------------------------------------------------
    -- Git client
    ---------------------------------------------------------------------------------
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        keys = {
            {"<leader>gg", ":Neogit <CR>", desc = "Neogit" }
        },
        config = function()
            local neogit = require('neogit')
            neogit.setup {
                status = {
                    recent_commit_count = 65,
                },
            }
        end
    },
}
