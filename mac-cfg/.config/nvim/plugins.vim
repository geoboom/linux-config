" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Set up directory to install the plugins
let g:PLUGIN_HOME=expand(stdpath('data') . '/plugged')

call plug#begin(g:PLUGIN_HOME)
" ======== color
Plug 'andreasvc/vim-256noir'
Plug 'morhetz/gruvbox'
Plug 'fenetikm/falcon'

" ======== notes/diary
Plug 'lervag/vimtex'
Plug 'mattn/calendar-vim'
" need to run this:call mkdp#util#install()
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode'

" ======== coding
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rhysd/vim-clang-format'
Plug 'ericcurtin/CurtineIncSw.vim'

" ======== convenience/qol
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'

" ======== util
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons' |
            \ Plug 'flw-cn/vim-nerdtree-l-open-h-close'
Plug 'tpope/vim-fugitive'

call plug#end()
"""""""""""""""""""""""""""ericcurtin/CurtineIncSw.vim settings""""""""""""""""""""""""""""""
map <F5> :call CurtineIncSw()<CR>
"""""""""""""""""""""""""""clang_format settings""""""""""""""""""""""""""""""
" let g:clang_format#style_options = {
"             \ "AccessModifierOffset" : -4,
"             \ "AllowShortIfStatementsOnASingleLine" : "true",
"             \ "AlwaysBreakTemplateDeclarations" : "true",
"             \ "Standard" : "C++11",
"             \ "BreakBeforeBraces" : "Stroustrup"}
" " map to <Leader>cf in C++ code
" autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
" autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

"""""""""""""""""""""""""""airline settings""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:falcon_airline = 1
let g:airline_theme = 'falcon'

"""""""""""""""""""""""""""fzf.vim settings""""""""""""""""""""""""""""""
function! s:find_files()
    let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if git_dir != ''
        execute 'GFiles --cached' git_dir
    else
        execute 'Files'
    endif
endfunction
command! ProjectFiles execute s:find_files()

command! -bang -nargs=* Rg
            \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
            \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

nnoremap <C-p> :ProjectFiles<CR>
nnoremap <C-\> :Rg<Cr>
nnoremap <C-b> :Buffers<Cr>
nnoremap <leader>, :Buffers<Cr>
nnoremap <leader>h :History<Cr>
" nnoremap <C-h> :History<Cr>
" nnoremap <leader>b :Buffers<Cr>

"""""""""""""""""""""""""""nerdtree settings""""""""""""""""""""""""""""""
nnoremap <leader>n :NERDTree<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode    = get(g:, 'NERDTreeMapActivateNode',    'l')

"""""""""""""""""""""""""""nvim-lsp settings""""""""""""""""""""""""""""""
lua require('lsp_config')

