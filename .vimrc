"
"
" Memo
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
"   :help internal-variables
"{{{
"------------------------------------------------------------------------
"| b: | buffer-variable   | Local to the current buffer.                |
"| w: | window-variable   | Local to the current window.                |
"| t: | tabpage-variable  | Local to the current tab page.              |
"| g: | global-variable   | Global.                                     |
"| l: | local-variable    | Local to a function.                        |
"| s: | script-variable   | Local to a :source'ed Vim script.           |
"| a: | function-argument | Function argument (only inside a function). |
"| v: | vim-variable      | Global, predefined by Vim.                  |
"------------------------------------------------------------------------
"}}}
"   :help map
"{{{
"----------------------------------------------------------------------------------------------------------------------------------
" |commands:                                     |modes:                                                                          |
" | Variables | Constants |  Unset  |  Destroy   | Normal | Visual | Select | Operator-pending | Insert | Command-line | Lang-Arg |
" |   :map    | :noremap  | :unmap  | :mapclear  |  yes   |  yes   |  yes   |       yes        |   -    |      -       |    -     |
" |   :nmap   | :nnoremap | :nunmap | :nmapclear |  yes   |   -    |   -    |        -         |   -    |      -       |    -     |
" |   :vmap   | :vnoremap | :vunmap | :vmapclear |   -    |  yes   |  yes   |        -         |   -    |      -       |    -     |
" |   :omap   | :onoremap | :ounmap | :omapclear |   -    |   -    |   -    |       yes        |   -    |      -       |    -     |
" |   :xmap   | :xnoremap | :xunmap | :xmapclear |   -    |  yes   |   -    |        -         |   -    |      -       |    -     |
" |   :smap   | :snoremap | :sunmap | :smapclear |   -    |   -    |  yes   |        -         |   -    |      -       |    -     |
" |   :map!   | :noremap! | :unmap! | :mapclear! |   -    |   -    |   -    |        -         |  yes   |     yes      |    -     |
" |   :imap   | :inoremap | :iunmap | :imapclear |   -    |   -    |   -    |        -         |  yes   |      -       |    -     |
" |   :cmap   | :cnoremap | :cunmap | :cmapclear |   -    |   -    |   -    |        -         |   -    |     yes      |    -     |
" |   :lmap   | :lnoremap | :lunmap | :lmapclear |   -    |   -    |   -    |        -         |  yes*  |     yes*     |   yes*   |
"----------------------------------------------------------------------------------------------------------------------------------
"}}}
"   color
"{{{
" confirm the definition of color
"   :so $VIMRUNTIME/syntax/colortest.vim
" check the status of the current Vim
"   :so $VIMRUNTIME/syntax/hitest.vim
"}}}
"}}}
"
"
" Common
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
set nocompatible
" Valiable
"let b:localtime=localtime()
"let b:now=strftime('%Y%m%d%H%M%S',b:localtime)
" Encode
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
" Basic
let mapleader=','
set scrolloff=5
set textwidth=0
set autoread
set hidden
set backspace=indent,eol,start
set vb t_vb= "
set foldmethod=marker
"set line head left arrow
"nnoremap  :<C-U>%foldclose<CR>
set matchpairs+=<:>
augroup MyAutoCmd
    autocmd!
augroup END
inoremap jj <Esc>
inoremap kk <Esc>
nnoremap 0 $
nnoremap 1 ^
" Color
syntax on
set t_Co=256
" Check space and newLineCode.
autocmd MyAutoCmd ColorScheme * highlight TabString     cterm=reverse ctermfg=darkgray
autocmd MyAutoCmd VimEnter,WinEnter * let w:m1 = matchadd('TabString',     '\t')
autocmd MyAutoCmd ColorScheme * highlight CrString      cterm=reverse ctermfg=darkred
autocmd MyAutoCmd VimEnter,WinEnter * let w:m2 = matchadd('CrString',      '\r')
autocmd MyAutoCmd ColorScheme * highlight CrlfString    cterm=reverse ctermfg=darkmagenta
autocmd MyAutoCmd VimEnter,WinEnter * let w:m3 = matchadd('CrlfString',    '\r\n')
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
"set undofile
"set undodir=$HOME/.vim/gundo
"set undodir=$HOME.'/.vim/gundo'.b:now.'/'
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
"}}}
"
"
" NeoBundle
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc
"{{{
NeoBundle 'Shougo/vimproc', {
            \    'build' : {
            \        'windows' : 'make -f make_mingw32.mak',
            \        'cygwin'  : 'make -f make_cygwin.mak',
            \        'mac'     : 'make -f make_mac.mak',
            \        'unix'    : 'make -f make_unix.mak',},}
