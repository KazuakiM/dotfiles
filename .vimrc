"
"
" MEMO {{{
" :help internal-variables {{{
"+----+-------------------+---------------------------------------------+
"| b: | buffer-variable   | Local to the current buffer.                |
"| w: | window-variable   | Local to the current window.                |
"| t: | tabpage-variable  | Local to the current tab page.              |
"| g: | global-variable   | Global.                                     |
"| l: | local-variable    | Local to a function.                        |
"| s: | script-variable   | Local to a :source'ed Vim script.           |
"| a: | function-argument | Function argument (only inside a function). |
"| v: | vim-variable      | Global, predefined by Vim.                  |
"+----+-------------------+---------------------------------------------+
"}}}
" :help map {{{
"+----------------------------------------------+--------------------------------------------------------------------------------+
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
"+-----------+-----------+---------+------------+--------+--------+--------+------------------+--------+--------------+----------+
"}}}
"}}}
"
"
" Variables {{{
let s:envHome    = ! exists('s:envHome')    ? $HOME                                 : s:envHome
let s:date       = ! exists('s:date')       ? strftime('%Y%m%d%H%M%S', localtime()) : s:date
let s:lineUpdate = ! exists('s:lineUpdate') ? 0                                     : s:lineUpdate
"}}}
"
"
" Common {{{
" Zun wiki http://www.kawaz.jp/pukiwiki/?vim#cb691f26 {{{
set encoding=utf-8 fileencoding=utf-8 fileformats=unix,dos,mac
let s:enc_euc = 'euc-jp'
let s:enc_jis = 'iso-2022-jp'
if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
endif
let &fileencodings = &fileencodings .','. s:enc_jis .','. s:enc_euc .',cp932'
unlet s:enc_euc
unlet s:enc_jis
"}}}

scriptencoding utf-8
let g:mapleader = ','
augroup MyAutoCmd
    autocmd!
augroup END

function! s:KazuakiMAutoMkdir(dir) abort "{{{
    if !isdirectory(a:dir)
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction "}}}

function! s:KazuakiMVimStart(backupDir, undoDir) abort "{{{
    "Check 256KB file size.
    if getfsize(expand('%:p')) >= 262144
        call kazuakim#Minimal()
        return 1
    endif
    call s:KazuakiMAutoMkdir(a:backupDir.s:date)
    call s:KazuakiMAutoMkdir(a:undoDir.  s:date)
    let &backupdir = a:backupDir.s:date
    let &undodir   = a:undoDir.  s:date
    return 0
endfunction "}}}

