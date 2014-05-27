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
set nocompatible
" Valiable
"let g:localtime=localtime()
""let g:time=strftime('%Y%m%d%H%M%S',g:localtime)
"let g:date_hour=strftime('%Y%m%d%H',g:localtime)
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
inoremap jj <Esc>
inoremap kk <Esc>
nnoremap 0 $
nnoremap 1 ^
nnoremap gr gT
" Color
syntax on
set t_Co=256
" Check space and newLineCode.
autocmd MyAutoCmd ColorScheme * highlight TabString     cterm=reverse ctermfg=darkgray
autocmd MyAutoCmd VimEnter,WinEnter * let w:m1 = matchadd('TabString',     "\t")
autocmd MyAutoCmd ColorScheme * highlight CrString      cterm=reverse ctermfg=darkred
autocmd MyAutoCmd VimEnter,WinEnter * let w:m2 = matchadd('CrString',      "\r")
autocmd MyAutoCmd ColorScheme * highlight CrlfString    cterm=reverse ctermfg=darkmagenta
autocmd MyAutoCmd VimEnter,WinEnter * let w:m3 = matchadd('CrlfString',    "\r\n")
autocmd MyAutoCmd ColorScheme * highlight WhitespaceEOL cterm=reverse ctermfg=lightmagenta
autocmd MyAutoCmd VimEnter,WinEnter * let w:m4 = matchadd('WhitespaceEOL', '\s\+$')
autocmd MyAutoCmd ColorScheme * highlight ZenkakuSpace  cterm=reverse ctermfg=lightred
autocmd MyAutoCmd VimEnter,WinEnter * let w:m5 = matchadd('ZenkakuSpace',  '　')
" Update Visual mode target colorScheme.
autocmd MyAutoCmd ColorScheme * highlight Visual cterm=reverse ctermfg=lightgreen
colorscheme jellybeans
" Show
set title
set ruler
set laststatus=2
set wildmenu
set wildmode=longest:full,full
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
"autocmd MyAutoCmd VimEnter * call s:auto_mkdir($HOME.'/.vim/gundo/'.g:date_hour.'/', 1)
"set undofile
"set undodir=eval("$HOME.'/.vim/gundo/'.g:date_hour.'/'")
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
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" PHP
" URL: http://stackoverflow.com/questions/9684806/real-sql-syntax-highlighting-in-php-scripts-with-vim
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
"}}}
"
"
" NeoBundle
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
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
\    'mode_map': { 'c': 'NORMAL' },
\    'active': {
\        'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
\        'right': [ [ 'lineinfo',  'syntastic' ],
\                   [ 'percent' ],
\                   [ 'fileformat', 'fileencoding', 'filetype' ] ],},
\    'component_expand': {
\        'syntastic': 'SyntasticStatuslineFlag',},
\    'component_type': {
\        'syntastic': 'error',},
\    'component_function': {
\        'modified': 'MyModified',
\        'readonly': 'MyReadonly',
\        'fugitive': 'MyFugitive',
\        'filename': 'MyFilename',
\        'fileformat': 'MyFileformat',
\        'filetype': 'MyFiletype',
\        'fileencoding': 'MyFileencoding',
\        'mode': 'MyMode',},
\    'separator': { 'left': '', 'right': '' },
\    'subseparator': { 'left': '|', 'right': '|' }}
let g:syntastic_mode_map = { 'mode': 'passive' }
autocmd MyAutoCmd BufWritePost * call s:syntastic()
function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction
function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            return fugitive#head()
        endif
    catch
    endtry
    return ''
endfunction
function! MyFileformat()
    return winwidth('.') > 70 ? &fileformat : ''
endfunction
function! MyFiletype()
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileencoding()
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyMode()
    return winwidth('.') > 60 ? lightline#mode() : ''
