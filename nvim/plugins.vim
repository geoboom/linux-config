" auto install vim-plug
let g:VIM_PLUG_PATH = expand(g:nvim_config_root . '/autoload/plug.vim')
if executable('curl')
    if empty(glob(g:VIM_PLUG_PATH))
        echomsg 'Installing Vim-plug on your system'
        silent execute '!curl -fLo ' . g:VIM_PLUG_PATH . ' --create-dirs '
                    \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

        augroup plug_init
            autocmd!
            autocmd VimEnter * PlugInstall --sync | quit |source $MYVIMRC
        augroup END
    endif
else
    echoerr 'You have to install curl to install vim-plug, or install '
                \ . 'vim-plug by yourself.'
    finish
endif

" Set up directory to install the plugins
let g:PLUGIN_HOME=expand(stdpath('data') . '/plugged')

call plug#begin(g:PLUGIN_HOME)

Plug 'vimwiki/vimwiki'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'alvan/vim-closetag'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'

call plug#end()

"""""""""""""""""""""""""""gruvbox settings""""""""""""""""""""""""""""""
autocmd vimenter * colorscheme gruvbox

"""""""""""""""""""""""""""goyo.vim settings""""""""""""""""""""""""""""""
nnoremap <C-g> :Goyo<Cr>

"""""""""""""""""""""""""""fzf.vim settings""""""""""""""""""""""""""""""
nnoremap <C-p> :Files<Cr>
nnoremap <C-\> :Rg<Cr>

"""""""""""""""""""""""""""vimtex settings""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer='zathura'
" let g:vimtex_view_general_options='-reuse-instance @pdf'
" let g:vimtex_view_general_options_latexmk='-reuse-instance'

" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
            \ 'overfull' : 0,
            \ 'underfull' : 0,
            \ 'packages' : {
            \   'default' : 0,
            \ },
            \}

"""""""""""""""""""""""""""vim-closetag settings""""""""""""""""""""""""""""""
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*js,*md'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*md'
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,markdown'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js,md'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'
"""""""""""""""""""""""""""coc-prettier settings""""""""""""""""""""""""""""""
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"""""""""""""""""""""""""""easymotion settings""""""""""""""""""""""""""""""
" map <leader> <Plug>(easymotion-prefix)

"""""""""""""""""""""""""""markdown-preview.nvim settings""""""""""""""""""""""""""""""
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '${name}'

autocmd FileType markdown nmap \ll <Plug>MarkdownPreview

"""""""""""""""""""""""""""coc.nvim settings""""""""""""""""""""""""""""""
source $HOME/.config/nvim/cocnvim.vim