if has('vim_starting')
    if has('win32') || has ('win64')
        if s:KazuakiMVimStart('C:\temp\backup\', 'C:\temp\undo\')
            finish
        endif
        let s:osType = 'win'
        set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
    elseif has('macunix')
        if s:KazuakiMVimStart('/tmp/backup/', '/tmp/undo/')
            finish
        endif
        let s:osType = 'macunix'
    else
        if s:KazuakiMVimStart('/tmp/backup/', '/tmp/undo/')
            finish
        endif
        let s:osType = 'unix'
    endif
endif

function! s:KazuakiMCheckString() abort "{{{
    let w:m1 = matchadd('KazuakiMCheckString', '\t\|\r\|\r\n\|\s\+$\|　')
    let w:m2 = matchadd('KazuakiMTodo',        'FIXME\|MEMO\|NOTE\|TODO\|XXX')
endfunction "}}}

function! s:KazuakiMBufEnter() abort "{{{
    " Auto close VimDiff or primary NERDTree
    if winnr('$') is# 1 && (&l:diff || (exists('b:NERDTree') && b:NERDTree.isTabTree()) || &filetype is# 'quickrun')
        quit

    " Duplicate ban
    elseif v:servername is# 'GVIM1'
        setlocal viminfo=
        call remote_send('GVIM', '<ESC>:tabnew '.expand('%:p').'<CR>')
        call remote_foreground('GVIM')
        quit
    elseif v:servername is# 'VIM1'
        setlocal viminfo=
        call remote_send('VIM', '<ESC>:tabnew '.expand('%:p').'<CR>')
        call remote_foreground('VIM')
        quit
    endif

    " Move current file(/directory) path
    execute 'lcd '. fnameescape(expand('%:p:h'))

    " default filetype
    if &filetype is# '' || &filetype is# 'text'
        setlocal filetype=markdown
    endif

    " Forcibly update
    set formatoptions-=c formatoptions-=b formatoptions+=j formatoptions-=t formatoptions-=v textwidth=0

    " Set StatusLine
    if &fileencoding is# 'utf-8'
        highlight StatusLine cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Grey   guibg=Grey
    else
        highlight StatusLine cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Yellow guibg=Yellow
    endif
endfunction "}}}

function! s:KazuakiMBufReadPost() abort "{{{
    " memory cursol
    if line("'\"") > 1 && line("'\"") <= line('$')
        execute "normal! g`\""
    endif

    " Zun wiki http://www.kawaz.jp/pukiwiki/?vim#cb691f26 {{{
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding = &encoding
    endif
    "}}}
endfunction "}}}

function! s:KazuakiMVimEnter() abort "{{{
    " Forcibly update
    set ambiwidth=double showtabline=2
    call s:KazuakiMCheckString()

    if &l:diff
        wincmd h
    endif
endfunction "}}}

function! s:KazuakiMWinEnter() abort "{{{
    checktime
    call s:KazuakiMCheckString()
endfunction "}}}

autocmd MyAutoCmd BufEnter             * call s:KazuakiMBufEnter()
autocmd MyAutoCmd BufReadPost          * call s:KazuakiMBufReadPost()
autocmd MyAutoCmd CmdwinEnter          * nmap <silent> <ESC><ESC> :quit<CR>
autocmd MyAutoCmd CmdwinLeave          * nunmap <ESC><ESC>
autocmd MyAutoCmd FocusGained          * checktime
autocmd MyAutoCmd InsertLeave          * set nopaste | if &l:diff | diffupdate | endif
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
autocmd MyAutoCmd QuickfixCmdPost      * call kazuakim#QuickfixCmdPost()
autocmd MyAutoCmd VimEnter             * call s:KazuakiMVimEnter()
autocmd MyAutoCmd WinEnter             * call s:KazuakiMWinEnter()

function! KazuakiMStatuslineSyntax() abort "{{{
    let l:ret = qfstatusline#Update()
    if 0 < len(l:ret)
        if s:lineUpdate is# 0
            highlight StatusLine cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Magenta guibg=Magenta
            let s:lineUpdate = 1
        endif
    elseif s:lineUpdate is# 1
        highlight StatusLine cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Grey guibg=Grey
        let s:lineUpdate = 0
    endif
    return l:ret
endfunction "}}}

function! KazuakiMStatuslinePaste() abort "{{{
    if &paste is# 1
        return '(paste)'
    endif
    return ''
endfunction "}}}

" http://d.hatena.ne.jp/thinca/20111204/1322932585
function! s:KazuakiMTabpageLabelUpdate(tabNumber) abort "{{{
    let l:highlight = a:tabNumber is# tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let l:bufnrs    = tabpagebuflist(a:tabNumber)
    let l:bufnr     = len(l:bufnrs)
    if l:bufnr is# 1
        let l:bufnr = ''
    endif
    let l:modified = len(filter(copy(l:bufnrs), 'getbufvar(v:val, "&modified")')) ? '[+]' : ''
    return '%'. a:tabNumber .'T'. l:highlight . l:bufnr .' '. fnamemodify(bufname(l:bufnrs[tabpagewinnr(a:tabNumber) - 1]), ':t') .' '. l:modified .
    \    '%T%#TabLineFill#'
endfunction "}}}

function! KazuakiMTabLineUpdate() abort "{{{
    return join(map(range(1, tabpagenr('$')), 's:KazuakiMTabpageLabelUpdate(v:val)'), '|') .'%#TabLineFill#%T%=%#TabLineSel# '. getcwd() .' '
endfunction "}}}

" Basic
set autoindent autoread
set backspace=indent,eol,start backup
set clipboard+=autoselect,unnamed cmdheight=1 concealcursor=i conceallevel=2 completeopt=longest,menu
set diffopt=filler,context:5,iwhite,vertical display=lastline
set expandtab
set fillchars+=diff:* foldmethod=marker
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m guioptions+=M
set helplang=ja hidden history=1000 hlsearch
set ignorecase iminsert=0 imsearch=-1 incsearch
set laststatus=2 lazyredraw
set matchpairs+=<:> matchtime=1 mouse=
set nobomb noequalalways noerrorbells nogdefault noimcmdline noimdisable noruler noswapfile notitle number
set pumheight=8
set runtimepath+=$HOME/.vim/bundle/neobundle.vim
set scrolloff=999 shellslash shiftwidth=4 shortmess+=a shortmess+=I showcmd showmatch smartcase smartindent smarttab softtabstop=4 switchbuf=usetab
set tabline=%!KazuakiMTabLineUpdate() tabstop=4 titleold= ttyfast t_vb=
set undofile updatecount=30 updatetime=1000
set viminfo='10,/100,:100,@100,c,f1,h,<100,s100,n~/.vim/viminfo/.viminfo virtualedit+=block visualbell
set wildmenu wildmode=longest:full,full wrap wrapscan
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude='*.json'\ --exclude='*.log'\ --exclude='*min.js'\ --exclude='*min.css'
set wildignore+=*.bmp,*.gif,*.git,*.ico,*.jpeg,*.jpg,*.log,*.mp3,*.ogg,*.otf,*.pdf,*.png,*.qpf2,*.svn,*.ttf,*.wav,C,.DS_Store,.,..
set statusline=\ %t\ %{KazuakiMStatuslinePaste()}\ %m\ %r\ %h\ %w\ %q\ %{KazuakiMStatuslineSyntax()}%=%l/%L\ \|\ %Y\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ 
if &l:diff
    set cursorline
else
    set nocursorline
endif
"set foldopen-=search
"helptags $HOME/.vim/bundle/vimdoc-ja/doc
" Color
syntax enable
colorscheme kazuakim
" Mapping
"  ESC
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <CR> <CR>X<C-h>
"  Fold
nnoremap zx :foldopen<CR>
"  Line
noremap 0 $
noremap 1 ^
nnoremap Y y$
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
"  Tag
nnoremap gr gT
"  Window Size
nnoremap <SID>[ws] <Nop>
nmap + <C-w>+<SID>[ws]
nmap - <C-w>-<SID>[ws]
nmap > <C-w>><SID>[ws]
nmap < <C-w><<SID>[ws]
nnoremap <script> <SID>[ws]+ <C-w>+<SID>[ws]
nnoremap <script> <SID>[ws]- <C-w>-<SID>[ws]
nnoremap <script> <SID>[ws]> <C-w>><SID>[ws]
nnoremap <script> <SID>[ws]< <C-w><<SID>[ws]
"  Cursor
nnoremap ga %
noremap <Down>  <C-f>
noremap <Up>    <C-b>
noremap <Right> $
noremap <Left>  ^
"  Sudo Write
nnoremap <Leader>w :<C-u>w<Space>!sudo<Space>tee<Space>%<Space>><Space>/dev/null<CR>
"  Paste
nnoremap <silent><expr><Leader>v  ':set<Space>paste<CR><Insert><Right><C-r>+<ESC>'
inoremap <silent><expr><C-v> '<ESC>:set<Space>paste<CR><Insert><Right><C-r>+<ESC><Insert><Right>'
cnoremap <M-v> <C-R><C-O>*
"  Replace
nnoremap R gR
nnoremap <expr><Leader>%s  ':%s/'. expand('<cword>') .'/'. expand('<cword>') .'/gc<Left><Left><Left>'
nnoremap <expr><Leader>%%s ':%s/'. expand('<cword>') .'//gc<Left><Left><Left>'
"  Search
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
"  Tags
nnoremap <Leader>] <C-]>
nnoremap <Leader>: :<C-u>tab<Space>stj<Space><C-R>=expand('<cword>')<CR><CR>
nnoremap <Leader>[ <C-o>
"  Diff
nnoremap <Leader>df :<C-u>diffsplit<Space>
nnoremap <C-k> [c
nnoremap <C-j> ]c
nnoremap <C-h> do
nnoremap <C-l> dp
"  Pretty print
nnoremap <Leader>xml  :execute '%!xmllint --noblanks --nowrap --encode UTF-8 --format %'<CR>
nnoremap <Leader>json :execute '%!python -m json.tool'<CR>
"  Register
nnoremap x "_x
nnoremap X "_x
vnoremap <C-w> "ay
vnoremap <C-e> "by
nnoremap <expr>;s ':%s/<C-r>a/<C-r>b/gc'
" Wildmenu
cnoremap <Left>  <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>
" Special word
noremap! ¥ \
" $VIMRUNTIME/syntax/sql.vim
let g:sql_type_default = 'mysql'
" $VIMRUNTIME/syntax/php.vim
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
" $VIMRUNTIME/ftplugin/sql.vim
let g:ftplugin_sql_objects        = 1
let g:ftplugin_sql_omni_key       = 1
let g:ftplugin_sql_omni_key_left  = 1
let g:ftplugin_sql_omni_key_right = 1
let g:ftplugin_sql_statements     = 1
let g:omni_sql_no_default_maps    = 1
" disable plugin
let g:loaded_2html_plugin      = 1 "$VIMRUNTIME/plugin/tohtml.vim
let g:loaded_getscriptPlugin   = 1 "$VIMRUNTIME/plugin/getscriptPlugin.vim
let g:loaded_gzip              = 1 "$VIMRUNTIME/plugin/gzip.vim
let g:loaded_matchparen        = 1 "$VIMRUNTIME/plugin/matchparen.vim
let g:loaded_netrw             = 1 "$VIMRUNTIME/autoload/netrw.vim
let g:loaded_netrwFileHandlers = 1 "$VIMRUNTIME/autoload/netrwFileHandlers.vim
let g:loaded_netrwPlugin       = 1 "$VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_netrwSettings     = 1 "$VIMRUNTIME/autoload/netrwSettings.vim
let g:loaded_spellfile_plugin  = 1 "$VIMRUNTIME/plugin/spellfile.vim
let g:loaded_sql_completion    = 1 "$VIMRUNTIME/autoload/sqlcomplete.vim
let g:loaded_tar               = 1 "$VIMRUNTIME/autoload/tar.vim
let g:loaded_tarPlugin         = 1 "$VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_vimball           = 1 "$VIMRUNTIME/autoload/vimball.vim
let g:loaded_vimballPlugin     = 1 "$VIMRUNTIME/plugin/vimballPlugin.vim
let g:loaded_zip               = 1 "$VIMRUNTIME/autoload/zip.vim
let g:loaded_zipPlugin         = 1 "$VIMRUNTIME/plugin/zipPlugin.vim
let g:vimsyn_embed             = 1 "$VIMRUNTIME/syntax/vim.vim
" Vim
nnoremap <SID>[vim] <Nop>
nmap <Leader>f <SID>[vim]
nnoremap <SID>[vim]e :<C-u>tabnew<Space>$MYVIMRC<CR>
nnoremap <SID>[vim]w :<C-u>source<Space>$MYVIMRC<CR>
nnoremap <SID>[vim]s :<C-u>tabnew<Space>$HOME/.vim/vim-sqlfix/sqlfix.sql<CR>
nnoremap <SID>[vim]h :<C-u>source<Space>$VIMRUNTIME/syntax/colortest.vim<CR>
nnoremap <SID>[vim]c :<C-u>IndentLinesToggle<CR>
"}}}
"
"
" NeoBundle START {{{
call neobundle#begin(expand(s:envHome . '/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
let g:neobundle#cache_file            = s:envHome. '/.vim/neobundle.vim/cache'
let g:neobundle#install_max_processes = 3
let g:neobundle#log_filename          = s:envHome. '/.vim/neobundle.vim/neobundle.log'
"}}}
"
"
" NeoBundle {{{
if neobundle#load_cache()
    NeoBundle 'Shougo/vimproc.vim', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak', 'cygwin': 'make -f make_cygwin.mak'}}
    NeoBundle 'fuenor/qfixgrep'
    NeoBundle 'gcmt/wildfire.vim'
    NeoBundle 'KazuakiM/vim-qfstatusline'
    NeoBundle 'LeafCage/yankround.vim'
    NeoBundle 'rhysd/clever-f.vim'
    NeoBundle 'thinca/vim-prettyprint'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'vim-jp/vimdoc-ja'
    NeoBundle 'vim-jp/vital.vim'
    NeoBundle 'vim-scripts/matchit.zip'
    NeoBundle 'Yggdroot/indentLine'

    NeoBundleSaveCache
endif
" qfixgrep {{{
let g:QFix_PreviewHeight = 20
let g:QFixWin_EnableMode = 1
nnoremap <expr><Leader>grek ':grep! '. expand('<cword>') .' '. kazuakim#Path2ProjectDirectory('%') .'<C-b><Right><Right><Right><Right><Right><Right>'
nnoremap <expr><Leader>grel ':grep!  '. kazuakim#Path2ProjectDirectory('%') .'<C-b><Right><Right><Right><Right><Right><Right>'
"MEMO:tabnew <C-w>gf
"}}}
" wildfire.vim {{{
let g:wildfire_fuel_map  = '<Enter>'
let g:wildfire_objects   = ["i'", 'i"', 'i`', 'i,', 'i)', 'i}', 'i]', 'i>', 'ip', 'it']
let g:wildfire_water_map = '<BS>'
"}}}
" vim-qfstatusline {{{
let g:Qfstatusline#UpdateCmd = function('KazuakiMStatuslineSyntax')
"}}}
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_dir                 = s:envHome .'/.vim/yankround.vim'
let g:yankround_region_hl_groupname = 'YankRoundRegion'
let g:yankround_use_region_hl       = 1
"}}}
" clever-f.vim {{{
let g:clever_f_across_no_line = 0
let g:clever_f_smart_case     = 1
let g:clever_f_use_migemo     = 0
"}}}
" indentLine {{{
let g:indentLine_faster = 1
"}}}
"}}}
"
"
" NeoBundleLazy {{{
" nerdtree {{{
nnoremap <SID>[nerdtree] <Nop>
nmap <Leader>n <SID>[nerdtree]
nnoremap <expr><SID>[nerdtree]n ':NERDTree '. kazuakim#Path2ProjectDirectory('%') .'<CR>'
nnoremap       <SID>[nerdtree]b :<C-u>NERDTree<CR>
let g:NERDTreeBookmarksFile     = s:envHome .'/.vim/nerdtree/.NERDTreeBookmarks'
let g:NERDTreeMinimalUI         = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowBookmarks     = 1
let g:NERDTreeShowHidden        = 1
let g:NERDTreeWinSize           = 20
if isdirectory(expand('%:p'))
    NeoBundle 'scrooloose/nerdtree'
else
    NeoBundleLazy 'scrooloose/nerdtree', {'commands': 'NERDTree'}
endif
"}}}
" unite.vim
" unite-help
" codic-vim
" unite-codic.vim
" unite-highlight
" memolist.vim {{{
"
" MEMO:If gVim for Windows italic fonts are deleted, I would move 'unite-highlight' to backup/.vimrc.
"
NeoBundleLazy 'Shougo/unite.vim', {'commands': 'Unite', 'depends':  [
\    'koron/codic-vim', 'rhysd/unite-codic.vim', 'KazuakiM/unite-help', 'osyo-manga/unite-highlight']}
NeoBundleLazy 'glidenote/memolist.vim', { 'commands': ['MemoNew', 'MemoList']}
nnoremap <SID>[unite] <Nop>
nmap <Leader>u <SID>[unite]
" default plugins
nnoremap <silent> <SID>[unite]au  :<C-u>Unite<Space>output:autocmd<CR>
nnoremap <silent> <SID>[unite]f   :<C-u>call<Space>kazuakim#UniteFileRecAsyncOrGit()<CR>
nnoremap <silent> <SID>[unite]let :<C-u>Unite<Space>output:let<CR>
nnoremap <silent> <SID>[unite]map :<C-u>Unite<Space>output:map\|map!\|lmap<CR>
nnoremap <silent> <SID>[unite]msg :<C-u>Unite<Space>output:message<CR>
nnoremap <silent> <SID>[unite]s   :<C-u>Unite<Space>-default-action=ex<Space>output:scriptnames<CR>
" add plugins
nnoremap <silent> <SID>[unite]dic :<C-u>Unite<Space>codic<CR>
nnoremap <silent> <SID>[unite]h   :<C-u>Unite<Space>help<CR>
nnoremap <silent> <SID>[unite]hl  :<C-u>Unite<Space>highlight<CR>
" memolist
nnoremap <SID>[memolist] <Nop>
nmap <Leader>m <SID>[memolist]
nnoremap <SID>[memolist]n :<C-u>MemoNew<CR>
nnoremap <SID>[memolist]l :<C-u>MemoList<CR>

let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle) abort "{{{
    let g:unite_data_directory             = s:envHome .'/.vim/unite.vim'
    let g:unite_enable_start_insert        = 1
    let g:unite_source_grep_command        = 'grep'
    let g:unite_source_grep_default_opts   = '--color=auto -i -I'
    let g:unite_source_grep_recursive_opt  = ''
    let g:unite_source_grep_max_candidates = 200
    call unite#custom#source('help', 'ignore_pattern', 'in\ \(runtime\|vimdoc-ja\)')