endfunction
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
"}}}
" indentLine {{{
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_faster = 1
"}}}
" ultisnips {{{
NeoBundle 'SirVer/ultisnips', {
\    'depends': 'KazuakiM/vim-snippets',}
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/bundle/vim-snippets/UltiSnips'
"}}}
" vim-precious
" context_filetype.vim {{{
"# plugin memo
"* Non supported PHP
"NeoBundle 'osyo-manga/vim-precious', {
"\    'depends': 'Shougo/context_filetype.vim'}
"let g:context_filetype#filetypes = {
"\    'php': [
"\        {
"\            'start': '<html>',
"\            'end': '</html>', 'filetype': 'html',},
"\        {
"\            'start': '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
"\            'end': '</script>', 'filetype': 'javascript',},
"\        {
"\            'start': '<style\%( [^>]*\)\? type="text/css"\%( [^>]*\)\?>',
"\            'end': '</style>', 'filetype': 'css',},
"\       {
"\            'start': '<?php\?',
"\            'end': '?>', 'filetype': 'php',}],}
"}}}
" syntastic {{{
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
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
let g:ref_cache_dir=$HOME.'/.vim/refCache'
let g:ref_phpmanual_path=$HOME.'/.vim/ref/php-chunked-xhtml'
let g:ref_detect_filetype={
\    'laravel.php':     'phpmanual',
\    'codeigniter.php': 'phpmanual',
\    'fuel.php':        'phpmanual',
\    'yii.php':         'phpmanual',}
autocmd MyAutoCmd FileType ref-phpmanual nmap <silent> <buffer> <ESC><ESC> :q<CR>
"}}}
" vim-tags {{{
"# command memo
"* :TagsGenerate :Remake tags.
"* <C-]>         :Jump target file
"* <C-o>         :Return before file
"* :ts           :Jump target file list
NeoBundle 'szw/vim-tags'
let g:vim_tags_auto_generate = 1
nnoremap <Leader>tags :TagsGenerate
nnoremap <Leader>] <C-]>
nnoremap <Leader>[ <C-o>
nnoremap <Leader>ts :ts<CR>
" add .vimrc.local
"}}}
" vim-surround {{{
"# command memo
"* cs"'   :Change From  " to '
"* cs'<p> :Change From  ' to <p>
"* ds'    :Delete '
NeoBundle 'tpope/vim-surround'
"}}}
" wildfire.vim {{{
"# command memo
"* (Normal)Enter after Enter :Range up selected words.
"* (Normal)Backspace         :Range down selected words.
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
" vim-qfreplace {{{
"# command memo
"* ,grep  :Cursor word grep
"* ,cn    :grep results next jump
"* ,cb    :grep results previous(before) jump
"* ,ccXX  :grep XX lines jump
NeoBundle 'thinca/vim-qfreplace'
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
set runtimepath+=$HOME/.vim/qfixapp/
let QFixWin_EnableMode = 1
let QFix_UseLocationList = 1
nnoremap <expr> <Leader>grep ':silent grep! '.expand('<cword>').' '.vital#of("vital").import("Prelude").path2project_directory("%").'<CR>'
nnoremap [vim-qfreplace] <Nop>
nmap <Leader>c [vim-qfreplace]
nnoremap [vim-qfreplace]n :cnext<CR>
nnoremap [vim-qfreplace]b :cprevious<CR>
nnoremap [vim-qfreplace]c :cc
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
autocmd MyAutoCmd FileType qf nmap <silent> <buffer> <ESC><ESC> :q<CR>
"}}}
" memolist.vim {{{
"# command memo
"* Don't NeoBundleLazy. ':MemoList' is non-function at first request.
NeoBundle 'glidenote/memolist.vim'
let g:memolist_path = '$HOME/.vim/memo'
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
\        'outputter/buffer/split' : ':botright',
\        'outputter/buffer/close_on_empty' : 1,},
\    'markdown' : {
\        'outputter' : 'browser',},}
"}}}
" vim-prettyprint {{{
NeoBundle 'thinca/vim-prettyprint'
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
" vim-editvar {{{
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
let g:unite_data_directory=$HOME.'/.vim/unite'
let g:unite_enable_start_insert=1
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_max_candidates=200
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
" default plugins
nnoremap <silent> [unite]b    :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]c    :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]f    :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]mru  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]map  :<C-u>Unite output:map\|map!\|lmap<CR>
nnoremap <silent> [unite]msg  :<C-u>Unite output:message<CR>
nnoremap <silent> [unite]nmap :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]rec  :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> [unite]reg  :<C-u>Unite register<CR>
nnoremap <silent> [unite]s    :<C-u>Unite output:scriptnames<CR>
nnoremap <silent> [unite]t    :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w    :<C-u>Unite window<CR>
" add plugins
nnoremap <silent> [unite]cs  :<C-u>Unite -auto-preview colorscheme<CR>
nnoremap <silent> [unite]h   :<C-u>Unite help<CR>
nnoremap <silent> [unite]ol  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]v   :<C-u>Unite -auto-preview variable<CR>
nnoremap <silent> [unite]web :<C-u>Unite webcolorname<CR>
autocmd MyAutoCmd FileType unite nmap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"}}}
" vimdoc-ja {{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {
\    'autoload' : {
\        'commands' : ['help'],},}
autocmd MyAutoCmd FileType help nmap <silent> <buffer> <ESC><ESC> :q<CR>
let s:hooks = neobundle#get_hooks('vimdoc-ja')
function! s:hooks.on_source(bundle)
    helptags $HOME/.vim/bundle/vimdoc-ja/doc/