"}}}
" vital.vim
"{{{
NeoBundle 'vim-jp/vital.vim'
"}}}
" webapi-vim
"{{{
NeoBundle 'mattn/webapi-vim'
"}}}
" vim-fugitive
"{{{
NeoBundle 'tpope/vim-fugitive'
nnoremap <Leader>gstatus :Gstatus<CR>
nnoremap <Leader>glog :Glog<CR>
nnoremap <Leader>gadd :Gwrite<CR>
nnoremap <Leader>grm :Gremove<CR>
nnoremap <Leader>gdiff :Gdiff<CR>
nnoremap <Leader>gcommit :Gcommit
"}}}
" landscape
" lightline
"{{{
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
            \    'colorscheme': 'landscape',
            \    'mode_map': { 'c': 'NORMAL' },
            \    'active': {
            \        'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \    },
            \    'component_function': {
            \        'modified': 'MyModified',
            \        'readonly': 'MyReadonly',
            \        'fugitive': 'MyFugitive',
            \        'filename': 'MyFilename',
            \        'fileformat': 'MyFileformat',
            \        'filetype': 'MyFiletype',
            \        'fileencoding': 'MyFileencoding',
            \        'mode': 'MyMode',
            \    },
            \    'separator': { 'left': '', 'right': '' },
            \    'subseparator': { 'left': '|', 'right': '|' }
            \}
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
    return exists('*fugitive#head') ? fugitive#head() : ''
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
"}}}
" vdebug
"{{{
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
" vim-ref
"{{{
"# command memo
"* <S-k> :Show mabual
NeoBundle 'thinca/vim-ref'
let g:ref_phpmanual_path=$HOME.'/.vim/ref/php-chunked-xhtml'
"}}}
" vim-tags
"{{{
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
" vim-surround
"{{{
"# command memo
"* cs"'   :Change From  " to '
"* cs'<p> :Change From  ' to <p>
"* ds'    :Delete '
NeoBundle 'tpope/vim-surround'
"}}}
" wildfire.vim
"{{{
"# command memo
"* (Normal)Enter after Enter :Range up selected words.
"* (Normal)Backspace         :Range down selected words.
NeoBundle 'gcmt/wildfire.vim'
let g:wildfire_water_map = '<BS>'
let g:wildfire_objects = {
            \    '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
            \    'html,xml' : ['at'],
            \}
"}}}
" matchit.zip
"{{{
NeoBundle 'vim-scripts/matchit.zip'
"}}}
" vim-endwise
"{{{
NeoBundle 'tpope/vim-endwise'
"}}}
" vim-over
"{{{
NeoBundle 'osyo-manga/vim-over'
nnoremap <expr><Leader>s ':OverCommandLine<CR>%s/'.expand('<cword>').'/'
"}}}
" vim-qfreplace
"{{{
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
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cb :cprevious<CR>
nnoremap <Leader>cc :cc
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
"}}}
" memolist.vim
"{{{
NeoBundle 'glidenote/memolist.vim'
let g:memolist_path = '$HOME/.vim/memo'
nnoremap <Leader>mn  :MemoNew<CR>
nnoremap <Leader>ml  :MemoList<CR>
nnoremap <Leader>mg  :MemoGrep<CR>
"}}}
" vim-prettyprint
"{{{
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
"{{{
NeoBundleLazy 'Shougo/unite.vim', {
            \    'autoload' : {
            \        'commands' : ['Unite', 'UniteWithBufferDir', 'UniteWithCursorWord'],},}
