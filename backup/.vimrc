"
"
" NeoBundle {{{
" vdebug {{{
" # command memo
" * <F5>  : start/run (to next breakpoint/end of script)
" * <F2>  : step over
" * <F3>  : step into
" * <F4>  : step out
" * <F6>  : stop debugging
" * <F7>  : detach script from debugger
" * <F9>  : run to cursor
" * <F10> : set line breakpoint
" * <F11> : show context variables (e.g. after 'eval')
" * <F12> : evaluate variable under cursor
" * :Breakpoint <type> <args>: set a breakpoint of any type (see :help VdebugBreakpoints)
" * :VdebugEval <code>: evaluate some code and display the result
" * <Leader>e: evaluate the expression under visual highlight and display the result
NeoBundle 'joonty/vdebug'
"}}}
" html5.vim {{{
NeoBundle 'othree/html5.vim'
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete          = 1
let g:html5_microdata_attributes_complete     = 1
let g:html5_aria_attributes_complete          = 1
"}}}
" context_filetype.vim {{{
" setlocal html filetype at .vimrc.local (views/*.php is html filetype).
NeoBundle 'Shougo/context_filetype.vim'
let g:context_filetype#filetypes = {
\    'html': [
\        {
\            'start': '<script>',
\            'end':   '</script>', 'filetype': 'javascript'},
\        {
\            'start': '<script\%( [^>]*\)charset="[^\"]*"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript'},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript'},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/coffeescript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'coffee'},
\        {
\            'start': '<style\%( [^>]*\)\? type="text/css"\%( [^>]*\)\?>',
\            'end':   '</style>', 'filetype': 'css'},
\        {
\            'start': '<?',
\            'end':   '?>', 'filetype': 'php'}]}
let g:context_filetype#search_offset = 100
"}}}
" vim-precious {{{
augroup precious-indentline
    autocmd!