endfunction
unlet s:hooks
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
"# command memo
"* :Tlist :Show class, function and etc at left menu.
NeoBundleLazy 'vim-scripts/taglist.vim', {
\    'autoload' : {
\        'commands' : ['Tlist'],},}
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>t :Tlist<CR>
autocmd MyAutoCmd FileType taglist nmap <silent> <buffer> <ESC><ESC> :q<CR>
"}}}
" nerdtree {{{
NeoBundleLazy 'scrooloose/nerdtree', {
\    'autoload' : {
\        'commands' : ['NERDTree'],},}
nnoremap <Leader>n :NERDTree<CR>
let NERDTreeShowHidden=1
autocmd MyAutoCmd FileType nerdtree nmap <silent> <buffer> <ESC><ESC> :q<CR>
"}}}
" vimshell.vim {{{
NeoBundleLazy 'Shougo/vimshell.vim', {
\    'depends' : 'Shougo/vimproc.vim',
\    'autoload' : {
\        'commands' : ['VimShell', 'VimShellPop', 'VimShellInteractive'],},}
let g:vimshell_data_directory=$HOME.'/.vim/vimshell'
nnoremap [vimshell.vim] <Nop>
nmap <Leader>sh [vimshell.vim]
nnoremap <silent> [vimshell.vim]s :<C-u>VimShell<CR>
nnoremap <silent> [vimshell.vim]p :<C-u>VimShellPop<CR>
nnoremap <silent> [vimshell.vim]i :<C-u>VimShellInteractive
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
    let g:neocomplete#data_directory=$HOME.'/.vim/neocomplete'
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
        let g:php_cs_fixer_path = '$HOME/.vim/phpCsFixer/php-cs-fixer' " define the path to the php-cs-fixer.phar
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
" emmet-vim {{{
"# command memo
"* URL: http://docs.emmet.io/cheat-sheet/
"* <C+y>,  :execute trigger key
"* html:5 <=入力後に<C+y>,
"* div>ul>li.class#id_$$*5 <=入力後に<C+y>,
NeoBundleLazy 'mattn/emmet-vim', {
\    'autoload' : {
\        'filetypes': ['html','php','css'],},}
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
" html5.vim {{{
NeoBundleLazy 'othree/html5.vim', {
\    'autoload' : {
\        'filetypes': ['html','php'],},}
"}}}
" vim-css3-syntax {{{
NeoBundleLazy 'hail2u/vim-css3-syntax', {
\    'autoload' : {
\        'filetypes': ['html','php','css'],},}
"}}}
" vim-javascript {{{
NeoBundleLazy 'pangloss/vim-javascript', {
\    'autoload' : {
\        'filetypes': ['html','php','javascript'],},}
"}}}
" sass-compile.vim {{{
NeoBundleLazy 'AtsushiM/sass-compile.vim', {
\    'autoload' : {
\        'filetypes': ['sass','scss']},}
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
autocmd MyAutoCmd BufNewFile,BufRead *.{md,mkd,mdwn,mkdn,mark*} set filetype=markdown
autocmd MyAutoCmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd MyAutoCmd BufNewFile,BufRead *.{snip*} set filetype=snippets
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
"* Formatting    :QuickRunPP neobundle#get('vim-markdown')
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
"function! s:auto_mkdir(dir, force)
"    if !isdirectory(a:dir) && (a:force ||
"                \   input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
"    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
"  endif
"endfunction
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

