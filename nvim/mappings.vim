inoremap <silent> jk <Esc>
nnoremap <silent> <Space><Space> :noh<CR>

" Go to start or end of line easier
" nnoremap H ^
" nnoremap L g_
nnoremap H gT
nnoremap L gt

" Disable TAB binding because it conflicts with <C-i>
" behavior to jump to next jumplist entry
" TAB in general mode will move to text buffer
" nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
" nnoremap <silent> <S-TAB> :bprevious<CR>

" easier buffer switching 
" nnoremap <Leader>b :buffers<CR>:buffer<Space>
" already handled by fzf.vim lul

" creates empty buffer in vertical split (<C-n> does it horizontally)
nnoremap <C-N> :vnew<CR>

" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$

" Navigation in the location and quickfix list
" not sure what this does lol
nnoremap [l :lprevious<CR>zv
nnoremap ]l :lnext<CR>zv
nnoremap [L :lfirst<CR>zv
nnoremap ]L :llast<CR>zv
nnoremap [q :cprevious<CR>zv
nnoremap ]q :cnext<CR>zv
nnoremap [Q :cfirst<CR>zv
nnoremap ]Q :clast<CR>zv

" Close location list or quickfix list if they are present,
" see https://superuser.com/q/355325/736190
nnoremap<silent> \x :windo lclose <bar> cclose<CR>

" Insert a blank line below or above current line (do not move the cursor),
" see https://stackoverflow.com/a/16136133/6064933
nnoremap <expr> oo 'm`' . v:count1 . 'o<Esc>``'
nnoremap <expr> OO 'm`' . v:count1 . 'O<Esc>``'

" Fast window switching
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k

" When completion menu is shown, use <cr> to select an item and do not add an
" annoying newline. Otherwise, <enter> is what it is. For more info , see
" https://superuser.com/a/941082/736190 and
" https://unix.stackexchange.com/q/162528/221410
inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
" Use <esc> to close auto-completion menu
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

" Edit and reload init.vim quickly
nnoremap <silent> \ev :tabnew $MYVIMRC <bar> tcd %:h<cr>
nnoremap <silent> \sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<cr>

" Change text without putting it into the vim register,
" see https://stackoverflow.com/q/54255/6064933
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc

" Move the cursor based on physical lines, not the actual lines.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0

nnoremap <silent> <leader>s :w<CR>
nnoremap <silent> <leader>q :wqa<CR>
nnoremap <silent> <leader>d :bd<CR>

nnoremap <silent> <C-q> :q!<CR>

autocmd filetype c noremap <F2> :w <bar> !gcc -Wall % -o %:r<CR> :wq <CR>
autocmd filetype c noremap <F3> :w <bar> !gcc -Wall % -o %:r<CR>
autocmd filetype c noremap <F4> :w <bar> !gcc -Wall % -o %:r && ./%:r <CR>
autocmd filetype cpp noremap <F4> :w <bar> !g++ -Wall -DLOCAL_DEFINE % -o %:r && ./%:r <CR>

" ddP: make sure pasted text is on the line above
inoremap <silent>\date <ESC>:r !date '+\%a \%d \%b'<CR>ddPi
inoremap <silent>\now <ESC>:r !date<CR>ddPi
nnoremap <silent>\date :r !date '+\%a \%d \%b'<CR>ddP
nnoremap <silent>\now :r !date<CR>ddP
:command! PDate :r !date '+\%a \%d \%b'

autocmd filetype qf nmap <buffer> <cr> <cr>:lcl<cr>
