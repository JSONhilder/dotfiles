return {
    -- Config heavily uses mini nvim (https://github.com/echasnovski/mini.nvim)
    ---------------------------------------------------------------------------------
    -- Mini Pick: File pickers and more 
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.pick',
        lazy = true,
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "BufEnter",
        keys = {
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
                    { mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
                    { mode = 'n', keys = '<Leader>g', desc = 'Git' },
                    { mode = 'n', keys = '<Leader>l', desc = 'Code' },
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
    },
    ---------------------------------------------------------------------------------
    -- Mini Extra
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.extra',
        version = false,
        config = function()
            require('mini.extra').setup()
        end,
    },
    ---------------------------------------------------------------------------------
    -- Mini StatusLine
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.statusline',
        version = false,
        config = function()
            require('mini.statusline').setup()
        end
    },
    ---------------------------------------------------------------------------------
    -- Add indentation guides
    ---------------------------------------------------------------------------------
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
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { highlight = { "LineNr" }, char = "│" },
            scope = { enabled = false },
        }
    },
    ---------------------------------------------------------------------------------
    -- Colorscheme
    ---------------------------------------------------------------------------------
    {
        "kabouzeid/nvim-jellybeans",
        priority = 1000,
        dependencies = {
            "rktjmp/lush.nvim"
        },
        config = function()
            -- Set the colorscheme
            vim.cmd("colorscheme jellybeans")

            -- Override the background color
            vim.api.nvim_set_hl(0, "Normal", { bg = "#0f0e06" })
            -- Ensure background is set correctly for other highlight groups
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0f0e06" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "#0f0e06" })
        end
    },
    ---------------------------------------------------------------------------------
    -- Git releated signs to the gutter
    ---------------------------------------------------------------------------------
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        "NeogitOrg/neogit",
        version = "v0.0.1",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "sindrets/diffview.nvim",        -- optional - Diff integration
            -- "nvim-telescope/telescope.nvim", -- optional
        },
        keys = {
            {'<leader>gg', '<cmd>Neogit<CR>',  desc = "Open Neogit" }
        },
        config = true
    },
}
