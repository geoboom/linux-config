let g:lua_tree_side = 'left'
let g:lua_tree_width = 40 
let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache' ] 
let g:lua_tree_auto_open = 0 
let g:lua_tree_auto_close = 0 
" let g:lua_tree_quit_on_open = 0 
let g:lua_tree_follow = 1 
let g:lua_tree_indent_markers = 1 
let g:lua_tree_hide_dotfiles = 1 
let g:lua_tree_git_hl = 1 
let g:lua_tree_root_folder_modifier = ':~' 
let g:lua_tree_tab_open = 1 
let g:lua_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 0,
    \ 'files': 0,
    \}
let g:lua_tree_bindings = {
    \ 'edit':            ['<CR>', 'o'],
    \ 'edit_vsplit':     '<C-v>',
    \ 'edit_split':      '<C-x>',
    \ 'edit_tab':        '<C-t>',
    \ 'toggle_ignored':  'I',
    \ 'toggle_dotfiles': 'H',
    \ 'refresh':         'R',
    \ 'preview':         '<Tab>',
    \ 'cd':              '<C-]>',
    \ 'create':          'a',
    \ 'remove':          'd',
    \ 'rename':          'r',
    \ 'cut':             'x',
    \ 'copy':            'c',
    \ 'paste':           'p',
    \ 'prev_git_item':   '[c',
    \ 'next_git_item':   ']c',
    \ }
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': ""
    \   }
    \ }

nnoremap <C-n> :LuaTreeToggle<CR>
nnoremap <leader>r :LuaTreeRefresh<CR>
nnoremap <leader>n :LuaTreeFindFile<CR>
" set termguicolors 
" highlight ColorColumn ctermbg=8
highlight LuaTreeFolderIcon guibg=blue

