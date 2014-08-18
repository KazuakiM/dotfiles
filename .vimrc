"
"
" Memo
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" :help internal-variables {{{
"------------------------------------------------------------------------
"| b: | buffer-variable   | Local to the current buffer.                |
"| w: | window-variable   | Local to the current window.                |
"| t: | tabpage-variable  | Local to the current tab page.              |
"| g: | global-variable   | Global.                                     |
"| l: | local-variable    | Local to a function.                        |
"| s: | script-variable   | Local to a :source'ed Vim script.           |
"| a: | function-argument | Function argument (only inside a function). |
"| v: | vim-variable      | Global, predefined by Vim.                  |
"------------------------------------------------------------------------ }}}
" :help map {{{
"---------------------------------------------------------------------------------------------------------------------------------
"|commands:                                     |modes:                                                                          |
"| Variables | Constants |  Unset  |  Destroy   | Normal | Visual | Select | Operator-pending | Insert | Command-line | Lang-Arg |
"|   :map    | :noremap  | :unmap  | :mapclear  |  yes   |  yes   |  yes   |       yes        |   -    |      -       |    -     |
"|   :nmap   | :nnoremap | :nunmap | :nmapclear |  yes   |   -    |   -    |        -         |   -    |      -       |    -     |
"|   :vmap   | :vnoremap | :vunmap | :vmapclear |   -    |  yes   |  yes   |        -         |   -    |      -       |    -     |
"|   :omap   | :onoremap | :ounmap | :omapclear |   -    |   -    |   -    |       yes        |   -    |      -       |    -     |
"|   :xmap   | :xnoremap | :xunmap | :xmapclear |   -    |  yes   |   -    |        -         |   -    |      -       |    -     |
"|   :smap   | :snoremap | :sunmap | :smapclear |   -    |   -    |  yes   |        -         |   -    |      -       |    -     |
"|   :map!   | :noremap! | :unmap! | :mapclear! |   -    |   -    |   -    |        -         |  yes   |     yes      |    -     |
"|   :imap   | :inoremap | :iunmap | :imapclear |   -    |   -    |   -    |        -         |  yes   |      -       |    -     |
"|   :cmap   | :cnoremap | :cunmap | :cmapclear |   -    |   -    |   -    |        -         |   -    |     yes      |    -     |
"|   :lmap   | :lnoremap | :lunmap | :lmapclear |   -    |   -    |   -    |        -         |  yes*  |     yes*     |   yes*   |
"--------------------------------------------------------------------------------------------------------------------------------- }}}
"}}}
"
"
" Common
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if has('vim_starting')
    set nocompatible
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
augroup MyAutoCmd
    autocmd!
augroup END
augroup precious-indentline
    autocmd!