augroup END
NeoBundle 'osyo-manga/vim-precious'
let g:precious_enable_switch_CursorMoved   = {'*' : 0}
let g:precious_enable_switch_CursorMoved_i = {'*' : 0}
autocmd MyAutoCmd InsertEnter * :PreciousSwitch
autocmd MyAutoCmd InsertLeave * :PreciousReset
autocmd precious-indentline User PreciousFileType IndentLinesReset
"}}}
" vim-smartinput {{{
NeoBundle 'kana/vim-smartinput'
call smartinput#map_to_trigger('i', '*', '*', '*')
call smartinput#map_to_trigger('i', '!', '!', '!')
call smartinput#map_to_trigger('i', '=', '=', '=')
call smartinput#map_to_trigger('i', 'p', 'p', 'p')
call smartinput#define_rule({'at': '\%#',        'char': '"',    'input': '"',                 'filetype': ['vim'] })
call smartinput#define_rule({'at': '''\%#''',    'char': '<BS>', 'input': '<Del>'                                  })
call smartinput#define_rule({'at': '"\%#"',      'char': '<BS>', 'input': '<Del>'                                  })
call smartinput#define_rule({'at': '`\%#`',      'char': '<BS>', 'input': '<Del>'                                  })
call smartinput#define_rule({'at': '<\%#',       'char': '!',    'input': '!----><Left><Left><Left>'               })
call smartinput#define_rule({'at': '<!--\%#-->', 'char': '<BS>', 'input': '<Del><Del><Del>'                        })
call smartinput#define_rule({'at': '<?\%#',      'char': '=',    'input': '=?><Left><Left>',   'filetype': ['php'] })
call smartinput#define_rule({'at': '<?=\%#?>',   'char': '<BS>', 'input': '<Del><Del>',        'filetype': ['php'] })
call smartinput#define_rule({'at': '<?\%#',      'char': 'p',    'input': 'php?><Left><Left>', 'filetype': ['php'] })
call smartinput#define_rule({'at': '<?php\%#?>', 'char': '<BS>', 'input': '<Del><Del>',        'filetype': ['php'] })
call smartinput#define_rule({'at': '/\%#',       'char': '*',    'input': '**/<Left><Left>'                        })
call smartinput#define_rule({'at': '//\%#',      'char': '{',    'input': '{{{<Left><Left><Left><Left><Left>'      })
call smartinput#define_rule({'at': '//\%#',      'char': '}',    'input': '}}}<Left><Left><Left><Left><Left>'      })
call smartinput#define_rule({'at': '(\%#)',      'char': '<BS>', 'input': '<Del>'                                  })
call smartinput#define_rule({'at': '{\%#}',      'char': '<BS>', 'input': '<Del>'                                  })
call smartinput#define_rule({'at': '\[\%#\]',    'char': '<BS>', 'input': '<Del>'                                  })
"}}}
"vim-qfsigns {{{
NeoBundle 'KazuakiM/vim-qfsigns'
nnoremap <Leader>sy :QfsignsJunmp<CR>
let g:qfsigns#Config = {'id': '5050', 'name': 'KazuakiMQFError',}
execute 'sign define '.get(g:qfsigns#Config,'name').' linehl=KazuakiMQFError texthl=KazuakiMQFError text=>>'
"}}}
" ultisnips {{{
NeoBundle 'SirVer/ultisnips'
let g:did_UltiSnips_snipmate_compatibility = 1
let g:UltiSnipsEditSplit                   = 'vertical'
let g:UltiSnipsExpandTrigger               = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger         = '<S-TAB>'
let g:UltiSnipsJumpForwardTrigger          = '<TAB>'
let g:UltiSnipsSnippetsDir                 = s:envHome .'/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsUsePythonVersion            = 3
"neocomplete
let g:neocomplete#sources                  = {
\    '_':          ['ultisnips', 'file', 'buffer'],           'php': ['ultisnips', 'file', 'dictionary', 'buffer'],
\    'javascript': ['ultisnips', 'file', 'omni',    'buffer']}
"}}}
"}}}
"
"
" NeoBundleLazy {{{
" vim-over {{{
NeoBundleLazy 'osyo-manga/vim-over', {'commands': 'OverCommandLine'}
nnoremap <expr><Leader>%s  ':OverCommandLine<CR>%s/'.expand('<cword>').'/'.expand('<cword>').'/gc<Left><Left><Left>'
nnoremap <expr><Leader>%%s ':OverCommandLine<CR>%s/'.expand('<cword>').'//gc<Left><Left><Left>'
let s:hooks = neobundle#get_hooks('vim-over')
function! s:hooks.on_source(bundle) abort "{{{
    let g:over#command_line#substitute#highlight_string = 'SpellCap'
endfunction "}}}
"}}}
" incsearch.vim {{{
NeoBundleLazy 'haya14busa/incsearch.vim', {'mappings': '<Plug>(incsearch-forward)'}
nmap / <Plug>(incsearch-forward)
"}}}
" unite-webcolorname {{{
NeoBundleLazy 'pasela/unite-webcolorname', {'depends': 'Shougo/unite.vim', 'unite_sources': 'webcolorname'}
nnoremap <silent> <SID>[unite]web :<C-u>Unite<Space>webcolorname<CR>
"}}}
" vim-editvar {{{
NeoBundleLazy 'thinca/vim-editvar', 'depends': ['thinca/vim-prettyprint', 'Shougo/unite.vim'], 'unite_sources': 'variable'}
nnoremap <silent> <SID>[unite]v   :<C-u>Unite<Space>-auto-preview<Space>variable<CR>
"}}}
" jazzradio.vim {{{
NeoBundleLazy 'supermomonga/jazzradio.vim', {'unite_sources': 'jazzradio', 'commands': ['JazzradioUpdateChannels', 'JazzradioPlay']}
" jazzradio
nnoremap <SID>[jazzradio] <Nop>
nmap <Leader>j <SID>[jazzradio]
nnoremap <SID>[jazzradio]u :<C-u>JazzradioUpdateChannels<CR>
nnoremap <SID>[jazzradio]p :<C-u>JazzradioPlay<Space>CurrentJazz<CR>
nnoremap <SID>[jazzradio]o :<C-u>JazzradioStop<CR>
nnoremap <SID>[jazzradio]l :<C-u>Unite<Space>jazzradio<CR>
let s:hooks = neobundle#get_hooks('jazzradio.vim')
function! s:hooks.on_source(bundle)
    let g:jazzradio#cache_dir = $HOME.'/.vim/jazzradio.vim'
