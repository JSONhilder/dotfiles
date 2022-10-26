-- ===========================================
-- 				[[ Plugins ]]
-- ===========================================

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
	-- Package manager
	use 'wbthomason/packer.nvim'
	-- Colorscheme
	use 'ellisonleao/gruvbox.nvim'
	-- Add indentation guides even on blank lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- "gc" to comment visual regions/lines
	use 'numToStr/Comment.nvim'
	-- Colorizer
	use 'norcalli/nvim-colorizer.lua'
	-- Multi Cursor
	use "mg979/vim-visual-multi"
	-- Add git related info in the signs columns and popups
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	-- Fuzzy Finder (files, lsp, etc)
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
	-- Highlight, edit, and navigate code
	use 'nvim-treesitter/nvim-treesitter'
	-- Additional textobjects for treesitter
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	-- Toggle Term
	use 'akinsho/toggleterm.nvim'
	-- File Tree
	use 'nvim-tree/nvim-tree.lua'
	-- Which key
	use 'folke/which-key.nvim'
	-- Twig
	use 'nelsyeung/twig.vim'
	-- VimWiki
	use {
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = '~/Mega/docs',
					syntax = 'markdown',
					ext = '.md',
				}
			}
		end
	}
	-- LSP Zero
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },
			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		}
	}
	use 'j-hui/fidget.nvim'
end)

-- ===========================================
-- 				[[ AutoCmds ]]
-- ===========================================

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerCompile',
	group = packer_group,
	pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Highlight on yank ]] See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- Remove unneeded Whitespace on save
vim.cmd([[
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
]])

--Save Folds
vim.cmd([[
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
]])


---------------------------------------------
-- [[ Setting options ]] See `:help vim.o`
---------------------------------------------

-- Set highlight on search
vim.o.hlsearch = true
-- Make line numbers default
vim.wo.number = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd [[colorscheme gruvbox]]
vim.cmd [[
	hi Normal guibg=#1D2021
	hi signcolumn guibg=#1D2021
	hi GitSignsAdd guibg=NONE
	hi GitSignsChange guibg=NONE
	hi GitSignsDelete guibg=NONE
]]
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- set relativenumber
vim.o.relativenumber = true
-- Set Tab/Shift Sizes
vim.o.shiftwidth = 4
vim.o.tabstop = 4
-- Use clipboard
vim.cmd [[set clipboard+=unnamedplus]]
-- Set termguicolors
vim.o.termguicolors = true
-- Set Swapfile
vim.o.swapfile = false
-- cmd height
vim.o.cmdheight = 1

-- ===========================================
-- 				[[ Keymaps ]]
-- ===========================================

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader>bi', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = 'Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>gh', require('telescope.builtin').help_tags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>gw', require('telescope.builtin').grep_string, { desc = 'Grep search current word' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').live_grep, { desc = 'Grep search' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- LSP keymaps
--vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "LSP format code" })
vim.keymap.set('n', '<leader>li', ":LspInfo<CR>", { desc = "LSP information" })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "LSP rename symbol" })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = "LSP list code actions" })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = "LSP get line diagnostic" })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = "LSP set diagnostics to local list" })
vim.keymap.set('n', '<leader>ld', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics' })

-- Comment keybinds (vim registers _ as /)
vim.keymap.set("n", "<C-_>", require("Comment.api").toggle.linewise.current, { desc = "Comment line" })
vim.keymap.set("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
	{ desc = "Toggle comment line" }
)

-- quality of life stuff
vim.keymap.set("n", "<leader>bk", ":bd <CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bK", ":%bd|e# <CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bl", ":b# <CR>", { desc = "Go to previous buffer" })
vim.keymap.set("v", "<leader>fc", ":fold <CR>", { desc = "Fold selection" })
vim.keymap.set("n", "<leader>fo", ":foldopen <CR>", { desc = "Open fold on current line" })
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- netrw
vim.keymap.set("n", "<leader>.", ":NvimTreeToggle <CR>", { desc = "Open netrw" })

-- ===========================================
-- 		   [[ Plugin Configuration ]]
-- ===========================================

-- Setup lsp-zero
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Lua LSP Config
lsp.configure('sumneko_lua', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

lsp.setup()

-- Comment
require('Comment').setup()


--- [[ Configure Indent Blankline ]] See `:help indent_blankline.txt`
require('indent_blankline').setup {
	show_trailing_blankline_indent = false,
	use_treesitter = true,
	char = "▏",
	context_char = "▏",
	show_current_context = true
}

-- [[ Configure Gitsigns ]]  See `:help gitsigns.txt`
require('gitsigns').setup {
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	},
}

-- [[ Configure Telescope ]] See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true
		}
	}
}

-- [[ Configure ToggleTerm ]] See `:help toggleterm`
require('toggleterm').setup {
	size = 10,
	open_mapping = [[<c-\>]],
	shading_factor = 2,
	direction = "float",
	float_opts = {
		border = "single",
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "single",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { 'lua', 'typescript', 'rust', 'go', 'python' },

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			-- TODO: I'm not sure for this one.
			scope_incremental = '<c-s>',
			node_decremental = '<c-backspace>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
	},
}

-- empty setup using defaults
require("nvim-tree").setup({
	renderer = {
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = false,
				folder = false,
				folder_arrow = true,
				git = true,
			}
		}
	}
})

require("colorizer").setup()

-- [[ Configure Which key]] See `:help which-key`
require("which-key").setup {}
local wk = require("which-key")
wk.register({
	b = "Buffer",
	f = "Fold",
	g = "Grep",
	l = "LSP",
	w = "Wiki"
}, { prefix = "<leader>" })

require "fidget".setup {}

-- Use customised standard status line
require("statusline")
