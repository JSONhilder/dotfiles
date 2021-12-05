vim.o.background = "dark"
vim.g.vscode_style = "dark"
vim.cmd([[
    colorscheme vscode
    syntax on
    filetype on
    filetype plugin indent on
    highlight GitSignsAddLn guifg=#b8bb26
    highlight GitSignsAddLn guibg=#1e1e1e
    highlight GitSignsChange guifg=#8ec07c
    highlight GitSignsDelete guifg=#cc241d
]])
