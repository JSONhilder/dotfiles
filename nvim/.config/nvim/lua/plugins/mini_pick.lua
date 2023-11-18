return {
    {
        'echasnovski/mini.pick',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require('mini.pick').setup({
                mappings = {
                    choose_in_vsplit  = '<C-CR>',
                },
                options = {
                    use_cache = true
                },
                window = {
                    config = {
                        border = 'rounded'
                    },
                }
            })
        end
    },
    {
        'echasnovski/mini.files',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require('mini.files').setup({
                windows = {
                    preview = true,
                }
            })
        end
    }
}
