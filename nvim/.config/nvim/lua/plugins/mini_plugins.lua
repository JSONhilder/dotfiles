return {
    ---------------------------------------------------------------------------------
    -- Statusline
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.statusline',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require('mini.statusline').setup({
                options = {
                    use_cache = true
                }
            })
        end
    },
    ---------------------------------------------------------------------------------
    -- Mini Pick: File pickers and more 
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.pick',
        lazy = true,
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "BufEnter",
        keys = {
            { "<leader>.",  "<cmd>lua MiniPick.builtin.files({ tool = 'git' })<cr>", desc = 'Find File'},
            { "<leader>ff", "<cmd>lua MiniPick.builtin.files({ tool = 'git' })<cr>", desc = 'Find File'},
            { "<leader>fb", "<cmd>lua MiniPick.builtin.buffers()<cr>", desc = 'Find Buffer'},
            { "<leader>fl", "<cmd>lua MiniPick.builtin.resume()<cr>", desc = 'Resume Last Search'},
            { "<leader>fs", "<cmd>lua MiniPick.builtin.grep_live()<cr>", desc = 'Find String'},
            { "<leader>fh", "<cmd>lua MiniPick.builtin.help()<cr>", desc = 'Find Help'},
            { "<leader>fm", "<cmd>Pick marks<cr>", desc = 'Find Marks'},
            { "<leader>q", "<cmd>Pick diagnostic<cr>", desc = 'Diagnostics'},
            { "<leader>b", "<cmd>lua MiniPick.builtin.buffers()<cr>", desc = 'Find Buffer'},
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
        lazy = true,
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "BufEnter",
        keys = {
            { "<leader>fe", "<cmd>lua MiniFiles.open()<cr>", desc = 'Explorer'},
            { "<leader>e",  "<cmd>lua MiniFiles.open()<cr>", desc = 'Explorer'},
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
        end
    },
    ---------------------------------------------------------------------------------
    -- Mini comment: Comment code blocks
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.comment',
        version = false,
        config = function()
            require('mini.comment').setup()
        end
    },
    ---------------------------------------------------------------------------------
    -- Mini Surround: surround selects "''"
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.surround',
        event = "BufEnter",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("mini.surround").setup({})
        end
    },
    ---------------------------------------------------------------------------------
    -- Mini clue: which-key alternative
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.clue',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            local miniclue = require('mini.clue')
            miniclue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    { mode = 'n', keys = '<Leader>f', desc = 'Find' },
                    { mode = 'n', keys = '<Leader>s', desc = 'Spectre' },
                    { mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
                    { mode = 'n', keys = '<Leader>g', desc = 'Git' },
                    { mode = 'n', keys = '<Leader>c', desc = 'Code' },
                    { mode = 'n', keys = '<Leader>n', desc = 'Toggle' },
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
                window = {
                    delay = 200
                }
            })
        end
    }
}
