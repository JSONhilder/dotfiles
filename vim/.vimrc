" Vim Config file "
" --------------- "

" enable syntax "
syntax on


" enable mouse support "
set mouse=a

" enable wildmenu "
set wildmenu

" enable line numbers "
set number

" highlight current line "
" set cursorline
":highlight Cursorline cterm=bold ctermbg=black

" enable search highlight "
set hlsearch

" enable smartcase search "
set ignorecase
set smartcase

" Indentation using spaces "
" tabstop:	width of tab character
" softtabstop:	fine tunes the amount of whitespace to be added
" shiftwidth:	determines the amount of whitespace to add in normal mode
" expandtab:	when on use space instead of tab
" textwidth:	text wrap width
" autoindent:	autoindent in new line
set tabstop	=4
set softtabstop	=4
set shiftwidth	=4
set textwidth	=79
set expandtab
set autoindent

" show the matching part of pairs [] {} and () "
set showmatch

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
set clipboard+=unnamed
set clipboard+=unnamedplus

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" Completion behaviour
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

" Settings for popup menu
set pumheight=15  " Maximum number of items to show in popup menu

" Vim colorscheme "
colorscheme slate