augroup END
" Variable
"let s:localtime=localtime()
"let s:time=strftime('%Y%m%d%H%M%S',s:localtime)
"let s:date_hour=strftime('%Y%m%d%H',s:localtime)
" Encode
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileformat=unix
" Basic
let mapleader=','
set scrolloff=5
autocmd MyAutoCmd FileType * setlocal textwidth=0
autocmd MyAutoCmd FileType * setlocal formatoptions-=cb
set autoread
set hidden
set ambiwidth=double
set spelllang+=cjk
"set spell
set backspace=indent,eol,start
set virtualedit+=block
set visualbell t_vb=
set noerrorbells
set foldmethod=marker
set viminfo+=n~/.vim/viminfo/.viminfo
set updatetime=1000
nnoremap zx :<C-U>%foldopen<CR>
set matchpairs+=<:>
nnoremap 0 $
nnoremap 1 ^
nnoremap gr gT
nnoremap fa <C-w>+
nnoremap j; <C-w>-
nnoremap fd <C-w>>
nnoremap jk <C-w><
"paste
nnoremap <silent><expr><Leader>v  ':set<Space>paste<CR><Insert><C-r>+<ESC>:set<Space>nopaste<CR>'
inoremap <silent><expr><C-v> '<ESC>:set<Space>paste<CR><Insert><C-r>+<ESC>:set<Space>nopaste<CR><Insert>'
" Color
syntax on
set t_Co=256
" Check space and newLineCode.
autocmd MyAutoCmd ColorScheme * highlight TabString        cterm=reverse ctermfg=darkgray
autocmd MyAutoCmd VimEnter,WinEnter * let w:m1 = matchadd('TabString',        "\t")
autocmd MyAutoCmd ColorScheme * highlight CrString         cterm=reverse ctermfg=darkred
autocmd MyAutoCmd VimEnter,WinEnter * let w:m2 = matchadd('CrString',         "\r")
autocmd MyAutoCmd ColorScheme * highlight CrlfString       cterm=reverse ctermfg=darkmagenta
autocmd MyAutoCmd VimEnter,WinEnter * let w:m3 = matchadd('CrlfString',       "\r\n")
autocmd MyAutoCmd ColorScheme * highlight WhitespaceEOL    cterm=reverse ctermfg=lightmagenta
autocmd MyAutoCmd VimEnter,WinEnter * let w:m4 = matchadd('WhitespaceEOL',    '\s\+$')
autocmd MyAutoCmd ColorScheme * highlight IdeographicSpace cterm=reverse ctermfg=lightred
autocmd MyAutoCmd VimEnter,WinEnter * let w:m5 = matchadd('IdeographicSpace', '　')
" Update Visual mode target colorScheme.
autocmd MyAutoCmd ColorScheme * highlight Visual cterm=reverse ctermfg=lightgreen
colorscheme jellybeans
" Show
set title
set ruler
set laststatus=2
set wildignore+=*.git,*.svn,*.log,*.bmp,*.gif,*.ico,*.jpg,*.png,.DS_Store
set wildmenu
set wildmode=longest:full,full
" [memo]
" q:  command history
" q/  downward search
" q?  upward search
set history=1000
set number
set cursorline
set cursorcolumn
" Clipboard
set clipboard+=autoselect,unnamed
" Backup
set backup
set backupdir=$HOME/.vim/backup
set swapfile
set directory=$HOME/.vim/swap
set noundofile
"set undofile
"autocmd MyAutoCmd VimEnter * call s:auto_mkdir($HOME.'/.vim/undo/'.s:date_hour.'/', 1)
"let g:undodir_path=$HOME.'/.vim/undo/'.s:date_hour.'/'
"set undodir=eval(g:undodir_path)
" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set smarttab
" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
nnoremap <expr><Leader>%s ':%s/'.expand('<cword>').'//gc<Left><Left><Left>'
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" pretty print
nnoremap <Leader>xml  :execute '%!xmllint --noblanks --nowrap --encode UTF-8 --format %'<CR>
nnoremap <Leader>json :execute '%!python -m json.tool'<CR>
" SQL
let g:sql_type_default='mysql'
" PHP
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
" Vim
nnoremap [vim] <Nop>
nmap <Leader>f [vim]
nnoremap [vim]e :tabnew $MYVIMRC<CR>
nnoremap [vim]s :source $MYVIMRC<CR>
nnoremap [vim]h :source $VIMRUNTIME/syntax/colortest.vim<CR>
" Close sub window
autocmd MyAutoCmd CmdwinEnter * nmap <silent> <ESC><ESC> :q<CR>
autocmd MyAutoCmd CmdwinLeave * nunmap <ESC><ESC>
"}}}
"
"
" NeoBundle START
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
call neobundle#begin(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
let g:neobundle#log_filename = $HOME.'/.vim/neobundle.vim/neobundle.log'
"}}}
"
"
" NeoBundle
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if neobundle#has_cache()
    NeoBundleLoadCache
else
    " vimproc {{{
    NeoBundle 'Shougo/vimproc', {
    \    'build' : {
    \        'mac'  : 'make -f make_mac.mak',
    \        'unix' : 'make -f make_unix.mak',},} "}}}
    NeoBundle 'vim-jp/vital.vim'
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'itchyny/landscape.vim'
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'Yggdroot/indentLine'
    NeoBundle 'Shougo/context_filetype.vim'
    NeoBundle 'osyo-manga/vim-precious'
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
    NeoBundle 'joonty/vdebug' "}}}
    NeoBundle 'thinca/vim-ref'
    NeoBundle 'szw/vim-tags'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'vim-scripts/matchit.zip'
    NeoBundle 'tpope/vim-endwise'
    NeoBundle 'fuenor/qfixgrep'
    " vim-qfreplace {{{
    " # command memo
    " * ,qr    :replace all files.
    NeoBundle 'thinca/vim-qfreplace' "}}}
    NeoBundle 'LeafCage/yankround.vim'
    NeoBundle 'glidenote/memolist.vim'
    " vim-quickrun {{{
    " # command memo
    " * :QuickRun :execute quickrun.
    NeoBundle 'thinca/vim-quickrun' "}}}
    NeoBundle 'thinca/vim-prettyprint'
    NeoBundle 'othree/html5.vim'
    NeoBundle 'KazuakiM/vim-snippets'
    NeoBundle 'SirVer/ultisnips'
    "NeoBundle 'KazuakiM/neosnippet-snippets'
    "NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'vim-scripts/Align'
    NeoBundle 'vim-scripts/SQLUtilities'

    NeoBundleSaveCache
