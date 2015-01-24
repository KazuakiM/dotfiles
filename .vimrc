"
"
" Memo {{{
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
" Common {{{
if has('vim_starting')
    if (has("win32") || has ("win64"))
        let s:os_type = 'win'
        set runtimepath+=$HOME/.vim,$HOME/.vim/after
    elseif has('mac')
        let s:os_type = 'mac'
    else
        let s:os_type = 'unix'
    endif
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif
augroup MyAutoCmd
    autocmd!
augroup END
" Variable
let s:date = strftime('%Y%m%d%H%M%S', localtime())
" Encode
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileformat=unix
" Basic
let g:mapleader = ','
set scrolloff=999
autocmd MyAutoCmd FileType * set textwidth=0
autocmd MyAutoCmd FileType * set formatoptions-=cb
set autoread
set hidden
set ambiwidth=double
set iminsert=0
set imsearch=-1
set backspace=indent,eol,start
set virtualedit+=block
set visualbell
set t_vb=
set noerrorbells
set noimdisable
set noimcmdline
set foldmethod=marker
"set foldopen-=search
set viminfo='100,f1,<50,:20,@20,/20,s100,h,n~/.vim/viminfo/.viminfo
set updatetime=1000
nnoremap zx :foldopen<CR>
set matchpairs+=<:>
noremap 0 $
noremap 1 ^
nnoremap Y y$
nnoremap gr gT
nnoremap gf <C-w>w
nnoremap gs <C-w>+
nnoremap gd <C-w>-
noremap j gj
noremap k gk
noremap <Down> <C-f>
noremap <Up>   <C-b>
nnoremap <Leader>w :<C-u>w<Space>!sudo<Space>tee<Space>%<Space>><Space>/dev/null<CR>
" Paste
autocmd MyAutoCmd InsertLeave * set nopaste
nnoremap <silent><expr><Leader>v      ':set<Space>paste<CR><Insert><C-r>+<ESC>'
inoremap <silent><expr><Leader>v '<ESC>:set<Space>paste<CR><Insert><C-r>+<ESC><Insert>'
" Color
syntax on
" Check space and new line code.
set t_Co=16
set background=dark
autocmd MyAutoCmd ColorScheme * highlight TabString       cterm=NONE      ctermbg=Gray    guibg=Gray
autocmd MyAutoCmd ColorScheme * highlight CrString        cterm=NONE      ctermbg=Gray    guibg=Gray
autocmd MyAutoCmd ColorScheme * highlight CrlfString      cterm=NONE      ctermbg=Gray    guibg=Gray
autocmd MyAutoCmd ColorScheme * highlight WhitespaceEOL   cterm=NONE      ctermbg=Gray    guibg=Gray
autocmd MyAutoCmd ColorScheme * highlight YankRoundRegion cterm=NONE                                      ctermfg=Magenta guifg=Magenta
autocmd MyAutoCmd ColorScheme * highlight QFError         cterm=underline                                 ctermfg=Magenta guifg=Magenta
autocmd MyAutoCmd ColorScheme * highlight StatusLineNC    cterm=NONE      ctermbg=DarkGray guifg=DarkGray
autocmd MyAutoCmd VimEnter,WinEnter * let w:m1 = matchadd('TabString',     "\t")
autocmd MyAutoCmd VimEnter,WinEnter * let w:m2 = matchadd('CrString',      "\r")
autocmd MyAutoCmd VimEnter,WinEnter * let w:m3 = matchadd('CrlfString',    "\r\n")
autocmd MyAutoCmd VimEnter,WinEnter * let w:m4 = matchadd('WhitespaceEOL', '\s\+$')
colorscheme desert
" Show
set title
set ruler
set laststatus=2
set cmdheight=1
set wildignore+=*.bmp,*.gif,*.git,*.ico,*.jpeg,*.jpg,*.log,*.mp3,*.ogg,*.otf,*.pdf,*.png,*.qpf2,*.svn,*.ttf,*.wav,.DS_Store,.,..
set wildmenu
set wildmode=longest:full,full
set completeopt=longest,menu
set noequalalways
set wrap
set display=lastline
set pumheight=8
set showmatch
set matchtime=1
" [memo]
" q:  command history
" q/  downward search
" q?  upward search
set history=1000
set number
set cursorline
set cursorcolumn
function! StatuslineSyntax()
    return qfstatusline#Update()
