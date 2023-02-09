let g:nvim_config_root=expand('<sfile>:p:h')

let mapleader="\<Space>"

source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/mappings.vim

"""""""""""""""""""""""""""""""" jump to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" colorscheme 256_noir config
" colorscheme 256_noir
" set cursorline
" highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
" autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c
" autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" colorscheme gruvbox config
" autocmd vimenter * ++nested colorscheme gruvbox
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" colorscheme falcon config
let g:falcon_background = 0
let g:falcon_inactive = 1
set termguicolors
autocmd vimenter * ++nested colorscheme falcon
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" not sure wtf this is for again...
" let g:loaded_matchparen=1
" hi MatchParen cterm=underline ctermbg=none ctermfg=yellow
" highlight ColorColumn ctermbg=8
" hi MatchParen cterm=underline ctermbg=none ctermfg=grey
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" trim whitespace on file save
function TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
command! TrimWhitespace call TrimWhitespace()
autocmd BufWritePre * call TrimWhitespace()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" type :CP to paste a convenient C++ template
function InjectCPTemplate(template_path)
    execute ":0read " . a:template_path
    execute ":8"
endfunction
let template_path = "/home/geoboom/template.cpp"
command! CP call InjectCPTemplate(template_path)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""" function name self-explantory
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