endif
" lightline {{{
let g:lightline = {
\    'colorscheme': 'landscape',
\    'active': {
\        'left':  [['mode','paste',],['fugitive','filename',],],
\        'right': [['qfstatusline','lineinfo',],['percent',],['fileformat','fileencoding','filetype',],],},
\    'component_function': {
\        'fugitive':     'MyFugitive',
\        'filename':     'MyFilename',
\        'fileformat':   'MyFileformat',
\        'filetype':     'MyFiletype',
\        'fileencoding': 'MyFileencoding',
\        'mode':         'MyMode',},
\    'component_expand': {
\        'qfstatusline': 'qfstatusline#Update',},
\    'component_type': {
\        'qfstatusline': 'error',},
\    'subseparator': {
\        'left':  '|',
\        'right': '|',},}
function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
    return &ft !~? 'help' && &readonly ? 'x' : ''
endfunction
function! MyFilename()
    let fname = expand('%:t')
    return fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
    try
        if expand('%:t') !~? 'Gundo\|NERD' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction
function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyMode()
    let fname = expand('%:t')
    return fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:unite_force_overwrite_statusline = 0
"}}}
" indentLine {{{
let g:indentLine_faster = 1
"}}}
" context_filetype.vim {{{
" setlocal html filetype at .vimrc.local (views/*.php is html filetype).
let g:context_filetype#filetypes = {
\    'html': [
\        {
\            'start': '<script>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)charset="[^\"]*"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/coffeescript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'coffee',},
\        {
\            'start': '<style\%( [^>]*\)\? type="text/css"\%( [^>]*\)\?>',
\            'end':   '</style>', 'filetype': 'css',},
\        {
\            'start': '<?',
\            'end':   '?>', 'filetype': 'php',},],}
let g:context_filetype#search_offset = 100
"}}}
" vim-precious {{{
let g:precious_enable_switch_CursorMoved = {
\    '*' : 0,}
let g:precious_enable_switch_CursorMoved_i = {
\    '*' : 0,}
autocmd MyAutoCmd InsertEnter * :PreciousSwitch
autocmd MyAutoCmd InsertLeave * :PreciousReset
autocmd precious-indentline User PreciousFileType IndentLinesReset
"}}}
" vim-ref {{{
let g:ref_cache_dir=$HOME.'/.vim/vim-ref/cache'
let g:ref_phpmanual_path=$HOME.'/.vim/vim-ref/php-chunked-xhtml'
"}}}
" vim-tags {{{
let g:vim_tags_auto_generate = 1
nnoremap <Leader>tags :TagsGenerate
nnoremap <Leader>] <C-]>
nnoremap <Leader>[ <C-o>
nnoremap <Leader>ts :ts<CR>
" add .vimrc.local
"}}}
" vim-qfreplace {{{
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
let QFixWin_EnableMode = 1
let QFix_UseLocationList = 1
nnoremap <expr> <Leader>grep ':silent grep! '.expand('<cword>').' '.vital#of("vital").import("Prelude").path2project_directory("%").'<CR>'
nnoremap <Leader>qr :Qfreplace<CR>
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
"}}}
" yankround.vim {{{
let g:yankround_dir=$HOME.'/.vim/yankround.vim'
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_use_region_hl = 1
highlight YankRoundRegion cterm=underline ctermfg=magenta
let g:yankround_region_hl_groupname = 'YankRoundRegion'
"}}}
" memolist.vim {{{
let g:memolist_path = '$HOME/.vim/memolist.vim'
nnoremap [memolist] <Nop>
nmap <Leader>m [memolist]
nnoremap [memolist]n :MemoNew<CR>
nnoremap [memolist]l :MemoList<CR>
nnoremap [memolist]g :MemoGrep<CR>
"}}}
" vim-quickrun {{{
nnoremap <Leader>r :QuickRun<CR>
let g:quickrun_config = {
\    '_' : {
\        'hook/close_buffer/enable_failure':    1,
\        'hook/close_buffer/enable_empty_data': 1,
\        'runner':                              'vimproc',
\        'runner/vimproc/updatetime':           60,
\        'outputter':                           'multi:buffer:quickfix',
\        'outputter/buffer/split':              ':botright',
\        'outputter/buffer/close_on_empty':     1,},
\    'watchdogs_checker/_' : {
\        'hook/close_quickfix/enable_exit':           1,
\        'hook/back_window/enable_exit':              0,
\        'hook/back_window/priority_exit':            1,
\        'hook/quickfix_status_enable/enable_exit':   1,
\        'hook/quickfix_status_enable/priority_exit': 2,
\        'hook/qfsigns_update/enable_exit':           1,
\        'hook/qfsigns_update/priority_exit':         3,
\        'hook/qfstatusline_update/enable_exit':      1,
\        'hook/qfstatusline_update/priority_exit':    4,},
\    'watchdogs_checker/php' : {
\        'command':     'php',
\        'exec':        '%c -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0 -l %o %s:p',
\        'errorformat': '%m\ in\ %f\ on\ line\ %l',},
\    'markdown' : {
\        'outputter' : 'browser',},}
"}}}
" SQLUtilities {{{
let g:sqlutil_align_comma = 1
nnoremap <Leader>sql :SQLUFormatter<CR>
"}}}
" html5.vim {{{
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1
"}}}
"" neosnippet.vim {{{
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"xmap <C-k> <Plug>(neosnippet_expand_target)
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"            \ '\<Plug>(neosnippet_expand_or_jump)'
"            \: pumvisible() ? '\<C-n>' : '\<TAB>'
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"            \ '\<Plug>(neosnippet_expand_or_jump)'
"            \: '\<TAB>'
"if has('conceal')
"    set conceallevel=2 concealcursor=i
"endif
"let g:neosnippet#disable_runtime_snippets = {
"\    '_' : 1,}
"let g:neosnippet#data_directory=$HOME.'/.vim/neosnippet.vim'
""let g:neosnippet#enable_snipmate_compatibility = 1
""let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/vim-snippets/snippets'
"let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/neosnippet-snippets/neosnippets'
"snoremap <ESC> <ESC>:NeoSnippetClearMarkers<CR>
""}}}
" ultisnips {{{
let g:UltiSnipsJumpForwardTrigger='<TAB>'
"let g:UltiSnipsJumpBackwardTrigger=''
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/bundle/vim-snippets/UltiSnips'
"}}}
"}}}
"
"
" NeoBundleLazy
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" unite.vim
" unite-webcolorname
" unite-colorscheme
" unite-help
" vim-editvar
" codic-vim
" unite-codic.vim
" unite-highlight
" unite-tag
" jazzradio.vim {{{
NeoBundleLazy 'Shougo/unite.vim', {
\    'autoload' : {
\        'commands' : ['Unite', 'UniteWithBufferDir', 'UniteWithCursorWord'],},}
NeoBundleLazy 'pasela/unite-webcolorname', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': 'webcolorname',},}
NeoBundleLazy 'ujihisa/unite-colorscheme', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': 'colorscheme',},}
NeoBundleLazy 'Shougo/unite-help', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': 'help',},}
NeoBundleLazy 'thinca/vim-editvar', {
\    'depends': ['thinca/vim-prettyprint', 'Shougo/unite.vim'],
\    'autoload': {
\        'unite_sources': 'variable',},}
NeoBundleLazy 'rhysd/unite-codic.vim', {
\    'depends': ['koron/codic-vim', 'Shougo/unite.vim'],
\    'autoload': {
\        'unite_sources': 'codic',},}
NeoBundleLazy 'osyo-manga/unite-highlight', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': 'highlight',},}
NeoBundleLazy 'tsukkee/unite-tag' , {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': 'tag',},}
NeoBundleLazy 'supermomonga/jazzradio.vim', {
\    'depends' : 'Shougo/unite.vim',
\    'autoload' : {
\        'unite_sources': 'jazzradio',
\        'commands' : [
\            'JazzradioUpdateChannels',
\            'JazzradioStop',
\            {
\                'name' : 'JazzradioPlay',
\                'complete' : 'customlist,jazzradio#channel_id_complete'},],
\        'function_prefix' : 'jazzradio',},}
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
" default plugins
nnoremap <silent> [unite]b    :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]bm   :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]f    :<C-u>Unite -default-action=tabopen file_rec/async:!<CR>
nnoremap <silent> [unite]map  :<C-u>Unite output:map\|map!\|lmap<CR>
nnoremap <silent> [unite]mru  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]msg  :<C-u>Unite output:message<CR>
nnoremap <silent> [unite]s    :<C-u>Unite output:scriptnames<CR>
" add plugins
nnoremap <silent> [unite]cs  :<C-u>Unite -auto-preview colorscheme<CR>
nnoremap <silent> [unite]dic :<C-u>Unite codic<CR>
nnoremap <silent> [unite]h   :<C-u>Unite help<CR>
nnoremap <silent> [unite]hl  :<C-u>Unite highlight<CR>
nnoremap <silent> [unite]j   :<C-u>Unite jazzradio<CR>
nnoremap <silent> [unite]rad :<C-u>Unite jazzradio<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tag<CR>
nnoremap <silent> [unite]v   :<C-u>Unite -auto-preview variable<CR>
nnoremap <silent> [unite]web :<C-u>Unite webcolorname<CR>
nnoremap <silent> [unite]y   :<C-u>Unite yankround<CR>
" jazzradio
nnoremap [jazzradio] <Nop>
nmap <Leader>j [jazzradio]
nnoremap [jazzradio]u :JazzradioUpdateChannels<CR>
nnoremap [jazzradio]p :JazzradioPlay<Space>CurrentJazz<CR>
nnoremap [jazzradio]o :JazzradioStop<CR>
nnoremap [jazzradio]l :<C-u>Unite jazzradio<CR>
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    let g:unite_data_directory=$HOME.'/.vim/unite.vim'
    let g:unite_enable_start_insert=1
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_max_candidates=200
endfunction
unlet s:hooks
let s:hooks = neobundle#get_hooks('unite-tag')
function! s:hooks.on_source(bundle)
    let g:unite_source_tag_max_name_length=30
    let g:unite_source_tag_max_fname_length=128
    let g:unite_source_tag_show_location=0
