"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" ------------------------------ PLUGINS ------------------------------

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

"FZF stuff"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File Directory "
Plug 'habamax/vim-dir'

" Syntax Highlighting"
Plug 'sheerun/vim-polyglot'

" Highlight Yank
Plug 'ubaldot/vim-highlight-yanked'

"Comments"
Plug 'tpope/vim-commentary'

"Status Line"
Plug 'itchyny/lightline.vim'

"Go"
Plug 'charlespascoe/vim-go-syntax'

"LSP"
Plug 'yegappan/lsp'

call plug#end()

" --------------------------------------------------------------------------

" ---------------------------- GENERAL SETTINGS ----------------------------
" enable syntax 
syntax on
filetype on
set nocompatible 
set mouse=a
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set number
set relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set expandtab
set autoindent
set smarttab
set hidden
" show the matching part of pairs [] {} and () 
set showmatch
set clipboard=unnamedplus 
set paste
set go+=a
set noswapfile
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window
" Settings for popup menu
set pumheight=25  " Maximum number of items to show in popup menu
" Splits direction
set splitbelow
set splitright
set noshowmode 

" Colorscheme
colorscheme habamax
hi Normal guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight CursorLineNr guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
set termguicolors

" --------------------------------------------------------------------------

" -------------------------------- MAPPINGS --------------------------------

let g:lf_replace_netrw = 1 
let g:lf_map_keys = 0

let mapleader = " "

" File finder
nmap <space><space> :Files<CR>
nmap <space>b :Buffers<CR>
nmap <space>o :History<CR>
"nmap <space>. :GFiles<CR>

" File Tree 
nnoremap <leader>e :Dir<CR>

" Yank from cursor to the end of line.
nnoremap Y y$

" Clear highlighting
nnoremap <leader>h :noh<CR>

" Search highlighted text
vnoremap / y/<C-R>"<CR>N

" Shift indents 
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Swap to last edited buffer
nnoremap <leader>p <CMD>b#<CR>

" Use shift to select completion options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" Terminal stuff
nnoremap <Leader>t :vert term<CR>
tnoremap <esc> <C-\><C-n>

" Resize windows
nnoremap <c-H> <c-w><
nnoremap <c-L> <c-w>>
nnoremap <c-J> <c-w>-
nnoremap <c-K> <c-w>+

" Close fzf with escape
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" --------------------------------------------------------------------------

" -------------------------------- STATUS LINE -----------------------------

" " Show the status on the second to last line.
set laststatus=2
let g:lightline = { 'colorscheme': 'Tomorrow_Night' }

" --------------------------------------------------------------------------

" ------------------------------- LOAD CONFIGS -----------------------------

"  LSP specifics
so ~/.vim/lsp-config.vim

