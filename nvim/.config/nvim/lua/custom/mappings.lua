local M = {}
-- Your custom mappings
M.life = {
    n = {
        ["<leader>e"] = {
            ":NvimTreeToggle <CR>",
            "Nvim Tree"
        },
    },
    i = {
        ["jj"] = {
            "<ESC>",
            "escape insert mode" ,
            opts = { nowait = true }
        },
    },
    v = {
        ["J"] = {
            ":m '>+1<CR>gv=gv",
            "move selection down"
        },
        ["K"] = {
            ":m '<-2<CR>gv=gv",
            "move selection up"
        },
    }
}
return M