endfunction
unlet s:hooks
let s:hooks = neobundle#get_hooks('jazzradio.vim')
function! s:hooks.on_source(bundle)
    let g:jazzradio#cache_dir=$HOME.'/.vim/jazzradio.vim'
endfunction
unlet s:hooks
"}}}
" vimdoc-ja {{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {
\    'autoload' : {
\        'commands' : 'help',},}
"helptags $HOME/.vim/bundle/vimdoc-ja/doc/
"}}}
" open-browser.vim {{{
NeoBundleLazy 'tyru/open-browser.vim', {
\    'autoload' : {
\        'functions' : 'OpenBrowser',
\        'commands'  : ['OpenBrowser', 'OpenBrowserSearch'],
\        'mappings'  : '<Plug>(openbrowser-smart-search)',},}
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap <Leader>gx <Plug>(openbrowser-smart-search)
vmap <Leader>gx <Plug>(openbrowser-smart-search)
"}}}
" taglist.vim {{{
NeoBundleLazy 'vim-scripts/taglist.vim', {
\    'autoload' : {
\        'commands' : 'Tlist',},}
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>t :Tlist<CR>
"}}}
" nerdtree {{{
NeoBundleLazy 'scrooloose/nerdtree', {
\    'autoload' : {
\        'commands' : 'NERDTree',},}
nnoremap <Leader>n :NERDTree<CR>
let g:NERDTreeMinimalUI         = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden        = 1
"}}}
" vimshell.vim {{{
NeoBundleLazy 'Shougo/vimshell.vim', {
\    'depends' : 'Shougo/vimproc.vim',
\    'autoload' : {
\        'commands' : ['VimShell', 'VimShellPop', 'VimShellInteractive'],},}
nnoremap [vimshell.vim] <Nop>
nmap <Leader>sh [vimshell.vim]
nnoremap <silent> [vimshell.vim]s :<C-u>VimShell<CR>
nnoremap <silent> [vimshell.vim]p :<C-u>VimShellPop<CR>
nnoremap <silent> [vimshell.vim]i :<C-u>VimShellInteractive
let s:hooks = neobundle#get_hooks('vimshell.vim')
function! s:hooks.on_source(bundle)
    let g:vimshell_data_directory = $HOME.'/.vim/vimshell.vim/cache'
    let g:vimshell_vimshrc_path   = $HOME.'/.vim/vimshell.vim/vimshrc/.vimshrc'