endfunction "}}}
let s:hooks = neobundle#get_hooks('memolist.vim')
function! s:hooks.on_source(bundle) abort "{{{
    let g:memolist_filename_prefix_none = 1
    let g:memolist_template_dir_path    = s:envHome .'/.vim/memolist.vim'
    let g:memolist_unite                = 1
    let g:memolist_unite_option         = '-default-action=tabopen'
    let g:memolist_unite_source         = 'file_rec'
endfunction "}}}
" codec follow
nnoremap <Leader>jj         :<C-u>call<Space>kazuakim#Translate('')<Left><Left>
nnoremap <silent><Leader>jk :<C-u>call<Space>kazuakim#Translate(expand('<cword>'))<CR>
"}}}
" vim-quickrun {{{
NeoBundleLazy 'thinca/vim-quickrun', {'commands': 'QuickRun'}
nnoremap <Leader>run  :<C-u>QuickRun<CR>
nnoremap <Leader>php  :<C-u>call<Space>kazuakim#PhpCsFixer('normal')<CR>
nnoremap <Leader>phpt :<C-u>call<Space>kazuakim#PhpCsFixer('template')<CR>
nnoremap <Leader>es   :<C-u>call<Space>kazuakim#EslintFix()<CR>
" Set g:quickrun_config at .vimrc.local .
let s:quickrun_config_javascript = {
\    'command':     'eslint',
\    'cmdopt':      '--cache --cache-location '. s:envHome .'/.cache/eslint/.eslintcache --format compact --max-warnings 1 --no-color --no-ignore --quiet',
\    'errorformat': '%E%f: line %l\, col %c\, Error - %m,%W%f: line %l\, col %c\, Warning - %m,%-G%.%#',
\    'exec':        '%c %o %s:p'}
let g:quickrun_config = {
\    '_': {
\        'hook/close_buffer/enable_empty_data': 1,
\        'hook/close_buffer/enable_failure':    1,
\        'outputter':                           'multi:buffer:quickfix',
\        'outputter/buffer/close_on_empty':     1,
\        'outputter/buffer/split':              ':botright',
\        'runner':                              'vimproc',
\        'runner/vimproc/updatetime':           600},
\    'javascript': {
\        'command':     s:quickrun_config_javascript['command'],
\        'cmdopt':      s:quickrun_config_javascript['cmdopt'] .' --config '. s:envHome .'/.eslintrc.js',
\        'errorformat': s:quickrun_config_javascript['errorformat'],
\        'exec':        s:quickrun_config_javascript['exec']},
\    'javascript/watchdogs_checker': {
\        'type': 'watchdogs_checker/javascript'},
\    'php': {
\        'command':                          'phpunit',
\        'cmdopt':                           '--no-configuration',
\        'hook/close_buffer/enable_failure': 0,
\        'outputter/buffer/split':           ':botright 7sp'},
\    'php/watchdogs_checker': {
\        'type': 'watchdogs_checker/php'},
\    'sql': {
\        'type': 'sql/mysql'},
\    'sql/mysql': {
\        'exec':                  "%c %o < %s | sed -e 's/\t/|/g'",
\        'outputter':             'buffer',
\        'outputter/buffer/into': 1},
\    'watchdogs_checker/_': {
\        'hook/close_quickfix/enable_exit':        1,
\        'hook/back_window/enable_exit':           0,
\        'hook/back_window/priority_exit':         1,
\        'hook/qfstatusline_update/enable_exit':   1,
\        'hook/qfstatusline_update/priority_exit': 2,
\        'outputter/quickfix/open_cmd':            ''},
\    'watchdogs_checker/javascript': {
\        'command':     s:quickrun_config_javascript['command'],
\        'cmdopt':      s:quickrun_config_javascript['cmdopt'] .' --config '. s:envHome .'/.eslintrc.limit.js',
\        'errorformat': s:quickrun_config_javascript['errorformat'],
\        'exec':        s:quickrun_config_javascript['exec']},
\    'watchdogs_checker/php':        {
\        'command': 'php',
\        'cmdopt':  '-l -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0',
\        'exec':    '%c %o %s:p'}}
unlet s:quickrun_config_javascript
"}}}
" taglist.vim {{{
"MEMO:$ ctags --list-maps : ctags supported filetype.
"MEMO:$ ctags --list-kinds: ctags tlist setting.
NeoBundleLazy 'vim-scripts/taglist.vim', {'commands': 'Tlist'}
nnoremap <Leader>t :<C-u>Tlist<CR>
let s:hooks = neobundle#get_hooks('taglist.vim')
function! s:hooks.on_source(bundle) abort "{{{
    let g:tlist_javascript_settings = 'js;o:object;f:function'
    let g:tlist_php_settings        = 'php;c:class;f:function;d:constant'
    let g:Tlist_Exit_OnlyWindow     = 1
    let g:Tlist_Show_One_File       = 1
    let g:Tlist_Use_Right_Window    = 1
    let g:Tlist_WinWidth            = 25
