return {
    ---------------------------------------------------------------------------------
    -- LSP Zero ( completion, snippets, lspconfig )
    ---------------------------------------------------------------------------------
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            { "lukas-reineke/lsp-format.nvim", config = true },
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.on_attach(function(client, bufnr)
                require("lsp-format").on_attach(client, bufnr)
            end)
            lsp.nvim_workspace()
            lsp.setup()
            vim.diagnostic.config { virtual_text = true }
        end
    },
    ------------------------------------------------------------------------------
    -- Treesitter
    ---------------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
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
    -- Telescopic Johnson
    ---------------------------------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            {
                "<C-t>",
                "<CMD>Telescope<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-o>",
                "<CMD>Telescope oldfiles<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-p>",
                "<CMD>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-g>",
                "<CMD>Telescope live_grep<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-c>",
                "<CMD>Telescope commands<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-m>",
                "<CMD>Telescope keymaps<CR>",
                mode = { "n" }
            },
            {
                "<C-s>",
                "<CMD>Telescope grep_string<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-b>",
                "<CMD>Telescope buffers<CR>",
                mode = { "n", "i", "v" }
            },
        },
        config = function()
            require('telescope').setup({
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_mru = true,
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                            },
                        },
                    },
                },
            })
        end
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
    -- nvim tree
    ---------------------------------------------------------------------------------
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
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
    -- Colorizer
    ---------------------------------------------------------------------------------
    {
        'norcalli/nvim-colorizer.lua',
        event = "VeryLazy",
        config = function()
            require 'colorizer'.setup {
                'css',
                'javascript',
                'json'
            }
        end
    },
    ---------------------------------------------------------------------------------
    -- Add indentation guides
    ---------------------------------------------------------------------------------
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_trailing_blankline_indent = false,
            char = "▏",
            use_treesitter = true,
            context_char = "▏",
            show_current_context = true,
        }
    },
    ---------------------------------------------------------------------------------
    -- Multi Cursor
    ---------------------------------------------------------------------------------
    { "mg979/vim-visual-multi" },
    ---------------------------------------------------------------------------------
    -- Harpoon
    ---------------------------------------------------------------------------------
    { 'ThePrimeagen/harpoon' },
    ---------------------------------------------------------------------------------
    -- Which key
    ---------------------------------------------------------------------------------
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    ---------------------------------------------------------------------------------
    -- spectre
    ---------------------------------------------------------------------------------
    { 'nvim-pack/nvim-spectre' },
    ---------------------------------------------------------------------------------
    -- Color Scheme
    ---------------------------------------------------------------------------------
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup {
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
                on_colors = function(colors)
                    colors.bg_statusline = "#121212"
                    colors.border = "#394b70"
                    colors.CursorLineNr = "#394b70"
                end
            }
        end,
        lazy = false,
        priority = 1000,
        opts = {},
    },
    ---------------------------------------------------------------------------------
    -- Surround
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.surround',
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup()
        end

    },
    ---------------------------------------------------------------------------------
    -- Comment code blocks
    ---------------------------------------------------------------------------------
    {
        'echasnovski/mini.comment',
        version = false,
        vent = "VeryLazy",
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
    }
}
