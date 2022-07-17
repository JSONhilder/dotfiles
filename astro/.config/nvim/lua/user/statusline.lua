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
     "%#Normal# |",
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