endfunction
function! StatuslineMode()
    let a:mode_list    = {'n': 'NORMAL ','v': 'VISUAL ','V': 'V-LINE ',"\<C-v>": 'V-BLOCK','s': 'SELECT ','S': 'S-LINE ',"\<C-s>": 'S-BLOCK','i': 'INSERT ','R': 'REPLACE','c': 'COMMAND'}
    let a:current_mode = mode()
    if count(a:mode_list, a:current_mode) ==# 0
        return a:mode_list[a:current_mode]
    endif
    return a:current_mode.'?'
endfunction
set statusline=\ %{StatuslineMode()}\ \|\ %t\ %m\ %r\ %h\ %w\ %q\ %{StatuslineSyntax()}%=\|\ %Y\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ 
" Clipboard
set clipboard+=autoselect,unnamed
" Backup
set swapfile
set directory=$HOME/.vim/swap
set backup
set undofile
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
" Tags
nnoremap <Leader>] <C-]>
nnoremap <Leader>: :<C-u>tab<Space>stj<Space><C-R>=expand('<cword>')<CR><CR>
nnoremap <Leader>[ <C-o>
" Pretty print
nnoremap <Leader>xml  :execute '%!xmllint --noblanks --nowrap --encode UTF-8 --format %'<CR>
nnoremap <Leader>json :execute '%!python -m json.tool'<CR>
" Register
vnoremap <C-w> "ay
vnoremap <C-e> "by
nnoremap <expr>;s ':%s/<C-r>a/<C-r>b/gc'
" $VIMRUNTIME/syntax/sql.vim
let g:sql_type_default = 'mysql'
" $VIMRUNTIME/syntax/php.vim
let g:php_sql_query     = 1
let g:php_htmlInStrings = 1
let g:php_baselib       = 1
let g:php_noShortTags   = 1
" Vim
nnoremap [vim] <Nop>
nmap <Leader>f [vim]
nnoremap [vim]e :<C-u>tabnew<Space>$MYVIMRC<CR>
nnoremap [vim]s :<C-u>source<Space>$MYVIMRC<CR>
nnoremap [vim]h :<C-u>source<Space>$VIMRUNTIME/syntax/colortest.vim<CR>
" ESC-ESC
autocmd MyAutoCmd CmdwinEnter * nmap <silent> <ESC><ESC> :q<CR>
autocmd MyAutoCmd CmdwinLeave * nunmap <ESC><ESC>
"}}}
"
"
" NeoBundle START {{{
call neobundle#begin(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
let g:neobundle#log_filename = $HOME.'/.vim/neobundle.vim/neobundle.log'
"}}}
"
"
" NeoBundle {{{
if neobundle#has_cache()
    NeoBundleLoadCache
else
    NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak', 'cygwin': 'make -f make_cygwin.mak'}}
    NeoBundle 'vim-jp/vital.vim'
    NeoBundle 'vim-scripts/matchit.zip'
    NeoBundle 'tpope/vim-endwise'
    NeoBundle 'fuenor/qfixgrep'
    NeoBundle 'LeafCage/yankround.vim'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'rhysd/clever-f.vim'
    if (s:os_type !=# 'unix')
        NeoBundle 'Yggdroot/indentLine'
    endif

    NeoBundleSaveCache
endif
" qfixgrep {{{
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude='*min.js'\ --exclude='*min.css'\ --exclude='*.log'
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
let g:QFixWin_EnableMode   = 1
let g:QFix_UseLocationList = 1
nnoremap <expr> <Leader>grep ':silent grep! '.expand('<cword>').' '.vital#of("vital").import("Prelude").path2project_directory("%").'<CR>'
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
"}}}
" yankround.vim {{{
let g:yankround_dir=$HOME.'/.vim/yankround.vim'
nmap p <Plug>(yankround-p)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_use_region_hl       = 1
let g:yankround_region_hl_groupname = 'YankRoundRegion'
"}}}
" vim-quickrun {{{
nnoremap <Leader>run :<C-u>QuickRun<CR>
let g:quickrun_config = {
\    '_': {
\        'hook/close_buffer/enable_empty_data': 1,
\        'hook/close_buffer/enable_failure':    1,
\        'outputter':                           'multi:buffer:quickfix',
\        'outputter/buffer/close_on_empty':     1,
\        'outputter/buffer/split':              ':botright',
\        'runner':                              'vimproc',
\        'runner/vimproc/updatetime':           600},
\    'watchdogs_checker/_': {
\        'hook/close_quickfix/enable_exit':      1,
\        'hook/back_window/enable_exit':         0, 'hook/back_window/priority_exit':         1,
\        'hook/qfsigns_update/enable_exit':      1, 'hook/qfsigns_update/priority_exit':      2,
\        'hook/qfstatusline_update/enable_exit': 1, 'hook/qfstatusline_update/priority_exit': 3,
\        'outputter/quickfix/open_cmd':          ''},
\    'watchdogs_checker/php': {
\        'command':     'php',
\        'exec':        '%c -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0 -l %o %s:p',
\        'errorformat': '%m\ in\ %f\ on\ line\ %l'},
\    'markdown': {'outputter': 'browser'},
\    'php': {
\        'command':                          'phpunit',
\        'cmdopt':                           '--no-configuration',
\        'hook/close_buffer/enable_failure': 0,
\        'outputter/buffer/split':           ':botright 7sp'}}
"}}}
" ultisnips {{{
let g:UltiSnipsEditSplit           = 'vertical'
let g:UltiSnipsExpandTrigger       = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:UltiSnipsJumpForwardTrigger  = '<TAB>'
let g:UltiSnipsSnippetsDir         = $HOME.'/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsUsePythonVersion    = 2
"}}}
" clever-f.vim {{{
let g:clever_f_across_no_line = 0
let g:clever_f_smart_case     = 1
let g:clever_f_use_migemo     = 0
"}}}
"}}}
"
"
" NeoBundleLazy {{{
" unite.vim
" unite-help
" codic-vim
" unite-codic.vim
" memolist.vim {{{
NeoBundleLazy 'Shougo/unite.vim',       { 'commands': 'Unite'}
NeoBundleLazy 'Shougo/unite-help',      { 'depends':  'Shougo/unite.vim', 'unite_sources':     'help'}
NeoBundleLazy 'rhysd/unite-codic.vim',  { 'depends':  ['koron/codic-vim', 'Shougo/unite.vim'], 'unite_sources': 'codic'}
NeoBundleLazy 'glidenote/memolist.vim', { 'commands': ['MemoNew',         'MemoList']}
nnoremap <SID>[unite] <Nop>
nmap <Leader>u <SID>[unite]
" default plugins
nnoremap <silent> <SID>[unite]f   :<C-u>call<Space>DispatchUniteFileRecAsyncOrGit()<CR>
nnoremap <silent> <SID>[unite]map :<C-u>Unite<Space>output:map\|map!\|lmap<CR>
nnoremap <silent> <SID>[unite]msg :<C-u>Unite<Space>output:message<CR>
nnoremap <silent> <SID>[unite]s   :<C-u>Unite<Space>-default-action=ex<Space>output:scriptnames<CR>
" add plugins
nnoremap <silent> <SID>[unite]dic :<C-u>Unite<Space>codic<CR>
nnoremap <silent> <SID>[unite]h   :<C-u>Unite<Space>help<CR>
" memolist
nnoremap <SID>[memolist] <Nop>
nmap <Leader>m <SID>[memolist]
nnoremap <SID>[memolist]n :<C-u>MemoNew<CR>
nnoremap <SID>[memolist]l :<C-u>MemoList<CR>
" http://qiita.com/yuku_t/items/9263e6d9105ba972aea8
function! DispatchUniteFileRecAsyncOrGit()
    if isdirectory(getcwd().'/.git')
        Unite -default-action=tabopen file_rec/git
    else
        Unite -default-action=tabopen file_rec/async:!
    endif
endfunction
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    let g:unite_data_directory             = $HOME.'/.vim/unite.vim'
    let g:unite_enable_start_insert        = 1
    let g:unite_source_grep_command        = 'ag'
    let g:unite_source_grep_default_opts   = '--nocolor --nogroup'
    let g:unite_source_grep_recursive_opt  = ''
    let g:unite_source_grep_max_candidates = 200
endfunction
let s:hooks = neobundle#get_hooks('memolist.vim')
function! s:hooks.on_source(bundle)
    let g:memolist_filename_prefix_none = 1
    let g:memolist_unite                = 1
    let g:memolist_unite_source         = 'file_rec'
    let g:memolist_unite_option         = '-default-action=tabopen'
endfunction
"}}}
" vimdoc-ja {{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {'commands': 'help'}
"helptags $HOME/.vim/bundle/vimdoc-ja/doc/
"set helplang=ja
"}}}
" taglist.vim {{{
NeoBundleLazy 'vim-scripts/taglist.vim', {'commands': 'Tlist'}
nnoremap <Leader>t :<C-u>Tlist<CR>
let s:hooks = neobundle#get_hooks('taglist.vim')
function! s:hooks.on_source(bundle)
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_Show_One_File    = 1
    let g:Tlist_Exit_OnlyWindow  = 1
    let g:Tlist_WinWidth         = 25
    let g:tlist_php_settings     = 'php;c:class;f:function;d:constant'
endfunction
"}}}
" nerdtree {{{
NeoBundleLazy 'scrooloose/nerdtree', {'commands': 'NERDTree'}
nnoremap <expr><Leader>n ':NERDTree '.vital#of("vital").import("Prelude").path2project_directory("%").'<CR>'
let s:hooks = neobundle#get_hooks('nerdtree')
function! s:hooks.on_source(bundle)
    let g:NERDTreeWinSize           = 20
    let g:NERDTreeMinimalUI         = 1
    let g:NERDTreeRespectWildIgnore = 1
    let g:NERDTreeShowHidden        = 1
    autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif
endfunction
"}}}
" vim-easy-align {{{
NeoBundleLazy 'junegunn/vim-easy-align', {'commands': 'EasyAlign'}
vnoremap <silent> <Leader>a :EasyAlign<CR>
let g:easy_align_delimiters = {
\    '=': {
\        'pattern':     '===\|!==\|<=>\|\(&&\|||\|<<\|>>\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.-]\?=[#?]\?',
\        'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0},
\    '>': {'pattern': '>>\|=>\|>'},
\    '/': {'pattern': '//\+\|/\*\|\*/',        'ignore_groups': ['String']},
\    '#': {'pattern': '#\+',                   'ignore_groups': ['String'], 'delimiter_align': 'l'},
\    '$': {'pattern': '\((.*\)\@!$\(.*)\)\@!', 'ignore_groups': ['String'], 'right_margin':    0, 'delimiter_align': 'l'},
\    ']': {'pattern': '[[\]]',                 'left_margin':   0,          'right_margin':    0, 'stick_to_left':   0},
\    ')': {'pattern': '[()]',                  'left_margin':   0,          'right_margin':    0, 'stick_to_left':   0},
\    'd': {'pattern': '\(\S\+\s*[;=]\)\@=',    'left_margin':   0,          'right_margin':    0}}
"}}}
" Align
" SQLUtilities {{{
NeoBundleLazy 'vim-scripts/SQLUtilities', {'depends': 'vim-scripts/Align', 'commands': 'SQLUFormatter'}
let g:sqlutil_align_comma = 1
nnoremap <Leader>sql :<C-u>SQLUFormatter<CR>
"}}}
" previm {{{
NeoBundleLazy 'kannokanno/previm', {'depends': 'open-browser.vim', 'commands': 'PrevimOpen'}
nnoremap <silent> <Leader>pre :<C-u>PrevimOpen<CR>
"}}}
" vim-ref {{{
NeoBundleLazy 'thinca/vim-ref', {'functions': 'ref#K'}
let g:ref_no_default_key_mappings = 1
inoremap <silent><C-k> <C-o>:call<space>ref#K("normal")<CR><ESC>
nnoremap <silent>K :<C-u>call ref#K('normal')<CR>
let s:hooks = neobundle#get_hooks('vim-ref')
function! s:hooks.on_source(bundle)
    let g:ref_cache_dir       = $HOME.'/.vim/vim-ref/cache'
    let g:ref_phpmanual_path  = $HOME.'/.vim/vim-ref/php-chunked-xhtml'
    let g:ref_detect_filetype = {'html': 'phpmanual', 'javascript': 'phpmanual', 'css': 'phpmanual'}
endfunction
"}}}
" vim-php-cs-fixer {{{
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {'functions': 'PhpCsFixerFixFile'}
nnoremap <Leader>php :<C-u>call<Space>PhpCsFixerFixFile()<CR>
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle)
    let g:php_cs_fixer_config                 = 'default'
    let g:php_cs_fixer_dry_run                = 0
    let g:php_cs_fixer_enable_default_mapping = 0
    let g:php_cs_fixer_level                  = 'all'
    let g:php_cs_fixer_path                   = $HOME.'/.vim/vim-php-cs-fixer/php-cs-fixer'
    let g:php_cs_fixer_php_path               = 'php'
    let g:php_cs_fixer_verbose                = 0
endfunction
"}}}
" open-browser.vim {{{
NeoBundleLazy 'tyru/open-browser.vim', {'mappings': '<Plug>(openbrowser-smart-search)'}
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nnoremap <Leader>gx <Plug>(openbrowser-smart-search)
"}}}
" wildfire.vim {{{
NeoBundleLazy 'gcmt/wildfire.vim', {'mappings': '<Plug>(wildfire-fuel)'}
map <ENTER> <Plug>(wildfire-fuel)
map <BS> <Plug>(wildfire-water)
let g:wildfire_objects = {'*': ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it'],'html,xml': ['at', 'it']}
"}}}
" vim-snippets
" neocomplete.vim {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {'depends': 'KazuakiM/vim-snippets', 'insert': 1}
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:neocomplete#auto_completion_start_length     = 3
    let g:neocomplete#data_directory                   = $HOME.'/.vim/neocomplete.vim'
    let g:neocomplete#enable_at_startup                = 1
    let g:neocomplete#enable_auto_close_preview        = 3
    let g:neocomplete#enable_smart_case                = 1
    let g:neocomplete#keyword_patterns                 = {'_': '\h\w*'}
    let g:neocomplete#lock_buffer_name_pattern         = '\.log\|.*quickrun.*\|.jax'
    let g:neocomplete#max_keyword_width                = 30
    let g:neocomplete#max_list                         = 8
    let g:neocomplete#min_keyword_length               = 3
    let g:neocomplete#sources                          = {'_': ['ultisnips', 'dictionary', 'buffer']}
    let g:neocomplete#sources#buffer#cache_limit_size  = 50000
    let g:neocomplete#sources#buffer#disabled_pattern  = '\.log\|\.jax'
    let g:neocomplete#sources#buffer#max_keyword_width = 30
    let g:neocomplete#sources#dictionary#dictionaries  = {'_': '', 'php': $HOME.'/.vim/dict/php.dict'}
    let g:neocomplete#use_vimproc                      = 1
endfunction
"}}}
" gundo.vim {{{
NeoBundleLazy 'sjl/gundo.vim', {'insert': 1}
let s:hooks = neobundle#get_hooks('gundo.vim')
function! s:hooks.on_source(bundle)
    nnoremap u g-
    nnoremap <C-r> g+
    nnoremap <Leader>gundo :<C-u>GundoToggle<CR>
endfunction
"}}}
" vim-surround {{{
NeoBundleLazy 'tpope/vim-surround', {'insert': 1}
"}}}
" shabadou.vim
" vim-qfsigns
" vim-qfstatusline
" vim-watchdogs {{{
let g:Qfstatusline#UpdateCmd = function('StatuslineSyntax')
NeoBundleLazy 'osyo-manga/vim-watchdogs', {'depends': ['thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'KazuakiM/vim-qfsigns', 'KazuakiM/vim-qfstatusline'], 'filetypes': ['php', 'javascript', 'ruby'], 'insert': 1}
let s:hooks = neobundle#get_hooks('vim-watchdogs')
function! s:hooks.on_source(bundle)
    "vim-qfsigns
    nnoremap <Leader>sy :QfsignsJunmp<CR>
    let g:qfsigns#Config = {'id': '5050', 'name': 'QFError',}
    execute 'sign define '.get(g:qfsigns#Config,'name').' linehl=QFError texthl=QFError text=>>'
    "vim-watchdogs
    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_CursorHold_enable   = 1
endfunction
unlet s:hooks
"}}}
" vim-markdown {{{
NeoBundleLazy 'plasticboy/vim-markdown', {'filetypes': 'markdown'}
"}}}
"}}}
"
"
" NeoBundleFetch {{{
"# function memo
"* New Install 'NeoBundle'. And Update 'NeoBundle' to 'NeoBundleFetch'.
NeoBundleFetch 'psychs/lingr-irc'
NeoBundleFetch 'KazuakiM/neosnippet-snippets'
"}}}
"
"
" OS type {{{
" Exclusive {{{
if (s:os_type !=# 'mac')
    autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
if (s:os_type !=# 'win')
    autocmd MyAutoCmd VimEnter * call s:auto_mkdir('/tmp/backup/'.s:date, 1)
    autocmd MyAutoCmd VimEnter * call s:auto_mkdir('/tmp/undo/'  .s:date, 1)
    let &backupdir = '/tmp/backup/'.s:date
    let &undodir   = '/tmp/undo/'  .s:date
    " memolist.vim {{{
    let g:memolist_path = $HOME.'/.vim/memolist.vim'
    "}}}
endif
if (s:os_type !=# 'unix')
    " indentLine {{{
    let g:indentLine_faster = 1
    "}}}
endif
"}}}
" Only {{{
if (s:os_type ==# 'mac')
    " previm {{{
    let g:previm_open_cmd  = 'open -a firefox'
    "}}}
elseif (s:os_type ==# 'win')
    autocmd MyAutoCmd VimEnter * call s:auto_mkdir('C:\temp\backup\'.s:date, 1)
    autocmd MyAutoCmd VimEnter * call s:auto_mkdir('C:\temp\undo\'  .s:date, 1)
    let &backupdir = 'C:\temp\backup\'.s:date
    let &undodir   = 'C:\temp\undo\'  .s:date
    " memolist.vim {{{
    let g:memolist_path = '/cygwin64/home/kazuakim/.vim/memolist.vim'
    "}}}
elseif (s:os_type ==# 'unix')
endif
"}}}
"}}}
"
"
" NeoBundle END {{{
call neobundle#end()
"}}}
"
"
" FileType {{{
filetype plugin indent on
autocmd MyAutoCmd BufNewFile,BufRead *.{md,mkd,mdwn,mkdn,mark*} setlocal filetype=markdown
autocmd MyAutoCmd BufNewFile,BufRead *.coffee                   setlocal filetype=coffee
autocmd MyAutoCmd BufNewFile,BufRead *.{snip*}                  setlocal filetype=snippets
autocmd MyAutoCmd BufNewFile,BufRead *.{bin,exe}                setlocal filetype=xxd
"}}}
"
"
" Extra local functions {{{
" auto make directory {{{
function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
"}}}
"}}}
"
"
" Other setting files {{{
" Environment setting file
if (s:os_type ==# 'win')
    source ~/.vimrc.win
else
    source ~/.vimrc.local
endif
"}}}

