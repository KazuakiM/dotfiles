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
function! s:_KazuakimGuessClass(cw)
    let l:line = getline('.')
    let l:cword_start_pos = searchpos('\V' . escape(a:cw, '\'), 'bcW', line('.'))
    let l:prefix_end_index = l:cword_start_pos[1] - 2
    let l:prefix = l:prefix_end_index >= 0 ? l:line[:l:prefix_end_index] : ''

    if l:prefix =~# '\<use\>'
        return {'kind': ['c', 't', 'i'], 'name': a:cw, 'namespace': join(split(l:prefix[stridx(l:prefix, 'use ')+4:], '\'), '\\')}
    elseif l:prefix =~# '\<extends\>'
        return {'kind': ['c', 'i'], 'name': a:cw, 'namespace': ''}
    elseif l:prefix =~# '\<implements\>'
        return {'kind': ['i'], 'name': a:cw, 'namespace': ''}
    elseif l:prefix =~# '\<\k\+::$'
        return {'kind': ['c'], 'name': matchstr(l:prefix, '\<\zs\k\+\ze::$'), 'namespace': ''}
    endif

    return {'kind': ['c'], 'name': '', 'namespace': ''}
endfunction

function! s:KazuakimGuessClass(cw)
    let l:cursor_pos = getpos('.')
    let l:class = s:_KazuakimGuessClass(a:cw)
    call setpos('.', l:cursor_pos)
    return l:class
endfunction

function! s:KazuakimPhpTagJump(cw, tli)
    let l:class = s:KazuakimGuessClass(a:cw)
    let l:mul = 0
    for l:tag in a:tli
        if -1 < index(l:class.kind, l:tag.kind) && l:tag.name ==# l:class.name && ((0 < strlen(l:class.namespace) && l:tag.namespace ==# l:class.namespace) || 0 ==# strlen(l:class.namespace))
            let l:mul += 1
        endif
    endfor
    if l:class.name ==# '' || 1 < l:mul
        execute 'tab stselect ' . a:cw
        return
    endif

    for l:tag in a:tli
        if -1 < index(l:class.kind, l:tag.kind) && l:tag.name ==# l:class.name && ((0 < strlen(l:class.namespace) && l:tag.namespace ==# l:class.namespace) || 0 ==# strlen(l:class.namespace))
            let l:bufDel = 0
            if expand('%:p') !=# l:tag.filename
                tabnew kazuakim_dummy.php
                execute 'normal! a' . a:cw
                let l:bufDel = 1
            endif

            let l:jc = index(a:tli, l:tag) + 1
            execute 'normal!' l:jc."\<C-]>"

            if l:bufDel ==# 1
                bdelete! kazuakim_dummy.php
            endif
            return
        endif
    endfor
endfunction
"}}}

" vital.vim {{{
"function! kazuakim#Path2ProjectDirectory(path) abort "{{{
"    let s:Prelude = ! exists('s:Prelude') ? vital#of('vital').import('Prelude') : s:Prelude
"    return s:Prelude.path2project_directory(a:path)
"endfunction "}}}

function! kazuakim#Path2ProjectDirectory(path) abort "{{{
  let l:search_directory = isdirectory(a:path) ? a:path : fnamemodify(a:path, ':p:h')

  while 1
    let l:path = l:search_directory . '/.git'
    if isdirectory(l:path) || filereadable(l:path)
      return l:search_directory
    endif
    let l:next = fnamemodify(l:search_directory, ':h')
    if l:next == l:search_directory
      return ''
    endif
    let l:search_directory = l:next
  endwhile
endfunction "}}}
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
