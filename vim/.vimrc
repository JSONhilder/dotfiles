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

call plug#begin()

"FZF stuff"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Colorscheme"
Plug 'eemed/sitruuna.vim'

"File Tree"
Plug 'preservim/nerdtree'

"Syntax Highlighting"
Plug 'sheerun/vim-polyglot'

"LSP"
Plug 'yegappan/lsp'

"Comments"
Plug 'tpope/vim-commentary'

call plug#end()

" --------------------------------------------------------------------------

" ---------------------------- GENERAL SETTINGS ----------------------------
" enable syntax "
syntax on
filetype on

set nocompatible 

" enable mouse support "
set mouse=a

" enable wildmenu "
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" enable line numbers "
set number

" enable search highlight "
set hlsearch
set incsearch

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set expandtab
set autoindent
set smarttab

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
set pumheight=25  " Maximum number of items to show in popup menu

set splitbelow
set splitright

" Highlight line under cursor. It helps with navigation.
set cursorline
set cursorlineopt=number

" NerdTree Settings
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

colorscheme sitruuna

" --------------------------------------------------------------------------

" -------------------------------- MAPPINGS --------------------------------

let mapleader = " "

" File finder
nmap <Leader>p :FZF<CR>
nmap <Leader>b :Buffers<CR>

" File Tree 
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>h :noh<CR>

" Yank from cursor to the end of line.
nnoremap Y y$

" Navigate the split view easier 
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Allow for easy copying and pasting
vnoremap <silent> y y`]
nnoremap <silent> p p`]

" --------------------------------------------------------------------------

" -------------------------------- STATUS LINE -----------------------------

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

hi Statusline ctermbg=black ctermfg=grey

" --------------------------------------------------------------------------

" ------------------------------- LOAD CONFIGS -----------------------------
"  LSP specifics
so ~/.vim/lsp-config.vim
