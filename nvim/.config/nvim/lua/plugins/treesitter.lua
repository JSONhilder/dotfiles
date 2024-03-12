------------------------------------------------------------------------------
-- Treesitter
---------------------------------------------------------------------------------
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = ":TSUpdate",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "c",
                "vim",
                "lua",
                "rust",
                "html",
                "twig",
                "javascript",
                "typescript",
                "python",
                "go"
            },
            highlight = { enable = true, }
        }
    end
}