NeoBundleLazy 'pasela/unite-webcolorname', {
            \    'autoload': {
            \        'unite_sources': ['webcolorname'],},}
NeoBundleLazy 'ujihisa/unite-colorscheme', {
            \    'autoload': {
            \        'unite_sources': ['colorscheme'],},}
NeoBundleLazy 'Shougo/unite-help', {
            \    'autoload': {
            \        'unite_sources': ['help'],},}
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
nnoremap <silent> [unite]h    :<C-u>Unite help<CR>
nnoremap <silent> [unite]mru  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]map  :<C-u>Unite output:map\|map!\|lmap<CR>
nnoremap <silent> [unite]nmap :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]r    :<C-u>Unite register<CR>
nnoremap <silent> [unite]s    :<C-u>Unite output:scriptnames<CR>
nnoremap <silent> [unite]t    :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w    :<C-u>Unite window<CR>
" add plugins
nnoremap <silent> [unite]web :<C-u>Unite webcolorname<CR>
nnoremap <silent> [unite]cs  :<C-u>Unite -auto-preview colorscheme<CR>
autocmd MyAutoCmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"}}}
" vimdoc-ja
"{{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {
            \    'autoload' : {
            \        'commands' : ['help'],},}
let s:hooks = neobundle#get('vimdoc-ja')
function! s:hooks.on_source(bundle)
    helptags $HOME/.vim/bundle/vimdoc-ja/doc/
endfunction
"}}}
" taglist.vim
"{{{
"# command memo
"* :Tlist :Show class, function and etc at left menu.
NeoBundleLazy 'vim-scripts/taglist.vim', {
            \    'autoload' : {
            \        'commands' : ['Tlist'],},}
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
nnoremap <Leader>t :Tlist<CR>
"}}}
" nerdtree
"{{{
NeoBundleLazy 'scrooloose/nerdtree', {
            \    'autoload' : {
            \        'commands' : ['NERDTree'],},}
nnoremap <Leader>n :NERDTree<CR>
let NERDTreeShowHidden=1
"}}}
" vim-easy-align
"{{{
"# command memo
"* Virtual mode selected range.
"* exsamp:  And <Enter>*|
"*     or:  And <Enter>*=
NeoBundleLazy 'junegunn/vim-easy-align', {
            \    'autoload': {
            \        'commands' : ['EasyAlign'],},}
