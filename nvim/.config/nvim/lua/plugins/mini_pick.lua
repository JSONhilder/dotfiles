return {
    {
        'echasnovski/mini.pick',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        keys = {
            { "<leader>ff", "<cmd>lua MiniPick.builtin.files({ tool = 'git' })<cr>", desc = 'Find File'},
            { "<leader>fb", "<cmd>lua MiniPick.builtin.buffers()<cr>", desc = 'Find Buffer'},
            { "<leader>fs", "<cmd>lua MiniPick.builtin.grep_live()<cr>", desc = 'Find String'},
            { "<leader>fh", "<cmd>lua MiniPick.builtin.help()<cr>", desc = 'Find Help'},
            { "<leader>bb", "<cmd>lua MiniPick.builtin.buffers()<cr>", desc = 'Find Buffer'},
            { "<leader>q", "<cmd>Pick diagnostic<cr>", desc = 'Diagnostics'},
            { "<leader>fm", "<cmd>Pick marks<cr>", desc = 'Find Marks'}
        },
        config = function()
            require('mini.pick').setup({
                options = {
                    use_cache = true
                }
            })
        end
    },
    {
        'echasnovski/mini.files',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        keys = {
            { "<leader>fe", "<cmd>lua MiniFiles.open()<cr>", desc = 'Explorer'},
        },
        config = function()
            local mf = require('mini.files')
            mf.setup()

            local toggle_files = function ()
                if mf.close() == nil then
                   mf.open()
                else
                   mf.close()
                end

            end

            vim.keymap.set("n", "<leader>e", toggle_files, {desc = 'Explorer'})
        end
    }
}
