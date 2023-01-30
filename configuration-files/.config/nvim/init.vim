let g:nvim_config_root=expand('<sfile>:p:h')

let mapleader="\<Space>"

" set cursorline
" :hi CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=white

" For vim to jump to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

set background=dark

"""""""""""""""""""""""""""""""" colorscheme 256_noir config start
" colorscheme 256_noir
" set cursorline
" highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
" autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c
" autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
"""""""""""""""""""""""""""""""" colorscheme 256_noir config end

"""""""""""""""""""""""""""""""" colorscheme gruvbox config end
autocmd vimenter * ++nested colorscheme gruvbox
"""""""""""""""""""""""""""""""" colorscheme gruvbox config end

" let g:loaded_matchparen=1
hi MatchParen cterm=underline ctermbg=none ctermfg=yellow
highlight ColorColumn ctermbg=8
hi MatchParen cterm=underline ctermbg=none ctermfg=grey

source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/mappings.vim

" hi CocErrorFloat guifg=#000000
" hi CocWarningFloat guifg=#000000

set foldlevelstart=99
set foldmethod=syntax
set foldopen=hor,mark,percent,quickfix,search,tag,undo
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" for me to spam leader + s / \ + s / space + s for save file
nnoremap s <Nop>

" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" <BSLASH><BSLASH> toggles between buffers
nnoremap <BSLASH><BSLASH> <c-^>

function TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
command! TrimWhitespace call TrimWhitespace()

autocmd BufWritePre * call TrimWhitespace()

function InjectCPTemplate(template_path)
    execute ":0read " . a:template_path
    execute ":8"
endfunction

let template_path = "/home/geoboom/template.cpp"
command! CP call InjectCPTemplate(template_path)

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