endfunction "}}}
"}}}
" vim-qfreplace {{{
NeoBundleLazy 'thinca/vim-qfreplace', {'commands': 'Qfreplace'}
nnoremap <Leader>qr :<C-u>Qfreplace<CR>
"}}}
" vim-easy-align {{{
NeoBundleLazy 'junegunn/vim-easy-align', {'commands': 'EasyAlign'}
vnoremap <silent> <Leader>a :EasyAlign<CR>
let g:easy_align_delimiters = {
\    '=': {'pattern': '===\|!==\|<=>\|\(&&\|||\|<<\|>>\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.-]\?=[#?]\?', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0},
\    '>': {'pattern': '>>\|=>\|>'},
\    '?': {'pattern': '?',                     'ignore_groups': ['String'], 'left_margin': 1, 'right_margin': 1},
\    '/': {'pattern': '//\+\|/\*\|\*/',        'ignore_groups': ['String']},
\    '#': {'pattern': '#\+',                   'ignore_groups': ['String'],                                                           'delimiter_align': 'l'},
\    '$': {'pattern': '\((.*\)\@!$\(.*)\)\@!', 'ignore_groups': ['String'],                   'right_margin': 0,                      'delimiter_align': 'l'},
\    ']': {'pattern': '[[\]]',                 'ignore_groups': ['String'], 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0},
\    ')': {'pattern': '[()]',                  'ignore_groups': ['String'], 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0},
\    'd': {'pattern': '\(\S\+\s*[;=]\)\@=',    'ignore_groups': ['String'], 'left_margin': 0, 'right_margin': 0}}
"}}}
" vim-quickhl {{{
NeoBundleLazy 't9md/vim-quickhl', {'commands' : 'quickhl#manual#this'}
nnoremap <Space>m :<C-u>call<Space>quickhl#manual#this('n')<CR>
nnoremap <Space>M :<C-u>call<Space>quickhl#manual#reset()<CR>
let s:hooks = neobundle#get_hooks('vim-quickhl')
function! s:hooks.on_source(bundle) abort "{{{
    let g:quickhl_manual_colors = [
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=Blue    guibg=Blue',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Green   guibg=Green',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Cyan    guibg=Cyan',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Magenta guibg=Magenta',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Yellow  guibg=Yellow']
endfunction "}}}
"}}}
" vim-sqlfix {{{
NeoBundleLazy 'KazuakiM/vim-sqlfix', {'commands': 'Sqlfix'}
let s:hooks = neobundle#get_hooks('vim-sqlfix')
function! s:hooks.on_source(bundle) abort "{{{
    let g:sqlfix#Config = {'direcotry_path': s:envHome .'/.vim/vim-sqlfix'}
endfunction "}}}
"}}}
" previm {{{
NeoBundleLazy 'kannokanno/previm', {'functions': 'previm#open'}
nnoremap <silent> <Leader>pre :<C-u>call<Space>previm#open(previm#make_preview_file_path('index.html'))<CR>
"}}}
" vim-ref {{{
NeoBundleLazy 'thinca/vim-ref', {'functions': 'ref#K'}
let g:ref_no_default_key_mappings = 1
inoremap <silent><C-k> <C-o>:call<Space>ref#K('normal')<CR><ESC>
nnoremap <silent>K     :<C-u>call<Space>ref#K('normal')<CR>
let s:hooks = neobundle#get_hooks('vim-ref')
function! s:hooks.on_source(bundle) abort "{{{
    let g:ref_cache_dir       = s:envHome .'/.vim/vim-ref/cache'
    let g:ref_detect_filetype = {'html': 'phpmanual', 'javascript': 'phpmanual', 'css': 'phpmanual'}
    let g:ref_phpmanual_path  = s:envHome .'/.vim/vim-ref/php-chunked-xhtml'
endfunction "}}}
"}}}
" open-browser.vim {{{
NeoBundleLazy 'tyru/open-browser.vim', {'functions': 'openbrowser#_keymapping_smart_search'}
nnoremap <Leader>gx :<C-u>call<Space>openbrowser#_keymapping_smart_search('n')<CR>
"}}}
" neosnippet-snippets
" neosnippet.vim
" neoinclude.vim
" neocomplete.vim {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {'depends': ['KazuakiM/neosnippet-snippets', 'Shougo/neosnippet.vim', 'Shougo/neoinclude.vim'], 'insert': 1}
imap <silent><expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <silent><expr><TAB>                           neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
nmap <silent><expr><TAB>                                                                   <Plug>(neosnippet_expand_or_jump)
imap <silent><expr><CR>  pumvisible() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle) abort "{{{
    "neocomplete.vim
    autocmd MyAutoCmd FileType html       setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd MyAutoCmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
    let g:neocomplete#auto_completion_start_length = 3
    let g:neocomplete#data_directory               = s:envHome .'/.vim/neocomplete.vim'
    let g:neocomplete#delimiter_patterns           = {
    \    'javascript': ['.'],
    \    'php':        ['->', '::', '\'],
    \    'ruby':       ['::']}
    let g:neocomplete#enable_at_startup         = 1
    let g:neocomplete#enable_auto_close_preview = 1
    let g:neocomplete#enable_auto_delimiter     = 1
    let g:neocomplete#enable_auto_select        = 0
    let g:neocomplete#enable_fuzzy_completion   = 0
    let g:neocomplete#enable_smart_case         = 1
    let g:neocomplete#fallback_mappings         = ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]
    let g:neocomplete#keyword_patterns          = {'_': '\h\w*'}
    let g:neocomplete#lock_buffer_name_pattern  = '\.log\|.*quickrun.*\|.jax'
    let g:neocomplete#max_keyword_width         = 30
    let g:neocomplete#max_list                  = 8
    let g:neocomplete#min_keyword_length        = 3
    let g:neocomplete#sources                   = {
    \    '_':          ['neosnippet', 'file', 'buffer'],
    \    'html':       ['neosnippet', 'file', 'omni',       'buffer'],
    \    'javascript': ['neosnippet', 'file', 'omni',       'buffer'],
    \    'php':        ['neosnippet', 'file', 'dictionary', 'omni',    'buffer']}
    let g:neocomplete#sources#buffer#cache_limit_size  = 50000
    let g:neocomplete#sources#buffer#disabled_pattern  = '\.log\|\.jax'
    let g:neocomplete#sources#buffer#max_keyword_width = 30
    let g:neocomplete#sources#dictionary#dictionaries  = {
    \    '_':   '',
    \    'php': s:envHome . '/.vim/dict/php.dict'}
    let g:neocomplete#use_vimproc = 1

    "neoinclude.vim
    let g:neoinclude#exts          = {'php': ['php', 'inc', 'tpl']}
    let g:neoinclude#max_processes = 5

    "neosnippet.vim
    let g:neosnippet#data_directory                = s:envHome . '/.vim/neosnippet.vim'
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#disable_runtime_snippets      = {'_' : 1}
    let g:neosnippet#snippets_directory            = s:envHome . '/.vim/bundle/neosnippet-snippets/neosnippets'
