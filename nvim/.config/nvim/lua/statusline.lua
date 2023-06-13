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
