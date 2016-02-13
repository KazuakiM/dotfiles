" minimal vim start {{{
function! kazuakim#Minimal() abort "{{{
    setlocal noswapfile nobackup nowritebackup noundofile viminfo=
    filetype off
    filetype plugin indent off
    syntax off
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

" codic-vim {{{
function! kazuakim#Translate(text) abort "{{{
    let s:HTTP = ! exists('s:HTTP') ? vital#of('vital').import('Web.HTTP') : s:HTTP
    let s:JSON = ! exists('s:JSON') ? vital#of('vital').import('Web.JSON') : s:JSON
    if match(a:text, '\w') is# -1
        let l:options = {'sl': 'ja', 'tl': 'en'}
    else
        let l:options = {'sl': 'en', 'tl': 'ja'}
    endif
    let l:response = s:HTTP.post('http://translate.google.com/translate_a/t',
    \    extend({'client': '0', 'q': a:text}, l:options),
    \    {'User-Agent': 'Mozilla/5.0'})
    if l:response.status is# 200
        " qfixgrep {{{
        let g:QFix_PreviewEnable = 0
        "}}}
        cgetexpr PrettyPrint(s:JSON.decode(l:response.content))
        copen
    endif
endfunction "}}}
"}}}

" vim-quickrun {{{
function! kazuakim#PhpCsFixer(mode) abort "{{{
    let l:quickrun_config_backup = g:quickrun_config['php']
    let g:quickrun_config['php'] = {
    \    'command':               'php-cs-fixer',
    \    'cmdopt':                'fix --config=default --level=symfony',
    \    'exec':                  '%c %o %s:p',
    \    'outputter':             'buffer',
    \    'outputter/buffer/into': 1,
    \    'runner':                'system'}
    if a:mode ==# 'normal'
        let g:quickrun_config['php']['cmdopt'] = g:quickrun_config['php']['cmdopt'] .' --fixers=align_equals,align_double_arrow,concat_with_spaces'
    else
        let g:quickrun_config['php']['cmdopt'] = g:quickrun_config['php']['cmdopt'] .' --fixers=align_equals,align_double_arrow,-braces'
    endif
    let g:quickrun_config['php']['cmdopt'] = g:quickrun_config['php']['cmdopt']

    QuickRun

    let g:quickrun_config['php'] = l:quickrun_config_backup
endfunction "}}}
"}}}

" gundo.vim {{{
function! kazuakim#ClearUndo() abort "{{{
    let s:oldUndolevels = &undolevels
    set undolevels=-1
    execute "normal a \<BS>\<Esc>"
    let &undolevels = s:oldUndolevels
    unlet s:oldUndolevels
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