endfunction "}}}
"}}}
" gundo.vim {{{
NeoBundleLazy 'sjl/gundo.vim', {'insert': 1}
nnoremap cu :<C-u>call<Space>kazuakim#ClearUndo()<CR>
let s:hooks = neobundle#get_hooks('gundo.vim')
function! s:hooks.on_source(bundle) abort "{{{
    nnoremap u g-
    nnoremap U g-
    nnoremap <C-r> g+
endfunction "}}}
"}}}
" shabadou.vim
" vim-watchdogs {{{
NeoBundleLazy 'osyo-manga/vim-watchdogs', {'depends': 'osyo-manga/shabadou.vim', 'insert': 1}
let s:hooks = neobundle#get_hooks('vim-watchdogs')
function! s:hooks.on_source(bundle) abort "{{{
    "vim-watchdogs
    let g:watchdogs_check_BufWritePost_enable  = 1
    let g:watchdogs_check_BufWritePost_enables = {'vim': 0}
    let g:watchdogs_check_CursorHold_enable    = 1
    let g:watchdogs_check_CursorHold_enables   = {'vim': 0}
endfunction "}}}
unlet s:hooks
"}}}
" emmet-vim {{{
"
" MEMO
" * URL: http://docs.emmet.io/cheat-sheet/
" * <C+y>,  :execute trigger key
" * html:5  && <C+y>,
" * div>ul>li.class#id_$$*5  && <C+y>,
NeoBundleLazy 'mattn/emmet-vim', {'filetypes': ['html', 'php']}
let s:hooks = neobundle#get_hooks('emmet-vim')
function! s:hooks.on_source(bundle)
    let g:use_emmet_complete_tag = 1
    let g:user_emmet_settings    = {
    \    'variables': {'lang': 'ja', 'default_attributes': {
    \        'a': {'href': ''}, 'link': [{'rel': 'stylesheet'}, {'href': ''}]}},
    \    'html': {'filters': 'html', 'indentation': '    '},
    \    'php' : {'extends': 'html', 'filters':     'html,c'}}
    let g:user_emmet_mode        = 'a'
    "let g:user_emmet_leader_key = ''
