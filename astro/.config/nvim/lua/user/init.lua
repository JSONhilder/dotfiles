
local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    pin_plugins = true, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
  },

  -- Set colorscheme
  colorscheme = "jellybeans-nvim",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      tabstop = 4,
      shiftwidth = 4,
      background = "dark"
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    -- Modify the highlight groups
    highlights = function(highlights)
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      notify = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = true,
      ["which-key"] = true,
      ["neo-tree"] = true,
      ["nvim-web-devicons"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      ["declancm/cinnamon.nvim"] = { disable = true },
      ["goolord/alpha-nvim"] = { disable = true },
      ["feline-nvim/feline.nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      {
        "metalelf0/jellybeans-nvim",
        requires = {"rktjmp/lush.nvim"}
      },
      {
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
      },
      { "mg979/vim-visual-multi" },
      { "nelsyeung/twig.vim" }

    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "lua", "rust", "javascript", "typescript", "svelte" },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua", "rust_analyzer", "svelte", "css", "tsserver"  },
    },
    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
        }
      }
    },
    ["toggleterm"] = {
      float_opts = {
        border = "single"
      }
    }
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    -- Set key bindings
    vim.keymap.set("n", "<C-s>", ":w!<CR>")

    vim.keymap.set("n", "<leader>.", ":Telescope find_files hidden=true theme=ivy<cr>")
    vim.keymap.set("n", "<C-j>", ":ToggleTerm size=80 direction=vertical<cr>")

    -- quality of life stuff
    vim.keymap.set("n", "Y", "y$")
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
    vim.keymap.set("v", "<Tab>", ">gv")
    vim.keymap.set("v", "<S-Tab>", "<gv")

    -- compile project in new terminal
    Terminal  = require('toggleterm.terminal').Terminal
    Cp = Terminal:new({ cmd = "bash ~/.dotfiles/scripts/compile.sh", direction="float", float_opts = { border = "single" }, hidden = true, close_on_exit = false })
    function Compile_project()
      Cp:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua Compile_project()<CR>", {noremap = true, silent = true})

    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    vim.cmd([[
      hi rainbowcol1 guifg = #cf6a4c
      autocmd BufWritePre * %s/\s\+$//e
      autocmd BufWritePre * %s/\n\+\%$//e
    ]])

    -- status line
    local modes = {
      ["n"] = "Normal",
      ["no"] = "Normal",
      ["v"] = "Visual",
      ["V"] = "Visual-line",
      [""] = "Visual-block",
      ["Msv"] = "Visual-multi",
      ["s"] = "Select",
      ["S"] = "Select-line",
      [""] = "Select-block",
      ["i"] = "Insert",
      ["ic"] = "Insert",
      ["R"] = "Replace",
      ["Rv"] = "Visual-replace",
      ["c"] = "Command",
      ["cv"] = "Vim-ex",
      ["ce"] = "Ex",
      ["r"] = "Prompt",
      ["rm"] = "Moar",
      ["r?"] = "Confirm",
      ["!"] = "Shell",
      ["t"] = "Terminal",
    }

    local function mode()
      local current_mode = vim.api.nvim_get_mode().mode
      return string.format(" %s ", modes[current_mode])
    end

    local function filepath()
      local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
      if fpath == "" or fpath == "." then
          return " "
      end

      return string.format(" %%<%s/", fpath)
    end

    local function filename()
      local fname = vim.fn.expand "%:t"
      if fname == "" then
          return ""
      end
      return fname .. " "
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

      return errors .. warnings .. hints .. info .. "%#Normal#"
    end

    local function filetype()
      return string.format(" %s ", vim.bo.filetype)
    end

    local function lineinfo()
      if vim.bo.filetype == "alpha" then
        return ""
      end
      return " %P %l:%c "
    end

    local vcs = function()
      local git_info = vim.b.gitsigns_status_dict
      if not git_info or git_info.head == "" then
        return ""
      end
      local added = git_info.added and ("%#GitSignsAdd#+" .. " ") or ""
      local changed = git_info.changed and ("%#GitSignsChange#~" .. " ") or ""
      local removed = git_info.removed and ("%#GitSignsDelete#-" .. " ") or ""
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
         "%#Normal#",
         added,
         changed,
         removed,
         "%#GitSignsAdd#",
         git_info.head,
         "%#Normal#",
      }
    end

    Statusline = {}

    Statusline.active = function()
      return table.concat {
        "%#Normal#",
        mode(),
        "%#Normal#",
        filepath(),
        filename(),
        "%#Normal#",
        lsp(),
        "%=%#StatusLineExtra#",
        vcs(),
        filetype(),
        lineinfo(),
      }
    end

    function Statusline.short()
      return "%#StatusLineNC#   NvimTree"
    end

    vim.api.nvim_exec([[
      augroup Statusline
      au!
      au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
      au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
      au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
      augroup END
    ]], false)
     end,
}

return config
