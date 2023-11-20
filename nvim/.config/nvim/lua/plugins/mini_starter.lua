return {
    'echasnovski/mini.starter',
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require('mini.starter').setup({})
    end
}
