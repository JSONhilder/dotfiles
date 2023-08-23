---@type ChadrcConfig
local M = {}
M.mappings = require 'custom.mappings'
M.plugins = 'custom.plugins'
M.ui = {
    theme = 'kanagawa',
    statusline = {
        theme = "vscode_colored"
    },
    nvdash = {
        load_on_startup = true
    },
    tabufline = {
        enabled = false
    },
    telescope = { style = "bordered" }
}
return M
