---------------------------------------------------------------------------------
-- Auto pairs
---------------------------------------------------------------------------------
return {
    'echasnovski/mini.extra',
    lazy = true,
    event = "BufEnter",
    version = false,
    keys = {
        { "<leader>fo", "<cmd>lua MiniExtra.pickers.oldfiles()<cr>", desc = 'Old files opened'},
    },
    config = function()
        require('mini.extra').setup()
    end
}
