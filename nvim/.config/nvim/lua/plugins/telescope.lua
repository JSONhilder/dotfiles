return {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
        local telescope = require("telescope")
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        telescope.setup({
            pickers = {
                live_grep = {
                    file_ignore_patterns = {
                        'node_modules',
                        '.git',
                        '.venv',
                        'vendor',
                        'zig-cache',
                        'zig-out'
                    },
                    additional_args = function(_)
                        return { "--hidden" }
                    end
                },
                find_files = {
                    file_ignore_patterns = {
                        'node_modules',
                        '.git',
                        '.venv',
                        'vendor',
                        'zig-cache',
                        'zig-out'
                    },
                    hidden = true
                }

            },
        })
    end
}