endfunction
"}}}
" vim-css3-syntax {{{
NeoBundleLazy 'hail2u/vim-css3-syntax', {'filetypes': ['html', 'php', 'css']}
"}}}
" vim-javascript {{{
NeoBundleLazy 'pangloss/vim-javascript', {'filetypes': ['html', 'php', 'javascript']}
"}}}
" vim-markdown {{{
NeoBundleLazy 'plasticboy/vim-markdown', {'filetypes': 'markdown'}
let g:vim_markdown_folding_disabled = 1
"}}}
"}}}
"
"
" Exclusive {{{
if s:osType !=# 'macunix'
    " vim-php-cs-fixer {{{
    let g:php_cs_fixer_path = s:envHome .'/.vim/vim-php-cs-fixer/php-cs-fixer'
    "}}}
endif

if s:osType !=# 'win'
    " memolist.vim {{{
    let g:memolist_path = s:envHome .'/.vim/memolist.vim'
    "}}}
    " neoinclude.vim {{{
    let g:neoinclude#delimiters = '\'
    "}}}
endif

if s:osType !=# 'unix'
endif
"}}}
"
"
" Only {{{
if s:osType ==# 'macunix'
    " previm {{{
    let g:previm_open_cmd = 'open -a "Google Chrome"'
    "}}}
    " vim-php-cs-fixer {{{
    let g:php_cs_fixer_path = '/usr/local/bin/php-cs-fixer'
    "}}}