endfunction
"}}}
" vim-regexper {{{
NeoBundleLazy 'KazuakiM/vim-regexper', {'commands': 'RegexperExecute'}
let g:regexper#AppPath = $HOME.'/.vim/bundle/regexper'
let g:regexper#OpenCmd = 'open -a firefox'
nnoremap <Leader>reg :<C-u>RegexperExecute<Space>
"}}}
" vimshell.vim {{{
NeoBundleLazy 'Shougo/vimshell.vim', {'depends': 'Shougo/vimproc.vim', 'commands': ['VimShell', 'VimShellPop', 'VimShellInteractive']}
nnoremap <SID>[vimshell.vim] <Nop>
nmap <Leader>sh <SID>[vimshell.vim]
nnoremap <silent> <SID>[vimshell.vim]s :<C-u>VimShell<CR>
nnoremap <silent> <SID>[vimshell.vim]p :<C-u>VimShellPop<CR>
nnoremap <silent> <SID>[vimshell.vim]i :<C-u>VimShellInteractive
let s:hooks = neobundle#get_hooks('vimshell.vim')
function! s:hooks.on_source(bundle)
    let g:vimshell_data_directory = $HOME.'/.vim/vimshell.vim/cache'
    let g:vimshell_vimshrc_path   = $HOME.'/.vim/vimshell.vim/vimshrc/.vimshrc'
endfunction
"}}}
" sass-compile.vim {{{
NeoBundleLazy 'AtsushiM/sass-compile.vim', {'filetypes': ['sass', 'scss']}
let s:hooks = neobundle#get_hooks('sass-compile.vim')
function! s:hooks.on_source(bundle)
    let g:sass_compile_cdloop = 5
    let g:sass_compile_auto   = 1
    let g:sass_compile_file   = ['sass', 'scss']
    let g:sass_compile_cssdir = ['css',  'stylesheet']
    autocmd MyAutoCmd BufWritePost *.sass,*.scss SassCompile
endfunction
"}}}
" vim-coffee-script {{{
NeoBundleLazy 'kchmck/vim-coffee-script', {'filetypes': 'coffee'}
let s:hooks = neobundle#get_hooks('vim-coffee-script')
function! s:hooks.on_source(bundle)
    autocmd MyAutoCmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
endfunction
"}}}
"}}}
"
"
" NeoBundleFetch {{{
set t_Co=256
NeoBundleFetch 'nanotech/jellybeans.vim'
NeoBundleFetch 'tomasr/molokai'
NeoBundleFetch 'ziadoz/awesome-php'
NeoBundleFetch 'javallone/regexper'
"}}}
"
"
" Extra local functions {{{
" File/Buffer information {{{
function! FileInfo(filename)
    let a:fn = expand('%:p')
    echo '[filename ]'.a:fn
    echo '[type     ]'.getftype(a:fn)
    echo '[mtime    ]'.strftime('%Y-%m-%d %H:%M %a', getftime(a:fn))
    echo '[size     ]'.getfsize(a:fn).' bytes'
    echo '[perm     ]'.getfperm(a:fn)
endfunction
function! BufferInfo()
    echo '[bufnr    ]'.bufnr('%')
    echo '[bufname  ]'.expand('%:p')
    echo '[cwd      ]'.getcwd()
    if filereadable(expand('%'))
        echo '[mtime    ]'.strftime('%Y-%m-%d %H:%M %a',getftime(expand('%')))
    endif
    echo '[size     ]'.(line2byte(line('$') + 1) - 1) . ' bytes'
    echo '[filetype ]'.&ft
    echo '[expandtab]'.(&et ? 'true' : 'false')
    echo '[tabstop  ]'.&ts
endfunction
nnoremap <F2> :call<Space>FileInfo(expand('<cfile>'))<CR>
nnoremap <F3> :call<Space>BufferInfo()<CR>
"}}}
"}}}
