return {
    ---------------------------------------------------------------------------------
    -- LSP Zero
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
    ---------------------------------------------------------------------------------
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
                    "python"
                },
                highlight = { enable = true, }
            }
        end
    },
    ---------------------------------------------------------------------------------
    -- Add indentation guides even on blank lines
    ---------------------------------------------------------------------------------
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_trailing_blankline_indent = false,
            char = "▏",
            -- use_treesitter = true,
            --context_char = "▏",
            --show_current_context = true,
        }
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
    -- Git releated signs to the gutter, as well as utilities for managing changes
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
                "<C-f>",
                "<CMD>Telescope current_buffer_fuzzy_find<CR>",
                mode = { "n", "i", "v" }
            },
            {
                "<C-b>",
                "<CMD>Telescope buffers<CR>",
                mode = { "n", "i", "v" }
            },
        },
        config = true
    },
    ---------------------------------------------------------------------------------
    -- Auto pairs
    ---------------------------------------------------------------------------------
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = { java = false },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        },
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
    -- Comment code blocks
    ---------------------------------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end
    },
    ---------------------------------------------------------------------------------
    -- use systems lf in neovim
    ---------------------------------------------------------------------------------
    { 'is0n/fm-nvim' },
    ---------------------------------------------------------------------------------
    -- Colorizer
    ---------------------------------------------------------------------------------
    { 'norcalli/nvim-colorizer.lua' },
    ---------------------------------------------------------------------------------
    -- Multi Cursor
    ---------------------------------------------------------------------------------
    { "mg979/vim-visual-multi" },
    ---------------------------------------------------------------------------------
    -- Color Scheme
    ---------------------------------------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    { "sainnhe/gruvbox-material" },
    { 'rktjmp/lush.nvim' },
    { 'metalelf0/jellybeans-nvim' }
}
