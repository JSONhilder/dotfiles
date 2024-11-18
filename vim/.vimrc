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
Plug 'nanotech/jellybeans.vim' 

"File Tree"
Plug 'preservim/nerdtree'

"Syntax Highlighting"
Plug 'sheerun/vim-polyglot'

"LSP"
Plug 'yegappan/lsp'

"Comments"
Plug 'tpope/vim-commentary'

"Status Line"
Plug 'itchyny/lightline.vim'

"Go Stuff"
Plug 'charlespascoe/vim-go-syntax'

"C3 Stuff"
Plug 'Airbus5717/c3.vim'

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
" NerdTree Settings
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
let NERDTreeWinPos = "right"

" Colorscheme
set termguicolors
colorscheme jellybeans
hi Normal guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight CursorLineNr guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE

" --------------------------------------------------------------------------

" -------------------------------- MAPPINGS --------------------------------

let mapleader = " "

" File finder
nmap <space>f :Files<CR>
nmap <space>b :Buffers<CR>
nmap <c-p> :GFiles<CR>
nmap <c-b> :Buffers<CR>
nmap <c-o> :History<CR>

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

" Search highlighted text
vnoremap / y/<C-R>"<CR>N

" Shift indents 
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

vnoremap Y <CMD>'<,'>w !xclip -sel clip<CR><CR>

" Swap to last edited buffer
nnoremap <leader>p <CMD>b#<CR>

" Use shift to select completion options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" --------------------------------------------------------------------------

" -------------------------------- STATUS LINE -----------------------------

" " Show the status on the second to last line.
set laststatus=2
let g:lightline = {'colorscheme': 'jellybeans'}

" --------------------------------------------------------------------------

" ------------------------------- LOAD CONFIGS -----------------------------

"  LSP specifics
" so ~/.vim/lsp-config.vim

