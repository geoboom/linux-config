let g:nvim_config_root=expand('<sfile>:p:h')

let mapleader="\<Space>"

" set cursorline
" :hi CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=white

" For vim to jump to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

colorscheme 256_noir
" Change highlighting of cursor line when entering/leaving Insert Mode
set cursorline
highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212

" let g:loaded_matchparen=1
hi MatchParen cterm=underline ctermbg=none ctermfg=yellow

source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/mappings.vim

hi CocErrorFloat guifg=#000000
hi CocWarningFloat guifg=#000000
highlight ColorColumn ctermbg=8
hi MatchParen cterm=underline ctermbg=none ctermfg=grey
