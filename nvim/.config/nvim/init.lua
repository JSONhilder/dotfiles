---------------------------------------------------------------------------------
-- Bootstrap Package Manager
-- https://github.com/folke/lazy.nvim `:help lazy.nvim.txt` for more info
---------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------------------------
-- [[ PLUGINS ]]
---------------------------------------------------------------------------------
require('lazy').setup({
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
                -- Handle deno and normal ts projects START
                local active_clients = vim.lsp.get_active_clients()
                if client.name == 'denols' then
                    for _, client_ in pairs(active_clients) do
                        -- stop tsserver if denols is already active
                        if client_.name == 'tsserver' then
                            client_.stop()
                        end
                    end
                elseif client.name == 'tsserver' then
                    for _, client_ in pairs(active_clients) do
                        -- prevent tsserver from starting if denols is already active
                        if client_.name == 'denols' then
                            client.stop()
                        end
                    end
                end
                -- Handle deno and normal ts projects END
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
    -- FZF
    ---------------------------------------------------------------------------------
    { 'ibhagwan/fzf-lua' },
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
    },
    ---------------------------------------------------------------------------------
    -- FLUTTER SPECIFIC
    ---------------------------------------------------------------------------------
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    }
})
---------------------------------------------------------------------------------
-- [[ KEYMAPS ]]
---------------------------------------------------------------------------------
vim.g.mapleader = " ";

vim.keymap.set("i", "<C-l>", "<Esc>")
vim.keymap.set("i", "<M-;>", ":")
vim.keymap.set("i", "jj", "<Esc>")

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear highlights" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window management
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })

-- Buffer management
vim.keymap.set("n", "<leader>l", "<cmd>b#<CR>", { desc = "last edited buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "close buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bp<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bn<CR>", { desc = "next buffer" })

-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })

-- Move selection and format
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- File manager
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle <CR>", { desc = "Nvim Tree" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", ":Lazygit <CR>", { desc = "Lazygit" })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', '<M-a>', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', '<M-d>', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Spectre Searching
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', { desc = "Open Spectre" })
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
vim.keymap.set('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    { desc = "Search on current file" })
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { desc = "Search current word" })

-- Harpoon
vim.keymap.set("n", "<leader><leader>", ":lua require('harpoon.ui').toggle_quick_menu() <CR>", { desc = "Harpoon List" })
vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file() <CR>", { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>hh", ":lua require('harpoon.ui').nav_prev() <CR>", { desc = "Harpoon previous file" })
vim.keymap.set("n", "<leader>hl", ":lua require('harpoon.ui').nav_next() <CR>", { desc = "Harpoon next file" })

-- LSP binds
vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename() <CR>", { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cf", ":lua vim.lsp.buf.format() <CR>", { desc = "Format code" })
-- LSP binds WITH FZF
vim.keymap.set("n", "<leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { desc = "Code actions" })

-- FZF picker
vim.keymap.set("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<C-o>", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
vim.keymap.set("n", "<C-b>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<C-g>", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", { silent = true })

-- Terminal mode
vim.keymap.set('t', '<C-w>h', "<C-\\><C-n><C-w>h", { silent = true })

---------------------------------------------------------------------------------
-- [[ AUTOCMDS ]]
---------------------------------------------------------------------------------
-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
-- Clear white space on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})
-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursorGrp,
})
vim.api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)
-- Vlang
vim.cmd([[au BufNewFile,BufRead *.v set filetype=vlang]])

-- cmd height 0 recording message
vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 ]]
vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 ]]


---------------------------------------------------------------------------------
-- OPTIONS
---------------------------------------------------------------------------------
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.mouse = 'a'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

vim.opt.updatetime = 50

vim.o.breakindent = true

vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.o.cmdheight = 0

-- Default theme 'habamax' with transparent backgrounds
vim.cmd.colorscheme "habamax"
vim.cmd [[
    hi Normal guibg=none ctermbg=none
    hi LineNr guibg=none ctermbg=none
    hi Folded guibg=none ctermbg=none
    hi NonText guibg=none ctermbg=none
    hi SpecialKey guibg=none ctermbg=none
    hi VertSplit guibg=none ctermbg=none
    hi SignColumn guibg=none ctermbg=none
    hi EndOfBuffer guibg=none ctermbg=none
    hi DiffChange guibg=none ctermbg=none guifg=#d7875f
    hi StatusLine guibg=#5f87af
    hi StatusLineNC guibg=none guifg=#bcbcbc
]]

---------------------------------------------------------------------------------
-- [[ STATUSLINE ]]
---------------------------------------------------------------------------------
local modes = {
    ["n"] = "NOR",
    ["no"] = "NOR",
    ["v"] = "VIS",
    ["V"] = "VIS LINE",
    [""] = "VIS BLOCK",
    ["s"] = "SEL",
    ["S"] = "SEL LINE",
    [""] = "SEL BLOCK",
    ["i"] = "INS",
    ["ic"] = "INS",
    ["R"] = "REPLACE",
    ["Rv"] = "VIS REPLACE",
    ["c"] = "CMD",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERM",
}

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
    if fpath == "" or fpath == "." then
        return ""
    end

    return string.format("%%<%s/", fpath)
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then
        return ""
    end
    return fname
end
local function lsp_progress()
    if #vim.lsp.buf_get_clients() == 0 then
        return ""
    end

    local lsp = vim.lsp.util.get_progress_messages()[1]
    if lsp then
        local name = lsp.name or ""
        local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        local title = lsp.title or ""
        return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
    end
    return ""
end


local function lsp()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#LspDiagnosticsSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#LspDiagnosticsSignInformation# " .. count["info"]
    end

    return errors .. warnings .. hints .. info
end

local function filetype()
    return string.format(" [ %s ", vim.bo.filetype)
end

local function lineinfo()
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return " %P %l:%c ]"
end

local vcs = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end
    local added = git_info.added and ("+" .. " ") or ""
    local changed = git_info.changed and ("~" .. " ") or ""
    local removed = git_info.removed and ("-" .. " ") or ""
    if git_info.added == 0 then
        added = ""
    end
    if git_info.changed == 0 then
        changed = ""
    end
    if git_info.removed == 0 then
        removed = ""
    end
    return table.concat {
        "[",
        added,
        changed,
        removed,
        git_info.head,
        "]",
    }
end

Statusline = {}

---@diagnostic disable-next-line: duplicate-set-field
Statusline.active = function()
    return table.concat {
        mode(),
        "[",
        filepath(),
        filename(),
        "]",
        lsp(),
        "%=%#StatusLineExtra#",
        lsp_progress(),
        vcs(),
        filetype(),
        lineinfo(),
    }
end

---@diagnostic disable-next-line: duplicate-set-field
function Statusline.inactive()
    return " %F"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
