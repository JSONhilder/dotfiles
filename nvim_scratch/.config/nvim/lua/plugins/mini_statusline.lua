return {
    {
        'echasnovski/mini.statusline',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require('mini.statusline').setup({
                options = {
                    use_cache = true
                }
            })
        end
    }
}
