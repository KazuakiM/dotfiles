" minimal vim start {{{
function! kazuakim#Minimal() abort "{{{
    setlocal clipboard+=autoselect,unnamed
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

" Tab {{{
function! kazuakim#TabMove() abort "{{{
    let l:nowCount = tabpagenr()
    let l:maxCount = tabpagenr("$")

    if l:nowCount < l:maxCount
        +tabmove
    else
        0tabmove
    endif
endfunction "}}}
"}}}

" tags {{{
function! kazuakim#TagJumper() abort "{{{
    let l:cw = expand('<cword>')
    let l:tli = taglist('^' . l:cw . '$')
    if len(l:tli) ==# 1 && l:tli[0].name ==# l:cw
        if expand('%:p') ==# l:tli[0].filename
            execute 'tjump ' . l:cw
        else
            execute 'tab stjump ' . l:cw
        endif
        return
    endif

    if &filetype is# 'php'
        call s:KazuakimPhpTagJump(l:cw, l:tli)
    else
        execute 'tab stselect ' . l:cw
    endif
endfunction "}}}

" http://inside.pixiv.net/entry/2016/12/10/000000
let g:mabuchi = {}
function! s:_KazuakimGuessClassName(cw)
    let l:line = getline('.')
    let l:cword_start_pos = searchpos('\V' . escape(a:cw, '\'), 'bcW', line('.'))
    let l:prefix_end_index = l:cword_start_pos[1] - 2
    let l:prefix = l:prefix_end_index >= 0 ? l:line[:l:prefix_end_index] : ''

    if l:prefix =~# '\<self::$' || l:prefix =~# '$this->$'
        normal! 999[{
        if search('\<class\>', 'bW') == 0
            return ''
        endif
        normal! W
        return expand('<cword>')
    elseif l:prefix =~# ' extends ' || l:prefix =~# ' implements '
        return a:cw
    elseif l:prefix =~# '\<\k\+::$'
        return matchstr(l:prefix, '\<\zs\k\+\ze::$')
    endif
    return ''
endfunction

function! s:KazuakimGuessClassName(cw)
    let l:cursor_pos = getpos('.')
    let l:class_name = s:_KazuakimGuessClassName(a:cw)
    call setpos('.', l:cursor_pos)
    return l:class_name
endfunction

function! s:KazuakimPhpTagJump(cw, tli)
    let l:class_name = s:KazuakimGuessClassName(a:cw)
    if l:class_name != ''
        for l:tag in a:tli
            if (has_key(l:tag, 'class') && l:tag.class ==# l:class_name)||
                \ (l:tag.kind ==# 'c' && l:tag.name ==# l:class_name)
                "FIXME:tagnew
                "if expand('%:p') !=# l:tag.filename
                "    tabnew
                "    "lcd fnameescape(expand('%:p:h'))
                "    "setlocal filetype=php tags=xxx
                "    "execute 'normal! a' . a:cw
                "endif
                let l:jc = index(a:tli, l:tag) + 1
                execute 'normal!' l:jc."\<C-]>"
                return
            endif
        endfor
    else
        execute 'tab stselect ' . a:cw
    endif
endfunction
"}}}

" nerdtree {{{
function! kazuakim#NerdTreeCurrentDir() abort "{{{
    execute 'NERDTree ' . fnameescape(expand('%:p:h'))
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
function! kazuakim#Test() abort "{{{
    let l:quickrun_config_backup = g:quickrun_config[&filetype]
    if &filetype is# 'php'
        let g:quickrun_config['php'] = {
        \    'command':                'phpunit',
        \    'exec':                   '%c %s',
        \    'outputter':              'buffer',
        \    'outputter/buffer/split': ':botright 7sp',
        \    'runner':                 'vimproc'
        \}
    endif

    QuickRun

    if &filetype is# 'php'
        let g:quickrun_config[&filetype] = l:quickrun_config_backup
    endif
endfunction "}}}

function! kazuakim#Lint() abort "{{{
    let l:quickrun_config_backup = g:quickrun_config[&filetype]
    if &filetype is# 'php'
        let g:quickrun_config['php'] = {
        \    'command':                'php-cs-fixer',
        \    'cmdopt':                 'fix',
        \    'exec':                   '%c %o %s:p',
        \    'outputter':              'buffer',
        \    'outputter/buffer/into':  1,
        \    'outputter/buffer/split': ':botright 4sp',
        \    'runner':                 'system'
        \}
    elseif &filetype is# 'javascript'
        let g:quickrun_config['javascript']['cmdopt'] = l:quickrun_config_backup['cmdopt'] . ' --config ' . $HOME . '/.config/eslint/eslintrc --fix'
        let g:quickrun_config['javascript']['runner'] = 'system'
    endif

    QuickRun

    if 0 < count(['php', 'javascript'], &filetype)
        let g:quickrun_config[&filetype] = l:quickrun_config_backup
    endif
endfunction "}}}

function! kazuakim#PhpInfo() abort "{{{
    let l:quickrun_config_backup = g:quickrun_config['php']
    let g:quickrun_config['php'] = {
    \    'command':   'php',
    \    'cmdopt':    '-info',
    \    'exec':      '%c %o',
    \    'outputter': 'buffer'
    \}

    QuickRun

    let g:quickrun_config['php'] = l:quickrun_config_backup
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

" Wrap Switch "{{{
function! kazuakim#WrapSwitch() abort "{{{
    if &wrap ==# 1
        set nowrap nobreakindent
        unmap j
        unmap k
    else
        set wrap breakindent
        nmap j gj
        nmap k gk
    endif
endfunction "}}}
"}}}
