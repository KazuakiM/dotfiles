"
"
" Memo
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
"  :help internal-variables {{{
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
"  :help map {{{
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
" Valiable
"let s:localtime=localtime()
"let s:time=strftime('%Y%m%d%H%M%S',s:localtime)
"let s:date_hour=strftime('%Y%m%d%H',s:localtime)
" Encode
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
" Basic
let mapleader=','
set scrolloff=5
set textwidth=0
set autoread
set hidden
set ambiwidth=double
"set spelllang+=cjk
"set spell
set backspace=indent,eol,start
set visualbell t_vb=
set noerrorbells
set foldmethod=marker
set viminfo+=n~/.vim/viminfo/.viminfo
nnoremap zx :<C-U>%foldopen<CR>
set matchpairs+=<:>
augroup MyAutoCmd
    autocmd!
augroup END
nnoremap 0 $
nnoremap 1 ^
nnoremap gr gT
nnoremap fa <C-w>+
nnoremap j; <C-w>-
nnoremap fd <C-w>>
nnoremap jk <C-d><
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
autocmd MyAutoCmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
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
" Programming language
if has('mac')
    let $PYTHON_DLL  = '/usr/local/Cellar/python/2.7.7_2/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib'
    "let $PYTHON3_DLL = '/usr/local/Cellar/python3/3.4.1/Frameworks/Python.framework/Versions/3.4/lib/libpython3.4.dylib'
    let $PERL_DLL    = '/usr/local/Cellar/perl518/5.18.2/lib/5.18.2/darwin-thread-multi-2level/CORE/libperl.dylib'
    let $RUBY_DLL    = '/usr/local/lib/libruby.dylib'
    let $LUA_DLL     = '/usr/local/lib/liblua.dylib'
