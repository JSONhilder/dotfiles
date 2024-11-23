-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
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
            },
            config = function()
                require('mini.pick').setup({
                    options = {
                        use_cache = true
                    },
                    window = {
                        config = {
                            anchor = 'NW',
                            row = 0,
                            col = 0
                        },
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
                { "<leader>fe", "<cmd>lua MiniFiles.open()<cr>", desc = 'Explorer'}
            },
            config = function()
                require('mini.files').setup()
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
            version = false,
            config = function()
                local miniclue = require('mini.clue')
                local anchor = 'NE'

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
                        delay = 200,
                        config = { anchor = anchor, row = 'auto', col = 'auto' },
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
            "rebelot/kanagawa.nvim",
            priority = 1000,
            config = function()
                require('kanagawa').setup({
                    transparent = true
                })

                vim.cmd("colorscheme kanagawa")
                vim.cmd [[ 
                hi SignColumn guibg=NONE ctermbg=NONE 
                hi LineNr guibg=NONE ctermbg=NONE
                hi WinSeparator guifg=#DCD7BA
                ]]
            end
        },
        { "Airbus5717/c3.vim" },
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
            },
            keys = {
                {'<leader>gg', '<cmd>Neogit<CR>',  desc = "Open Neogit" }
            },
            config = true
        },
        ---------------------------------------------------------------------------------
        -- LSP CONFIG SECTION
        ---------------------------------------------------------------------------------
        {
            -- LSP Configuration & Plugins
            "neovim/nvim-lspconfig",
            lazy = true,
            dependencies = {
                -- Automatically install LSPs to stdpath for neovim
                { "williamboman/mason.nvim", config = true },
                'williamboman/mason-lspconfig.nvim',
                -- Useful status updates for LSP
                -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
                {
                    'j-hui/fidget.nvim',
                    config = function()
                        require("fidget").setup {}
                    end,
                }
            }
        },
        {
            -- virtual text hints
            "ray-x/lsp_signature.nvim",
            lazy = true,
            event = "VeryLazy",
            opts = {
                floating_window = false,
                floating_window_above_cur_line = false,
            },
            config = function(_, opts) require'lsp_signature'.setup(opts) end
        },
        {
            -- Better placed diagnostic messages
            'dgagn/diagflow.nvim',
            event = 'LspAttach',
            opts = {}
        },
        -- auto completion
        {
            "hrsh7th/nvim-cmp",
            lazy = true,
            version = false, -- last release is way too old
            event = "InsertEnter",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                'L3MON4D3/LuaSnip',
                -- "hrsh7th/cmp-path",
                -- "saadparwaiz1/cmp_luasnip",
                -- Adds a number of user-friendly snippets
                -- 'rafamadriz/friendly-snippets',
            },
            opts = function()
                local cmp = require 'cmp'
                local luasnip = require 'luasnip'
                require('luasnip.loaders.from_vscode').lazy_load()
                luasnip.config.setup {}

                cmp.setup {
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    mapping = cmp.mapping.preset.insert {
                        ['<C-n>'] = cmp.mapping.select_next_item(),
                        ['<C-p>'] = cmp.mapping.select_prev_item(),
                        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete {},
                        ['<CR>'] = cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                        },
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                    },
                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                    }
                }
            end
        }
    },
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    -- checker = { enabled = true },
})