endfunction
unlet s:hooks
"}}}
" vim-easy-align {{{
NeoBundleLazy 'junegunn/vim-easy-align', {
\    'autoload': {
\        'commands' : 'EasyAlign',},}
vnoremap <silent> <Leader>a :EasyAlign<CR>
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters = {
\    '>': {
\        'pattern': '>>\|=>\|>', },
\    '/': {
\        'pattern':       '//\+\|/\*\|\*/',
\        'ignore_groups': ['String'], },
\    '#': {
\        'pattern':         '#\+',
\        'ignore_groups':   ['String'],
\        'delimiter_align': 'l', },
\    '$': {
\        'pattern':         '\((.*\)\@!$\(.*)\)\@!',
\        'ignore_groups':   ['String'],
\        'right_margin':  0,
\        'delimiter_align': 'l', },
\    ']': {
\        'pattern':       '[[\]]',
\        'left_margin':   0,
\        'right_margin':  0,
\        'stick_to_left': 0, },
\    ')': {
\        'pattern':       '[()]',
\        'left_margin':   0,
\        'right_margin':  0,
\        'stick_to_left': 0, },
\    'r': {
\        'pattern':      'return\|continue\|break',
\        'left_margin':  1 },
\    'd': {
\        'pattern':      ' \(\S\+\s*[;=]\)\@=',
\        'left_margin':  0,
\        'right_margin': 0, }, }
"}}}
" wildfire.vim {{{
NeoBundleLazy 'gcmt/wildfire.vim', {
\    'autoload' : {
\        'mappings'  : '<Plug>(wildfire-fuel)',},}
map <ENTER> <Plug>(wildfire-fuel)
let s:hooks = neobundle#get_hooks('wildfire.vim')
function! s:hooks.on_source(bundle)
    map <BS> <Plug>(wildfire-water)
    let g:wildfire_objects = {
    \        '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it',],
    \        'html,xml' : ['at', 'it',],}
