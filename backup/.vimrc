"
"
" NeoBundle {{{
" syntastic {{{
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 2
"}}}
" vim-sqlfix(local file refer) {{{
NeoBundle 'vim-sqlfix', {'base': '/srv/vim-plugin', 'type': 'nosync'}
"}}}
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
" vim-qfreplace {{{
" # command memo
" * ,qr    :replace all files.
NeoBundle 'thinca/vim-qfreplace'
nnoremap <Leader>qr :<C-u>Qfreplace<CR>
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
" vim-tags {{{
NeoBundle 'szw/vim-tags'
let g:vim_tags_auto_generate = 1
let g:vim_tags_cache_dir     = $HOME.'/.vim/vim-tags'
"}}}
" webapi-vim {{{
NeoBundle 'mattn/webapi-vim'
"}}}
" vim-prettyprint {{{
NeoBundle 'thinca/vim-prettyprint'
" quickrun - prettyprint {{{
"* URL: http://qiita.com/rbtnn/items/39d9ba817329886e626b
"* NoFormattings :echo neobundle#config#get_neobundles()
"* Formattings   :QuickRunPP neobundle#config#get_neobundles()
"* Formatting    :QuickRunPP neobundle#get('vim-markdown')
function! s:quickrun_pp(q_args)
    let a:dict = {
    \    'type':                      'vim', 'runner':           'vimscript', 'outputter':          'buffer',
    \    'outputter/buffer/filetype': 'vim', 'hook/eval/enable': 1,           'hook/eval/template': 'echo PP(%s)',
    \    'src':                       a:q_args}
    call quickrun#run(a:dict)
endfunction
command! -nargs=1 -complete=expression QuickRunPP :call<Space>s:quickrun_pp(<q-args>)
"}}}
"}}}
"}}}
"
"
" NeoBundleLazy {{{
" vim-over {{{
NeoBundleLazy 'osyo-manga/vim-over', {'autoload' : {'commands': 'OverCommandLine'}}
nnoremap <expr><Leader>%s ':OverCommandLine<CR>%s/'.expand('<cword>').'/'
"}}}
" neosnippet-snippets
" neosnippet.vim {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {'depends': ['KazuakiM/neosnippet-snippets', 'Shougo/neosnippet.vim', 'Shougo/context_filetype.vim'], 'autoload': {'insert': 1}}
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? '\<Plug>(neosnippet_expand_or_jump)' : pumvisible() ? '\<C-n>' : '\<TAB>'
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? '\<Plug>(neosnippet_expand_or_jump)' : '\<TAB>'
snoremap <ESC> <ESC>:NeoSnippetClearMarkers<CR>
set conceallevel=2 concealcursor=i
let g:neosnippet#data_directory           = $HOME.'/.vim/neosnippet.vim'
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
let g:neosnippet#snippets_directory       = $HOME.'/.vim/bundle/neosnippet-snippets/neosnippets'
"}}}
" unite-colorscheme {{{
NeoBundleLazy 'ujihisa/unite-colorscheme', {'depends': 'Shougo/unite.vim', 'unite_sources': 'colorscheme'}
nnoremap <silent> <SID>[unite]cs :<C-u>Unite<Space>-auto-preview<Space>colorscheme<CR>
"}}}
" unite-highlight {{{
NeoBundleLazy 'osyo-manga/unite-highlight', {'depends': 'Shougo/unite.vim', 'unite_sources': 'highlight'}
nnoremap <silent> <SID>[unite]hl :<C-u>Unite<Space>highlight<CR>
"}}}
" unite-tag {{{
NeoBundleLazy 'tsukkee/unite-tag', {'depends': 'Shougo/unite.vim', 'unite_sources': 'tag'}
nnoremap <silent> <SID>[unite]t :<C-u>Unite<Space>tag<CR>
let s:hooks = neobundle#get_hooks('unite-tag')
function! s:hooks.on_source(bundle)
    let g:unite_source_tag_max_name_length  = 30
    let g:unite_source_tag_max_fname_length = 128
    let g:unite_source_tag_show_location    = 0
endfunction
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
" emmet-vim {{{
"# command memo
"* URL: http://docs.emmet.io/cheat-sheet/
"* <C+y>,  :execute trigger key
"* html:5 <=入力後に<C+y>,
"* div>ul>li.class#id_$$*5 <=入力後に<C+y>,
NeoBundleLazy 'mattn/emmet-vim', {'filetypes': ['html', 'php', 'css', 'sass', 'scss', 'less']}
let s:hooks = neobundle#get_hooks('emmet-vim')
function! s:hooks.on_source(bundle)
    let g:user_emmet_settings = {
    \    'lang':        'ja',
    \    'indentation': '    ',
    \    'html':        {'filters': 'html'},
    \    'css':         {'filters': 'fc'},
    \    'php':         {
    \        'filters': 'html',
    \        'extends': 'html'}}
    let g:user_emmet_mode        = 'a'
    let g:use_emmet_complete_tag = 1
    "let g:user_emmet_leader_key=''
endfunction
"}}}
" vim-css3-syntax {{{
NeoBundleLazy 'hail2u/vim-css3-syntax', {'filetypes': ['html', 'php', 'css', 'sass', 'scss', 'less']}
"}}}
" vim-javascript {{{
NeoBundleLazy 'pangloss/vim-javascript', {'filetypes': ['html', 'php', 'javascript']}
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
NeoBundleFetch 'altercation/vim-colors-solarized'
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
