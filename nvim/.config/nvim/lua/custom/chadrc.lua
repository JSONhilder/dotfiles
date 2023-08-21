---@type ChadrcConfig
local M = {}
M.mappings = require 'custom.mappings'
M.plugins = 'custom.plugins'
M.ui = {
    theme = 'vscode_dark',
    statusline = {
        theme = "vscode_colored"
    },
    nvdash = {
        load_on_startup = true
    },
    tabufline = {
        enabled = true
    },
    telescope = { style = "bordered" }
}
return M