vnoremap <silent> <Leader>a :EasyAlign<CR>
"}}}
" syntastic'
"{{{
NeoBundleLazy 'scrooloose/syntastic', {
            \    'autoload' : {
            \        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('syntastic')
function! s:hooks.on_source(bundle)
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=2
endfunction
"}}}
" gundo.vim
"{{{
NeoBundleLazy 'sjl/gundo.vim', {
            \    'autoload' : {
            \        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('gundo.vim')
function! s:hooks.on_source(bundle)
    nnoremap u g-
    nnoremap <C-r> g+
    nnoremap <Leader>g :GundoToggle<CR>
endfunction
""}}}
" sudo.vim
"{{{
"# command memo
"* ':w sudo:%'          :sudo save
"* ':w sudo:<filename>' :sudo another name save
"* ':e sudo:%'          :sudo open
NeoBundleLazy 'vim-scripts/sudo.vim', {
            \    'autoload' : {
            \        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('sudo.vim')
function! s:hooks.on_source(bundle)
    nnoremap <Leader>sudow :w<Space>sudo:%<CR>
    nnoremap <Leader>sudoa :w<Space>sudo:
    nnoremap <Leader>sudor :e<Space>sudo:%<CR>
endfunction
"}}}
" vim-php-cs-fixer
"{{{
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
endfunction
" add .vimrc.local
"}}}
"}}}
" neocomplete.vim
"{{{
NeoBundleLazy 'Shougo/neocomplete.vim', {
            \    'autoload' : {
            \        'insert' : 1,},}
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup=0
    let g:neocomplete#enable_at_startup=1
    let g:neocomplete#enable_smart_case=1
    let g:neocomplete#sources#syntax#min_keyword_length=3
    let g:neocomplete#lock_buffer_name_pattern='\*ku\*'
endfunction
"}}}
" neosnippet.vim
" neosnippet-snippets
" vim-snippets
"{{{
NeoBundleLazy 'Shougo/neosnippet.vim', {
            \    'depends': ['honza/vim-snippets','shougo/neosnippet-snippets'],
            \    'autoload': {
            \        'insert': 1,},}
let s:hooks = neobundle#get_hooks('neosnippet.vim')
function! s:hooks.on_source(bundle)
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ '\<Plug>(neosnippet_expand_or_jump)'
                \: pumvisible() ? '\<C-n>' : '\<TAB>'
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ '\<Plug>(neosnippet_expand_or_jump)'
                \: '\<TAB>'
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/vim-snippets/snippets'
endfunction
"}}}
" Markdown with Vim
"  vim-quickrun
"  w3m.vim
"  vim-markdown
"{{{
"# command memo
"* :QuickRun :execute quickrun.
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'plasticboy/vim-markdown'
nnoremap <Leader>r :QuickRun<CR>
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
            \    'outputter' : 'file',
            \    'outputter/name' : tempname().'.html'
            \}
let t:outputter_w3m_vim_bufname = ''
let s:hook = {
            \   'name': 'outputer_w3m_vim',
            \   'kind': 'hook',
            \   'is_success': 0,
            \   'config': { 'enable': 1 },
            \   '_bufname': 'bufhook'
            \}
function! s:hook.on_success(session, context)
    if a:session.config.outputter != 'file' || !match(a:session.config['outputter/name'], '.html$\c')
        return
    endif
    let mode = g:w3m#OPEN_SPLIT
    let target = 'local'
    let fname = a:session.outputter._file
    let bufname = t:outputter_w3m_vim_bufname
    if bufname != '' && bufwinnr(bufname) != -1
        execute bufwinnr(bufname) 'wincmd w'
        let mode = g:w3m#OPEN_NORMAL
        silent call w3m#Open( mode, target, fname )
    else
        silent call w3m#Open( mode, target, fname )
        let t:outputter_w3m_vim_bufname = b:w3m_bufname
    endif
endfunction
call quickrun#module#register(s:hook, 1)
unlet s:hook
"}}}
"
"
" NeoBundleFetch
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" ColorScheme
"{{{
NeoBundleFetch 'nanotech/jellybeans.vim'
NeoBundleFetch 'altercation/vim-colors-solarized'
NeoBundleFetch 'tomasr/molokai'
"}}}
"}}}
"
"
" FileType
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
filetype plugin indent on
autocmd MyAutoCmd BufNewFile,BufRead *.{md,mkd,mdwn,mkdn,mark*} set filetype=markdown
"}}}
"
"
" Extra local functions
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
"# function memo
"* URL: http://qiita.com/rbtnn/items/39d9ba817329886e626b
"* NoFormattings :echo neobundle#config#get_neobundles()
"* Formattings   :QuickRunPP neobundle#config#get_neobundles()
"* Formatting    :echo neobundle#get('vim-markdown')
"* Formatting    :echo neobundle#get_hooks('vim-markdown')
function! s:quickrun_pp(q_args)
    let dict = { 'type' : 'vim', 'runner' : 'vimscript', 'outputter' : 'buffer',
                \   'outputter/buffer/filetype' : 'vim', 'hook/eval/enable' : 1,
                \   'hook/eval/template' : 'echo PP(%s)', 'src' : a:q_args,}
    call quickrun#run(dict)
endfunction
command! -nargs=1 -complete=expression QuickRunPP :call <sid>quickrun_pp(<q-args>)
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

