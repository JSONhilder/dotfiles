local M = {}

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")
    if present then
        colorizer.setup({
            md = { names = false; }
        })
        vim.cmd("ColorizerReloadAllBuffers")
    end
end

M.comment = function()
    local present, nvim_comment = pcall(require, "nvim_comment")
    if present then
        nvim_comment.setup()
    end
end

M.better_escape = function()
    local present, better_escape = pcall(require, "better_escape")
    if present then
        better_escape.setup {
            mapping = {"jk", "jj"},
            timeout = vim.o.timeoutlen,
            -- clear line after escaping if there is only whitespace
            clear_empty_lines = false,
            keys = "<Esc>",
        }
    end
end

M.lspkind = function()
    local present, lspkind = pcall(require, "lspkind")
    if present then
        lspkind.init()
    end
end

M.blankline = function()
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"

    vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
    vim.g.indent_blankline_buftype_exclude = {"terminal"}

    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
end

M.lualine = function ()
    local present, lualine = pcall(require, "lualine")

    function current_signature()
        if not packer_plugins["lsp_signature.nvim"] or packer_plugins["lsp_signature.nvim"].loaded == false then
            return ""
        end
        local sig = require("lsp_signature").status_line(700)
        -- return sig.label .. " >> " .. sig.hint
        return sig.label
    end

    if present then
        lualine.setup {
            options = {
                theme = "gruvbox-flat",
                section_separators = {''},
                component_separators = {''}
                -- ... your lualine config
            },
            sections = {
                lualine_c = {
                    {
                      'filename',
                      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
                    },
                    {
                        current_signature
                    }
                },

            }
        }
    end
end

M.bufferline = function()
    local present, bufferline = pcall(require, "bufferline")
    if present then
        bufferline.setup{
            options = {
                modified_icon = '•',
                close_icon = ''
            }
        }
    end
end

return M