endfunction
unlet s:hooks
"}}}
" neocomplete.vim {{{
"NeoBundleLazy 'Shougo/neocomplete.vim', {
"\    'depends': ['KazuakiM/neosnippet-snippets', 'Shougo/neosnippet.vim', 'Shougo/context_filetype.vim'],
"\    'autoload' : {
"\        'insert' : 1,},}
NeoBundleLazy 'Shougo/neocomplete.vim', {
\    'depends': ['KazuakiM/vim-snippets', 'SirVer/ultisnips', 'Shougo/context_filetype.vim'],
\    'autoload' : {
\        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup                  = 0
    let g:neocomplete#data_directory           = $HOME.'/.vim/neocomplete.vim'
    let g:neocomplete#enable_at_startup        = 1
    let g:neocomplete#enable_smart_case        = 1
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplete#same_filetypes           = {
    \   'html': 'html,css,javascript,php',}
    let g:neocomplete#sources = {
    \   '_':    ['file', 'ultisnips', 'buffer', 'member', 'dictionary',],
    \   'vim':  ['file', 'ultisnips', 'buffer', 'member', 'dictionary', 'syntax', 'vim'],
    \   'html': ['file', 'ultisnips', 'buffer', 'member', 'dictionary', 'syntax',],}
    let g:neocomplete#sources#dictionary#dictionaries = {
    \   'default':  '',
    \   'php':      $HOME.'/.vim/dict/php.dict',}
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    inoremap <expr><C-c> pumvisible() ? "\<C-n>" : "\<C-c>"
    " tags using.
    "let g:neocomplete#sources = {
    "\   '_':    ['file', 'ultisnips', 'buffer', 'dictionary', 'tag',],
    "\   'html': ['file', 'ultisnips', 'buffer', 'dictionary', 'tag', 'syntax',],}
    "let g:neocomplete#sources#tags#cache_limit_size     = 10000000