endif
" Close sub window
autocmd MyAutoCmd FileType help          nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType ref-phpmanual nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType qf            nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType unite         nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType unite         imap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
autocmd MyAutoCmd FileType taglist       nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType nerdtree      nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd CmdwinEnter * nmap <silent> <ESC><ESC> :q<CR>
autocmd MyAutoCmd CmdwinEnter * imap <silent> <ESC><ESC> <ESC>:q<CR>
autocmd MyAutoCmd CmdwinLeave * nunmap <ESC><ESC>
autocmd MyAutoCmd CmdwinLeave * iunmap <ESC><ESC>
"}}}
"
"
" NeoBundle
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
call neobundle#begin(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc {{{
NeoBundle 'Shougo/vimproc', {
\    'build' : {
\        'windows' : 'make -f make_mingw32.mak',
\        'cygwin'  : 'make -f make_cygwin.mak',
\        'mac'     : 'make -f make_mac.mak',
\        'unix'    : 'make -f make_unix.mak',},}
"}}}
" vital.vim {{{
NeoBundle 'vim-jp/vital.vim'
"}}}
" webapi-vim {{{
NeoBundle 'mattn/webapi-vim'
"}}}
" vim-fugitive {{{
NeoBundle 'tpope/vim-fugitive'
nnoremap [vim-fugitive] <Nop>
nmap <Leader>git [vim-fugitive]
nnoremap [vim-fugitive]status :Gstatus<CR>
nnoremap [vim-fugitive]log :Glog<CR>
nnoremap [vim-fugitive]add :Gwrite<CR>
nnoremap [vim-fugitive]rm :Gremove<CR>
nnoremap [vim-fugitive]diff :Gdiff<CR>
nnoremap [vim-fugitive]commit :Gcommit -m ''
"}}}
" lightline
" landscape {{{
NeoBundle 'itchyny/lightline.vim', {
\    'depends': ['itchyny/landscape.vim', 'tpope/vim-fugitive',],}
let g:lightline = {
\    'colorscheme': 'landscape',
\    'active': {
\        'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
\        'right': [ [ 'qfstatusline', 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ],},
\    'component_function': {
\        'fugitive': 'MyFugitive',
\        'filename': 'MyFilename',
\        'fileformat': 'MyFileformat',
\        'filetype': 'MyFiletype',
\        'fileencoding': 'MyFileencoding',
\        'mode': 'MyMode',
\        'ctrlpmark': 'CtrlPMark',},
\    'component_expand': {
\        'qfstatusline': 'qfstatusline#Update',},
\    'component_type': {
\        'qfstatusline': 'error',},
\    'subseparator': {
\        'left': '|',
\        'right': '|',},}
function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
    return &ft !~? 'help' && &readonly ? 'x' : ''
endfunction
function! MyFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
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
    return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
            \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction
let g:ctrlp_status_func = {
\    'main': 'CtrlPStatusFunc_1',
\    'prog': 'CtrlPStatusFunc_2',}
function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction
function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
"}}}
" indentLine {{{
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_faster = 1
"}}}
" ultisnips {{{
NeoBundle 'SirVer/ultisnips', {
\    'depends': 'KazuakiM/vim-snippets',}
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/bundle/vim-snippets/UltiSnips'
"}}}
" vim-precious
" context_filetype.vim {{{
NeoBundle 'osyo-manga/vim-precious', {
\    'depends': 'Shougo/context_filetype.vim'}
" HTML default_filetype + PHP
let g:context_filetype#filetypes = {
\    'php': [
\        {
\            'start': '<html>',
\            'end':   '</html>', 'filetype': 'html',},
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
\           'start': '<style\%( [^>]*\)\? type="text/css"\%( [^>]*\)\?>',
\           'end':   '</style>', 'filetype': 'css',},],}
let g:precious_enable_switch_CursorMoved = {
\    '*' : 0,}
let g:precious_enable_switch_CursorMoved_i = {
\    '*' : 0,}
autocmd MyAutoCmd InsertEnter * :PreciousSwitch
autocmd MyAutoCmd InsertLeave * :PreciousReset
"}}}
" vdebug {{{
"# command memo
"* <F5>  : start/run (to next breakpoint/end of script)
"* <F2>  : step over
"* <F3>  : step into
"* <F4>  : step out
"* <F6>  : stop debugging
"* <F7>  : detach script from debugger
"* <F9>  : run to cursor
"* <F10> : set line breakpoint
"* <F11> : show context variables (e.g. after 'eval')
"* <F12> : evaluate variable under cursor
"* :Breakpoint <type> <args>: set a breakpoint of any type (see :help VdebugBreakpoints)
"* :VdebugEval <code>: evaluate some code and display the result
"* <Leader>e: evaluate the expression under visual highlight and display the result
NeoBundle 'joonty/vdebug'
"}}}
" vim-ref {{{
NeoBundle 'thinca/vim-ref'
let g:ref_cache_dir=$HOME.'/.vim/vim-ref/cache'
let g:ref_phpmanual_path=$HOME.'/.vim/vim-ref/php-chunked-xhtml'
" Don't use multi file type.
"let g:ref_detect_filetype={
"\    'laravel.php':     'phpmanual',
"\    'yii.php':         'phpmanual',}
"}}}
" vim-tags {{{
NeoBundle 'szw/vim-tags'
let g:vim_tags_auto_generate = 1
nnoremap <Leader>tags :TagsGenerate
nnoremap <Leader>] <C-]>
nnoremap <Leader>[ <C-o>
nnoremap <Leader>ts :ts<CR>
" add .vimrc.local
"}}}
" vim-surround {{{
NeoBundle 'tpope/vim-surround'
"}}}
" wildfire.vim {{{
NeoBundle 'gcmt/wildfire.vim'
let g:wildfire_water_map = '<BS>'
let g:wildfire_objects = {
\        '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
\        'html,xml' : ['at'],}
"}}}
" matchit.zip {{{
NeoBundle 'vim-scripts/matchit.zip'
"}}}
" vim-endwise {{{
NeoBundle 'tpope/vim-endwise'
"}}}
" vim-qfreplace
" fuenor/qfixgrep {{{
"# command memo
"* ,cn    :grep results next jump
"* ,cb    :grep results previous(before) jump
"* ,ccXX  :grep XX lines jump
NeoBundle 'thinca/vim-qfreplace', {
\    'depends': 'fuenor/qfixgrep',}
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
let QFixWin_EnableMode = 1
let QFix_UseLocationList = 1
nnoremap <expr> <Leader>grep ':silent grep! '.expand('<cword>').' '.vital#of("vital").import("Prelude").path2project_directory("%").'<CR>'
nnoremap [vim-qfreplace] <Nop>
nmap <Leader>c [vim-qfreplace]
nnoremap [vim-qfreplace]n :cnext<CR>
nnoremap [vim-qfreplace]b :cprevious<CR>
nnoremap [vim-qfreplace]c :cc
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
"}}}
" yankround.vim {{{
NeoBundle 'LeafCage/yankround.vim'
let g:yankround_dir=$HOME.'/.vim/yankround.vim'
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_use_region_hl = 1
highlight YankRoundRegion cterm=underline ctermfg=magenta
let g:yankround_region_hl_groupname = 'YankRoundRegion'
"}}}
" memolist.vim {{{
"# command memo
"* Don't NeoBundleLazy. ':MemoList' is non-function at first request.
NeoBundle 'glidenote/memolist.vim'
let g:memolist_path = '$HOME/.vim/memolist.vim'
nnoremap [memolist] <Nop>
nmap <Leader>m [memolist]
nnoremap [memolist]n :MemoNew<CR>
nnoremap [memolist]l :MemoList<CR>
nnoremap [memolist]g :MemoGrep<CR>
"}}}
" vim-quickrun {{{
"# command memo
"* :QuickRun :execute quickrun.
NeoBundle 'thinca/vim-quickrun'
nnoremap <Leader>r :QuickRun<CR>
let g:quickrun_config = {
\    '_' : {
\        'hook/close_buffer/enable_failure':    1,
\        'hook/close_buffer/enable_empty_data': 1,
\        'runner':                              'vimproc',
\        'runner/vimproc/updatetime':           40,
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
" vim-prettyprint {{{
NeoBundle 'thinca/vim-prettyprint'
"}}}
" vim-over {{{
NeoBundle 'osyo-manga/vim-over'
nnoremap <expr><Leader>%s ':OverCommandLine<CR>%s/'.expand('<cword>').'/'
"}}}
" html5.vim {{{
NeoBundle 'othree/html5.vim'
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1
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
" jazzradio.vim {{{
NeoBundleLazy 'Shougo/unite.vim', {
\    'autoload' : {
\        'commands' : ['Unite', 'UniteWithBufferDir', 'UniteWithCursorWord'],},}
NeoBundleLazy 'pasela/unite-webcolorname', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': ['webcolorname'],},}
NeoBundleLazy 'ujihisa/unite-colorscheme', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': ['colorscheme'],},}
NeoBundleLazy 'Shougo/unite-help', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': ['help'],},}
NeoBundleLazy 'Shougo/unite-outline', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': ['outline'],},}
NeoBundleLazy 'thinca/vim-editvar', {
\    'depends': ['thinca/vim-prettyprint', 'Shougo/unite.vim'],
\    'autoload': {
\        'unite_sources': ['variable'],},}
NeoBundleLazy 'rhysd/unite-codic.vim', {
\    'depends': ['koron/codic-vim', 'Shougo/unite.vim'],
\    'autoload': {
\        'unite_sources': ['codic'],},}
NeoBundleLazy 'osyo-manga/unite-highlight', {
\    'depends': 'Shougo/unite.vim',
\    'autoload': {
\        'unite_sources': ['highlight'],},}
NeoBundleLazy 'supermomonga/jazzradio.vim', {
\    'depends' : 'Shougo/unite.vim',
\    'autoload' : {
\        'unite_sources': ['jazzradio'],
\        'commands' : [
\            'JazzradioUpdateChannels',
\            'JazzradioStop',
\            {
\                'name' : 'JazzradioPlay',
\                'complete' : 'customlist,jazzradio#channel_id_complete'},],
\        'function_prefix' : 'jazzradio',},}
let g:unite_data_directory=$HOME.'/.vim/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_max_candidates=200
let g:jazzradio#cache_dir=$HOME.'/.vim/jazzradio.vim'
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
" default plugins
nnoremap <silent> [unite]b    :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]bm   :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]f    :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]map  :<C-u>Unite output:map\|map!\|lmap<CR>
nnoremap <silent> [unite]mru  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]msg  :<C-u>Unite output:message<CR>
nnoremap <silent> [unite]nmap :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]rec  :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> [unite]reg  :<C-u>Unite register<CR>
nnoremap <silent> [unite]s    :<C-u>Unite output:scriptnames<CR>
nnoremap <silent> [unite]t    :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w    :<C-u>Unite window<CR>
" add plugins
nnoremap <silent> [unite]cs  :<C-u>Unite -auto-preview colorscheme<CR>
nnoremap <silent> [unite]dic :<C-u>Unite codic<CR>
nnoremap <silent> [unite]h   :<C-u>Unite help<CR>
nnoremap <silent> [unite]hl  :<C-u>Unite highlight<CR>
nnoremap <silent> [unite]j   :<C-u>Unite jazzradio<CR>
nnoremap <silent> [unite]ol  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]rad :<C-u>Unite jazzradio<CR>
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
"}}}
" vimdoc-ja {{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {
\    'autoload' : {
\        'commands' : ['help'],},}
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
\        'commands' : ['Tlist'],},}
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>t :Tlist<CR>
"}}}
" nerdtree {{{
NeoBundleLazy 'scrooloose/nerdtree', {
\    'autoload' : {
\        'commands' : ['NERDTree'],},}
nnoremap <Leader>n :NERDTree<CR>
let NERDTreeShowHidden=1
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
"# command memo
"* Don't hooks. 'g:easy_align_delimiters' is non-function.
NeoBundleLazy 'junegunn/vim-easy-align', {
\    'autoload': {
\        'commands' : ['EasyAlign'],},}
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
" emoji-vim {{{
NeoBundleLazy 'mattn/emoji-vim', {
\    'autoload' : {
\        'commands' : ['Emoji'],},}
"}}}
" neocomplete.vim {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {
\    'depends': ['SirVer/ultisnips', 'Shougo/context_filetype.vim'],
\    'autoload' : {
\        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup=0
    let g:neocomplete#data_directory=$HOME.'/.vim/neocomplete.vim'
    let g:neocomplete#enable_at_startup=1
    let g:neocomplete#enable_smart_case=1
    let g:neocomplete#sources#syntax#min_keyword_length=3
    let g:neocomplete#lock_buffer_name_pattern='\*ku\*'
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
    " If php-cs-fixer is in $PATH, you don't need to define line below
    if has('mac')
    else
        let g:php_cs_fixer_path = '$HOME/.vim/vim-php-cs-fixer/php-cs-fixer' " define the path to the php-cs-fixer.phar
    endif
    let g:php_cs_fixer_level='all'              " which level ?
    let g:php_cs_fixer_config='default'         " configuration
    let g:php_cs_fixer_php_path='php'           " Path to PHP
    " If you want to define specific fixers:
    "let g:php_cs_fixer_fixers_list = 'linefeed,short_tag,indentation'
    let g:php_cs_fixer_enable_default_mapping=1 " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run=0                " Call command with dry-run option
    let g:php_cs_fixer_verbose=0                " Return the output of command if 1, else an inline information.
    nnoremap <silent><Leader>php :call PhpCsFixerFixFile()<CR>
endfunction
unlet s:hooks
" add .vimrc.local
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
if has('mac')
    NeoBundleLazy 'kannokanno/previm', {
    \    'depends': ['open-browser.vim'],
    \    'autoload' : {
    \        'filetypes': 'markdown',},}
    "let g:previm_open_cmd = 'open -a Firefox'
    nnoremap <silent> <Leader>pre :PrevimOpen<CR>
endif
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
" Extra local setting
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if filereadable(expand($HOME.'/.vimrc.local'))
    source ~/.vimrc.local
endif
"}}}

