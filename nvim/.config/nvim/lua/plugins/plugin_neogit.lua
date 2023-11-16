return {
    ---------------------------------------------------------------------------------
    -- Git client  
    ---------------------------------------------------------------------------------
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "ibhagwan/fzf-lua",              -- optional
        },
        keys = {
            {"<leader>gg", ":Neogit <CR>", desc = "Neogit" }
        },
        config = function()
            local neogit = require('neogit')
            neogit.setup {}
        end
    },
}
