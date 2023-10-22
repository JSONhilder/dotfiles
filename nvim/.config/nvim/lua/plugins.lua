return {
    ---------------------------------------------------------------------------------
    -- LSP Zero ( completion, snippets, lspconfig )
    ---------------------------------------------------------------------------------
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {},
                config = function()
                    require("fidget").setup {}
                end,
            }
        }
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
    {
        -- virtual text hints
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            floating_window = false,
            floating_window_above_cur_line = false,
        },
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    ------------------------------------------------------------------------------
    -- Treesitter
    ---------------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "c",
                    "vim",
                    "lua",
                    "rust",
                    "html",
                    "twig",
                    "javascript",
                    "typescript",
                    "python",
                    "go"
                },
                highlight = { enable = true, }
            }
        end
    },
    ---------------------------------------------------------------------------------
    -- Toggle Term
    ---------------------------------------------------------------------------------
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = {
            open_mapping = [[<c-j>]], direction = "float"
        }
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
    ---------------------------------------------------------------------------------
    -- Git Client like magit 
    ---------------------------------------------------------------------------------
    {
        "NeogitOrg/neogit",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua",
        },
        config = function ()
            local neogit = require("neogit")
            neogit.setup {
                status = {
                    recent_commit_count = 60
                }
            }
        end
    },
    ---------------------------------------------------------------------------------
    -- FZF
    ---------------------------------------------------------------------------------
    {
        'ibhagwan/fzf-lua',
        opts = {
            winopts = {
                fullscreen = false,
                preview = { border = 'noborder' }
            }
        }
    },
    ---------------------------------------------------------------------------------
    -- Vimwiki
    ---------------------------------------------------------------------------------
    {
        "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/Mega/vim_wiki/',
                    syntax = 'markdown',
                    ext = '.md'
                }
            }
        end
    },
    ---------------------------------------------------------------------------------
    -- Colorizer
    ---------------------------------------------------------------------------------
    {
        'norcalli/nvim-colorizer.lua',
        event = "VeryLazy",
        config = function()
            require 'colorizer'.setup {
                'scss',
                'css',
                'javascript',
                'json',
                'lua',
                'php'
            }
        end
    },
    ---------------------------------------------------------------------------------
    -- Add indentation guides
    ---------------------------------------------------------------------------------
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { highlight = { "LineNr" }, char = "│" },
            scope = { enabled = true },
        }
    },
    ---------------------------------------------------------------------------------
    -- Harpoon
    ---------------------------------------------------------------------------------
    { 'ThePrimeagen/harpoon' },
    ---------------------------------------------------------------------------------
    -- Which key
    ---------------------------------------------------------------------------------
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>h"] = { name = "+harpoon" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>n"] = { name = "+highlights" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>w"] = { name = "+wiki" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },

    ---------------------------------------------------------------------------------
    -- nvim tree
    ---------------------------------------------------------------------------------
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            vim.g.nvim_tree_show_icons = {
                git = 0,
                folders = 0,
                files = 0,
                folder_arrows = 0,
            }
            require("nvim-tree").setup {
                view = {
                    width = 40
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    ignore = false,
                }
            }
        end,
    },
    ---------------------------------------------------------------------------------
    -- spectre
    ---------------------------------------------------------------------------------
    {
        'nvim-pack/nvim-spectre',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
    ---------------------------------------------------------------------------------
    -- Surround
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({})
        end
    },
    ---------------------------------------------------------------------------------
    -- Comment code blocks
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.comment',
        version = false,
        event = "VeryLazy",
        config = function()
            require('mini.comment').setup()
        end
    },
    ---------------------------------------------------------------------------------
    -- Auto pairs
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.pairs',
        version = false,
        config = function()
            require('mini.pairs').setup()
        end
    },
    ---------------------------------------------------------------------------------
    -- Statusline
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.statusline',
        version = false,
        config = function()
            require('mini.statusline').setup()
        end
    },
    ---------------------------------------------------------------------------------
    -- Dashboard
    ---------------------------------------------------------------------------------
    {
        'goolord/alpha-nvim',
        config = function ()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            local v = vim.version()
            local time = os.date " %d-%m-%Y"
            local platform = vim.fn.has "win32" == 1 and "" or ""
            dashboard.section.buttons.val = {}
            dashboard.section.footer.val = string.format(" %s %d.%d.%d  %s ",  platform, v.major, v.minor, v.patch, time)
            alpha.setup(dashboard.config)
        end
    },
    ---------------------------------------------------------------------------------
    -- Colorscheme
    ---------------------------------------------------------------------------------
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                    comments = { italic = false },
                    keywords = { italic = false }
                }
            })
        end
    },
}

