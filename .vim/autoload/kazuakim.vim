" minimal vim start {{{
function! kazuakim#Minimal() abort "{{{
    setlocal hlsearch
    setlocal ignorecase iminsert=0 imsearch=-1 incsearch
    setlocal noswapfile nobackup nowritebackup noundofile
    setlocal smartcase
    setlocal viminfo=
    filetype off
    filetype plugin indent off
    syntax off

    "  Replace
    nnoremap R gR
    nnoremap <expr><Leader>%s  ':%s/'. expand('<cword>') .'/'. expand('<cword>') .'/gc<Left><Left><Left>'
    nnoremap <expr><Leader>%%s ':%s/'. expand('<cword>') .'//gc<Left><Left><Left>'
    "  Search
    cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
    cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
    "  Register
    nnoremap x "_x
    nnoremap X "_x
    vnoremap <C-w> "ay
    vnoremap <C-e> "by
    nnoremap <expr>;s ':%s/<C-r>a/<C-r>b/gc'
endfunction "}}}
"}}}

" autocmd - QuickfixCmdPost {{{
function! kazuakim#QuickfixCmdPost() abort "{{{
    " qfixgrep {{{
    let g:QFix_PreviewEnable = 1
    "}}}
endfunction "}}}
"}}}

" vital.vim {{{
function! kazuakim#Path2ProjectDirectory(path) abort "{{{
    let s:Prelude = ! exists('s:Prelude') ? vital#of('vital').import('Prelude') : s:Prelude
    return s:Prelude.path2project_directory(a:path)
endfunction "}}}
"}}}

" unite.vim {{{
" http://qiita.com/yuku_t/items/9263e6d9105ba972aea8
function! kazuakim#UniteFileRecAsyncOrGit() abort "{{{
    if isdirectory(getcwd().'/.git')
        Unite -default-action=tabopen file_rec/git
    else
        Unite -default-action=tabopen file_rec/async:!
    endif
endfunction "}}}
"}}}

" vim-quickrun {{{
function! kazuakim#PhpCsFixer(mode) abort "{{{
    let l:quickrun_config_backup = g:quickrun_config['php']
    let g:quickrun_config['php'] = {
    \    'command':                'php-cs-fixer',
    \    'cmdopt':                 'fix --config=default --level=symfony --fixers=align_double_arrow,align_equals,concat_with_spaces,ordered_use,short_array_syntax',
    \    'exec':                   '%c %o %s:p',
    \    'outputter':              'buffer',
    \    'outputter/buffer/into':  1,
    \    'outputter/buffer/split': ':botright 4sp',
    \    'runner':                 'system'
    \}
    if a:mode ==# 'template'
        let g:quickrun_config['php']['cmdopt'] = g:quickrun_config['php']['cmdopt'] .',-braces'
    endif

    QuickRun

    let g:quickrun_config['php'] = l:quickrun_config_backup
endfunction "}}}

function! kazuakim#PhpInfo() abort "{{{
    let l:quickrun_config_backup = g:quickrun_config['php']
    let g:quickrun_config['php'] = {
    \    'command':                'php',
    \    'cmdopt':                 '-info',
    \    'exec':                   '%c %o',
    \    'outputter':              'buffer',
    \    'outputter/buffer/into':  1,
    \    'outputter/buffer/split': ':botright'
    \}
    " qfixgrep {{{
    let g:QFix_PreviewEnable = 0
    "}}}

    QuickRun

    let g:quickrun_config['php'] = l:quickrun_config_backup
    " qfixgrep {{{
    let g:QFix_PreviewEnable = 1
    "}}}
endfunction "}}}

function! kazuakim#EslintFix() abort "{{{
    let l:quickrun_config_backup                  = g:quickrun_config['javascript']
    let g:quickrun_config['javascript']['cmdopt'] = l:quickrun_config_backup['cmdopt'] .' --config '. $HOME .'/.eslintrc.js --fix'
    let g:quickrun_config['javascript']['runner'] = 'system'

    QuickRun

    let g:quickrun_config['javascript'] = l:quickrun_config_backup
endfunction "}}}
"}}}

" gundo.vim {{{
function! kazuakim#ClearUndo() abort "{{{
    let l:oldUndolevels = &l:undolevels
    setlocal undolevels=-1
    execute "normal! a \<BS>\<Esc>"
    write
    let &l:undolevels = l:oldUndolevels
    unlet l:oldUndolevels
endfunction "}}}
"}}}

" Database Switch (.vimrc.local) "{{{
function! kazuakim#DatabaseSwitch() abort "{{{
    let b:databaseIndex = ! exists('b:databaseIndex') ? 0 : b:databaseIndex + 1
    if len(g:KazuakiMDatabase) <= b:databaseIndex
        let b:databaseIndex = 0
    endif
    let g:quickrun_config['sql/mysql']['cmdopt'] = g:KazuakiMDatabase[b:databaseIndex]
    echo g:KazuakiMDatabase[b:databaseIndex]
endfunction "}}}
"}}}
