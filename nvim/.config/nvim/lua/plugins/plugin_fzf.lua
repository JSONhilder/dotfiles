---------------------------------------------------------------------------------
-- FZF
---------------------------------------------------------------------------------
return {
    'ibhagwan/fzf-lua',
    opts = {
        winopts = {
            fullscreen = false,
            preview = { border = 'noborder' }
        }
    },
    keys = {
        -- LSP binds WITH FZF
        {"<leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "Code actions" },
        -- FZF picker
        { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find Files" },
        { "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", desc = "Recent Files" },
        { "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "Find Buffer" },
        { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Grep Project" },
        { "<leader>fs", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", desc = "Grep Buffer" }
    }
}
