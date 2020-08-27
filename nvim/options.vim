" relatve and absolute line numbers
set rnu nu

" good to have
set nocompatible

" always show tabs
set showtabline=2

" netrw ignore 
let g:netrw_list_hide= '.*\.swp$,node_modules'

"{ Builtin options and settings
" change filechar for folding, vertical split, and message sepator
set fillchars=fold:\ ,vert:\│,msgsep:‾

" Paste mode toggle, it seems that Neovim's bracketed paste mode
" does not work very well for nvim-qt, so we use good-old paste mode
set pastetoggle=<F12>

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=300
set ttimeoutlen=30

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
    set clipboard+=unnamedplus
endif

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

autocmd FileType scss setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType js setlocal ts=2 sts=2 sw=2

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

" Show line number and relative line number
" set number relativenumber

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" wild stuff
" List all items and start selecting matches in cmd completion
set wildmode=list:full
" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz

" Set a ruler at column 80, see https://stackoverflow.com/q/2447109/6064933
set colorcolumn=80

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=5

" Use mouse to select and resize windows, etc.
set mouse=nic  " Enable mouse in several mode
set mousemodel=popup  " Set the behaviour of mouse

" Do not show mode on command line since vim-airline can show it
set noshowmode

" The way to show the result of substitution in real time for preview
set inccommand=nosplit

" The number of command and search history to keep
set history=500

" Use list mode and customized listchars
" set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+ " not sure what this does

" Auto-write the file based on some condition
set autowrite

" Persistent undo even after you close a file and re-open it
set undofile

" Align indent to next multiple value of shiftwidth. For its meaning,
" compa
" see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
set shiftround

" Virtual edit is useful for visual block edit
set virtualedit=block

" Do not add two spaces after a period when joining lines or formatting texts,
" see https://stackoverflow.com/q/4760428/6064933
set nojoinspaces

" don't jump to start of line when switch buffer
set nostartofline

" Do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c
" Completion behaviour
" set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window
" Settings for popup menu
set pumheight=10  " Maximum number of items to show in popup menu
" Insert mode key word completion setting
set complete+=kspell complete-=w complete-=b complete-=u complete-=t
set spellsuggest+=10  " The number of suggestions shown in the screen for z=

set lazyredraw
set ttyfast