elseif s:osType ==# 'win'
    " vimproc.vim {{{
    let g:vimproc#dll_path = 'C:\usr\local\bin\Vim\plugins\vimproc\lib\vimproc_win64.dll'
    "}}}
    " previm {{{
    let g:previm_open_cmd = 'C:/Program\ Files\ (x86)/Google/Chrome/Application/chrome.exe'
    "}}}
    " memolist.vim {{{
    let g:memolist_path = '/cygwin64/home/kazuakim/.vim/memolist.vim'
    "}}}
    " neoinclude.vim {{{
    let g:neoinclude#delimiters = '/'
    "}}}

elseif s:osType ==# 'unix'
endif
"}}}
"
"
" NeoBundleFetch {{{
NeoBundleFetch 'psychs/lingr-irc'
NeoBundleFetch 'KazuakiM/vim-snippets'
NeoBundleFetch 'KazuakiM/vim-qfsigns'
NeoBundleFetch 'KazuakiM/vim-regexper'
NeoBundleFetch 'Kuniwak/vint'
NeoBundleFetch 'thinca/vim-themis'
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
autocmd MyAutoCmd BufNewFile,BufRead *.coffee    setlocal filetype=coffee
autocmd MyAutoCmd BufNewFile,BufRead *.{snip*}   setlocal filetype=snippets
autocmd MyAutoCmd BufNewFile,BufRead *.{vim*}    setlocal filetype=vim
autocmd MyAutoCmd BufNewFile,BufRead *.{bin,exe} setlocal filetype=xxd
autocmd MyAutoCmd FileType html,js,php,xml syntax sync minlines=2000
"}}}
"
"
" Function {{{
nnoremap <F1> :<C-u>call<Space>kazuakim#DatabaseSwitch()<CR>
set pastetoggle=<F2>
nnoremap <F3> :<C-u>edit++enc=utf-8<CR>
"}}}
"
"
" Other setting files {{{
" Environment setting file
if s:osType ==# 'win'
    source ~/.vimrc.win
else
    source ~/.vimrc.local
endif
"}}}

