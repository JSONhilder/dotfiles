return {
    -- Default (Astro)theme configuration
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
        ["neo-tree"] = false,
        ["nvim-web-devicons"] = true,
    },
}