endfunction
unlet s:hooks
"}}}
" gundo.vim {{{
NeoBundleLazy 'sjl/gundo.vim', {
\    'autoload' : {
\        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('gundo.vim')
function! s:hooks.on_source(bundle)
    nnoremap u g-
    nnoremap <C-r> g+
    nnoremap <Leader>gundo :GundoToggle<CR>
endfunction
unlet s:hooks
"}}}
" sudo.vim {{{
"# command memo
"* ':w sudo:%'          :sudo save
"* ':w sudo:<filename>' :sudo another name save
"* ':e sudo:%'          :sudo open
NeoBundleLazy 'vim-scripts/sudo.vim', {
\    'autoload' : {
\        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('sudo.vim')
function! s:hooks.on_source(bundle)
    nnoremap [sudo] <Nop>
    nmap <Leader>su [sudo]
    nnoremap <silent> [sudo]w :w<Space>sudo:%<CR>
    nnoremap <silent> [sudo]a :w<Space>sudo:
    nnoremap <silent> [sudo]r :e<Space>sudo:%<CR>
endfunction
unlet s:hooks
"}}}
" vim-php-cs-fixer {{{
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {
\    'autoload' : {
\        'filetypes': 'php',},}
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle)
    " If php-cs-fixer is in $PATH, you don't need to define 'let g:php_cs_fixer_path=/path/to/file'.
    " And this setting is moved at OS type category.
    let g:php_cs_fixer_level='all'              " which level ?
    let g:php_cs_fixer_config='default'         " configuration
    let g:php_cs_fixer_php_path='php'           " Path to PHP
    " If you want to define specific fixers:
    "let g:php_cs_fixer_fixers_list = 'linefeed,short_tag,indentation'
    let g:php_cs_fixer_enable_default_mapping=1 " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run=0                " Call command with dry-run option
    let g:php_cs_fixer_verbose=0                " Return the output of command if 1, else an inline information.
    nnoremap <Leader>php :call PhpCsFixerFixFile()<CR>
endfunction
unlet s:hooks
"}}}
" shabadou.vim
" vim-qfsigns
" vim-qfstatusline
" quickfixstatus
" vim-watchdogs {{{
NeoBundleLazy 'osyo-manga/vim-watchdogs', {
\    'depends': ['thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'KazuakiM/vim-qfsigns', 'KazuakiM/vim-qfstatusline', 'dannyob/quickfixstatus'],
\    'autoload' : {
\        'filetypes': ['php', 'javascript', 'ruby'],},}
let s:hooks = neobundle#get_hooks('vim-watchdogs')
function! s:hooks.on_source(bundle)
    "vim-qfsigns
    nnoremap <Leader>sy :QfsignsJunmp<CR>
    "let g:qfsigns#AutoJump = 2
    "vim-qfstatusline
    let g:Qfstatusline#UpdateCmd = function('lightline#update')
    "vim-watchdogs
    let g:watchdogs_check_BufWritePost_enable = 0
    let g:watchdogs_check_BufWritePost_enables = {
    \   'php' : 1,
    \   'javascript': 1,
    \   'ruby' : 1,}
    let g:watchdogs_check_CursorHold_enable = 1
    "let g:watchdogs_check_CursorHold_enables = {
    "\   'php' : 1,
    "\   'javascript': 1,
    "\   'ruby' : 1,}
endfunction
unlet s:hooks
"}}}
" emmet-vim {{{
"# command memo
"* URL: http://docs.emmet.io/cheat-sheet/
"* <C+y>,  :execute trigger key
"* html:5 <=入力後に<C+y>,
"* div>ul>li.class#id_$$*5 <=入力後に<C+y>,
NeoBundleLazy 'mattn/emmet-vim', {
\    'autoload' : {
\        'filetypes': ['html', 'php', 'css', 'sass', 'scss', 'less'],},}
let s:hooks = neobundle#get_hooks('emmet-vim')
function! s:hooks.on_source(bundle)
    let g:user_emmet_settings = {
    \    'lang' : 'ja',
    \    'indentation' : '    ',
    \    'html' : { 'filters' : 'html',},
    \    'css'  : { 'filters' : 'fc',},
    \    'php'  : {
    \        'filters' : 'html',
    \        'extends' : 'html',},}
    let g:user_emmet_mode='a'
    let g:use_emmet_complete_tag = 1
    "let g:user_emmet_leader_key=''
endfunction
unlet s:hooks
"}}}
" vim-css3-syntax {{{
NeoBundleLazy 'hail2u/vim-css3-syntax', {
\    'autoload' : {
\        'filetypes': ['html', 'php', 'css', 'sass', 'scss', 'less'],},}
"}}}
" vim-javascript {{{
NeoBundleLazy 'pangloss/vim-javascript', {
\    'autoload' : {
\        'filetypes': ['html', 'php', 'javascript'],},}
"}}}
" sass-compile.vim {{{
NeoBundleLazy 'AtsushiM/sass-compile.vim', {
\    'autoload' : {
\        'filetypes': ['sass', 'scss']},}
let s:hooks = neobundle#get_hooks('sass-compile.vim')
function! s:hooks.on_source(bundle)
    let g:sass_compile_cdloop = 5
    let g:sass_compile_auto = 1
    let g:sass_compile_file = ['sass', 'scss']
    let g:sass_compile_cssdir = ['css', 'stylesheet']
    autocmd MyAutoCmd BufWritePost *.sass,*.scss SassCompile
endfunction
unlet s:hooks
"}}}
" vim-coffee-script {{{
NeoBundleLazy 'kchmck/vim-coffee-script', {
\    'autoload' : {
\        'filetypes': 'coffee',},}
let s:hooks = neobundle#get_hooks('vim-coffee-script')
function! s:hooks.on_source(bundle)
    autocmd MyAutoCmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
endfunction
unlet s:hooks
"}}}
" vim-markdown {{{
NeoBundleLazy 'plasticboy/vim-markdown', {
\    'autoload' : {
\        'filetypes': 'markdown',},}
"}}}
" previm {{{
NeoBundleLazy 'kannokanno/previm', {
\    'depends': 'open-browser.vim',
\    'autoload' : {
\        'filetypes': 'markdown',},}
"let g:previm_open_cmd = 'open -a Firefox'
nnoremap <silent> <Leader>pre :PrevimOpen<CR>
"}}}
"}}}
"
"
" NeoBundleFetch
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
"# function memo
"* New Install 'NeoBundle'. And Update 'NeoBundle' to 'NeoBundleFetch'.
" ColorScheme {{{
NeoBundleFetch 'nanotech/jellybeans.vim'
NeoBundleFetch 'altercation/vim-colors-solarized'
NeoBundleFetch 'tomasr/molokai'
"}}}
" Lingr (none-Vimplugin but there is vim-users.jp room.) {{{
NeoBundleFetch 'psychs/lingr-irc'
"}}}
" neosnippet-snippets {{{
NeoBundleFetch 'KazuakiM/neosnippet-snippets'
"}}}
" PHP {{{
"* URL: https://github.com/ziadoz/awesome-php
NeoBundleFetch 'ziadoz/awesome-php'
nnoremap <Leader>awe :tabnew $HOME/.vim/bundle/awesome-php/README.md<CR>
"}}}
"}}}
"
"
" OS type
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if has('mac')
    " Programming language
    let $PYTHON_DLL  = '/usr/local/Cellar/python/2.7.7_2/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib'
    "let $PYTHON3_DLL = '/usr/local/Cellar/python3/3.4.1/Frameworks/Python.framework/Versions/3.4/lib/libpython3.4.dylib'
    let $PERL_DLL    = '/usr/local/Cellar/perl518/5.18.2/lib/5.18.2/darwin-thread-multi-2level/CORE/libperl.dylib'
    let $RUBY_DLL    = '/usr/local/lib/libruby.dylib'
    let $LUA_DLL     = '/usr/local/lib/liblua.dylib'
else
    " US keyboard
    nnoremap : ;
    " php setting.
    let g:php_cs_fixer_path = '$HOME/.vim/vim-php-cs-fixer/php-cs-fixer' " define the path to the php-cs-fixer.phar
endif
"}}}
"
"
" NeoBundle END
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
call neobundle#end()
"}}}
"
"
" FileType
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
filetype plugin indent on
autocmd MyAutoCmd BufNewFile,BufRead *.{md,mkd,mdwn,mkdn,mark*} setlocal filetype=markdown
autocmd MyAutoCmd BufNewFile,BufRead *.coffee                   setlocal filetype=coffee
autocmd MyAutoCmd BufNewFile,BufRead *.{snip*}                  setlocal filetype=snippets
"}}}
"
"
" Extra local functions
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" quickrun - prettyprint {{{
"# function memo
"* URL: http://qiita.com/rbtnn/items/39d9ba817329886e626b
"* NoFormattings :echo neobundle#config#get_neobundles()
"* Formattings   :QuickRunPP neobundle#config#get_neobundles()
"* Formatting    :QuickRunPP neobundle#get_hooks('vim-markdown')
function! s:quickrun_pp(q_args)
    let dict = { 'type' : 'vim', 'runner' : 'vimscript', 'outputter' : 'buffer',
                \   'outputter/buffer/filetype' : 'vim', 'hook/eval/enable' : 1,
                \   'hook/eval/template' : 'echo PP(%s)', 'src' : a:q_args,}
    call quickrun#run(dict)
endfunction
command! -nargs=1 -complete=expression QuickRunPP :call <sid>quickrun_pp(<q-args>)
"}}}
" Auto DirectoryMake {{{
function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \   input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
"}}}
"}}}
"
"
" Other setting files
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" Environment setting file
source ~/.vimrc.local
"}}}

