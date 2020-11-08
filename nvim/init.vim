let g:nvim_config_root=expand('<sfile>:p:h')

let mapleader="\<Space>"

set cursorline
:hi CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=white

" let g:loaded_matchparen=1
hi MatchParen cterm=underline ctermbg=none ctermfg=yellow

source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/mappings.vim

hi CocErrorFloat guifg=#000000
hi CocWarningFloat guifg=#000000
