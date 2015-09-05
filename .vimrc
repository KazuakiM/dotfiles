"
"
" Memo {{{
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
"+----+-------------------+---------------------------------------------+ }}}
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
"+-----------+-----------+---------+------------+--------+--------+--------+------------------+--------+--------------+----------+ }}}
"}}}
"
"
" Variables {{{
let s:envHome = ! exists('s:envHome') ? $HOME                                 : s:envHome
let s:date    = ! exists('s:date')    ? strftime('%Y%m%d%H%M%S', localtime()) : s:date
"}}}
"
"
" Common {{{
set encoding=utf-8 fileencoding=utf-8 fileformats=unix,dos,mac
scriptencoding utf-8
let g:mapleader = ','
augroup MyAutoCmd
    autocmd!
augroup END

" Zun wiki http://www.kawaz.jp/pukiwiki/?vim#cb691f26 {{{
if &encoding !=# 'utf-8'
    set encoding=japan fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings          = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings          = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932 fileencodings-=euc-jp fileencodings-=euc-jisx0213 fileencodings-=eucjp-ms
            let &encoding     = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    unlet s:enc_euc
    unlet s:enc_jis
endif
"}}}

function! s:KazuakiMMinimal() abort "{{{
    setlocal noswapfile nobackup nowritebackup noundofile viminfo=
    filetype off
    filetype plugin indent off
    syntax off
endfunction "}}}

function! s:KazuakiMAutoMkdir(dir) abort "{{{
    if !isdirectory(a:dir)
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction "}}}

function! s:KazuakiMVimStart(backupDir, undoDir) abort "{{{
    "Check 256KB file size.
    if getfsize(expand('%:p')) >= 262144
        call s:KazuakiMMinimal()
        return 1
    endif
    call s:KazuakiMAutoMkdir(a:backupDir.s:date)
    call s:KazuakiMAutoMkdir(a:undoDir.  s:date)
    let &backupdir = a:backupDir.s:date
    let &undodir   = a:undoDir.  s:date
    return 0
endfunction "}}}

if has('vim_starting')
    "Check $HOME
    if s:envHome is# '/' || s:envHome is# 'C:\'
        call s:KazuakiMMinimal()
        echohl ErrorMsg
            echomsg '[WARNING]Would you check $HOME?'
        echohl None
        finish
    endif

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
    unlet s:date
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif

function! s:KazuakiMCheckString() abort "{{{
    let w:m1 = matchadd('KazuakiMCheckString', '\t\|\r\|\r\n\|\s\+$\|　')
    let w:m2 = matchadd('KazuakiMTodo',        'FIXME\|MEMO\|NOTE\|TODO\|XXX')
endfunction "}}}

function! s:KazuakiMBufEnter() abort "{{{
    " Auto close VimDiff or primary NERDTree
    if winnr('$') is# 1 && (&l:diff || (exists('b:NERDTreeType') && b:NERDTreeType ==# 'primary'))
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
        setlocal filetype=mkd.markdown
    endif

    " Forcibly update
    set ambiwidth=double formatoptions-=c formatoptions-=b formatoptions-=t formatoptions-=v textwidth=0

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

function! s:KazuakiMQuickfixCmdPost() abort "{{{
    " qfixgrep {{{
    let g:QFix_PreviewEnable = 1
    "}}}
endfunction "}}}

function! s:KazuakiMVimEnter() abort "{{{
    call s:KazuakiMCheckString()
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
autocmd MyAutoCmd QuickfixCmdPost      * call s:KazuakiMQuickfixCmdPost()
autocmd MyAutoCmd VimEnter             * call s:KazuakiMVimEnter()
autocmd MyAutoCmd WinEnter             * call s:KazuakiMWinEnter()

function! KazuakiMStatuslineSyntax() abort "{{{
    return qfstatusline#Update()
endfunction "}}}

function! KazuakiMStatuslinePaste() abort "{{{
    if &paste is# 1
        return '(paste)'
    endif
    return ''
endfunction "}}}

" Basic
set autoindent autoread backspace=indent,eol,start backup clipboard+=autoselect,unnamed cmdheight=1 completeopt=longest,menu diffopt=filler,context:5,iwhite,vertical
set display=lastline expandtab fillchars+=diff:* foldmethod=marker grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m helplang=ja hidden history=1000 hlsearch ignorecase
set iminsert=0 imsearch=-1 incsearch laststatus=2 lazyredraw matchpairs+=<:> matchtime=1 mouse= nobomb noequalalways noerrorbells nogdefault noimcmdline noimdisable
set noruler noswapfile number pumheight=8 scrolloff=999 shiftwidth=4 shortmess+=I showcmd showmatch smartcase smartindent smarttab softtabstop=4 tabstop=4 title
set titleold= titlestring=%F ttyfast t_vb= undofile updatecount=30 updatetime=1000 viminfo='10,/100,:100,@100,c,f1,h,<100,s100,n~/.vim/viminfo/.viminfo
set virtualedit+=block visualbell wildmenu wildmode=longest:full,full wrap wrapscan
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude='*.json'\ --exclude='*.log'\ --exclude='*min.js'\ --exclude='*min.css'
set wildignore+=*.bmp,*.gif,*.git,*.ico,*.jpeg,*.jpg,*.log,*.mp3,*.ogg,*.otf,*.pdf,*.png,*.qpf2,*.svn,*.ttf,*.wav,C,.DS_Store,.,..
set statusline=\ %t\ %m\ %r\ %h\ %w\ %q\ %{KazuakiMStatuslineSyntax()}%=\ %{KazuakiMStatuslinePaste()}\ \|\ %Y\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ 
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
let g:loaded_2html_plugin     = 1 "$VIMRUNTIME/plugin/tohtml.vim
let g:loaded_getscriptPlugin  = 1 "$VIMRUNTIME/plugin/getscriptPlugin.vim
let g:loaded_gzip             = 1 "$VIMRUNTIME/plugin/gzip.vim
let g:loaded_matchparen       = 1 "$VIMRUNTIME/plugin/matchparen.vim
let g:loaded_netrwPlugin      = 1 "$VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_spellfile_plugin = 1 "$VIMRUNTIME/plugin/spellfile.vim
let g:loaded_sql_completion   = 1 "$VIMRUNTIME/autoload/sqlcomplete.vim
let g:loaded_tarPlugin        = 1 "$VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_vimballPlugin    = 1 "$VIMRUNTIME/plugin/vimballPlugin.vim
let g:loaded_zipPlugin        = 1 "$VIMRUNTIME/plugin/zipPlugin.vim
let g:vimsyn_embed            = 1 "$VIMRUNTIME/syntax/vim.vim
" Vim
nnoremap <SID>[vim] <Nop>
nmap <Leader>f <SID>[vim]
nnoremap <SID>[vim]e :<C-u>tabnew<Space>$MYVIMRC<CR>
nnoremap <SID>[vim]s :<C-u>tabnew<Space>$HOME/.vim/vim-sqlfix/sqlfix.sql<CR>
nnoremap <SID>[vim]h :<C-u>source<Space>$VIMRUNTIME/syntax/colortest.vim<CR>
nnoremap <SID>[vim]c :<C-u>IndentLinesEnable<CR>
"}}}
"
"
" Vim / gVim {{{
if !has('gui_running')

    " http://d.hatena.ne.jp/thinca/20111204/1322932585
    function! s:KazuakiMTabpageLabelUpdate(tabNumber) abort "{{{
        let l:highlight = a:tabNumber is# tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
        let l:bufnrs    = tabpagebuflist(a:tabNumber)
        let l:bufnr     = len(l:bufnrs)
        if l:bufnr is# 1
            let l:bufnr = ''
        endif
        let l:modified = len(filter(copy(l:bufnrs), 'getbufvar(v:val, "&modified")')) ? '[+]' : ''
        return '%'. a:tabNumber .'T'. l:highlight . l:bufnr .' '. fnamemodify(bufname(l:bufnrs[tabpagewinnr(a:tabNumber) - 1]), ':t') .' '. l:modified.
        \    '%T%#TabLineFill#'
    endfunction "}}}

    function! KazuakiMTabLineUpdate() abort "{{{
        return join(map(range(1, tabpagenr('$')), 's:KazuakiMTabpageLabelUpdate(v:val)'), '|'). '%#TabLineFill#%T%='
    endfunction "}}}

    set tabline=%!KazuakiMTabLineUpdate()
endif
"}}}
"
"
" NeoBundle START {{{
call neobundle#begin(expand('$HOME/.vim/bundle/'))
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
    NeoBundle 'SirVer/ultisnips'
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
nnoremap <expr><Leader>grek ':grep! '. expand('<cword>') .' '. KazuakiMPath2ProjectDirectory('%') .'<C-b><Right><Right><Right><Right><Right><Right>'
nnoremap <expr><Leader>grel ':grep!  '. KazuakiMPath2ProjectDirectory('%') .'<C-b><Right><Right><Right><Right><Right><Right>'
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
" ultisnips {{{
let g:did_UltiSnips_snipmate_compatibility = 1
let g:UltiSnipsEditSplit                   = 'vertical'
let g:UltiSnipsExpandTrigger               = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger         = '<S-TAB>'
let g:UltiSnipsJumpForwardTrigger          = '<TAB>'
let g:UltiSnipsSnippetsDir                 = s:envHome .'/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsUsePythonVersion            = 2
"}}}
" vital.vim {{{
function! KazuakiMPath2ProjectDirectory(path) abort "{{{
    let s:Prelude = ! exists('s:Prelude') ? vital#of('vital').import('Prelude') : s:Prelude
    return s:Prelude.path2project_directory(a:path)
endfunction "}}}
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
nnoremap <expr><SID>[nerdtree]n ':NERDTree '. KazuakiMPath2ProjectDirectory('%') .'<CR>'
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
"MEMO:Unite for Windows check at Reading vimrc 2015-08-15!!!
"call unite#custom#substitute('files', '[^~.* ]\ze/', '\0', -100)
"call unite#custom#substitute('files', '/\ze[^~.* ]', '/', -100)
NeoBundleLazy 'Shougo/unite.vim',           { 'commands': 'Unite'}
NeoBundleLazy 'Shougo/unite-help',          { 'depends':  'Shougo/unite.vim', 'unite_sources':     'help'}
NeoBundleLazy 'rhysd/unite-codic.vim',      { 'depends':  ['koron/codic-vim', 'Shougo/unite.vim'], 'unite_sources': 'codic'}
NeoBundleLazy 'osyo-manga/unite-highlight', { 'depends':  'Shougo/unite.vim', 'unite_sources':     'highlight'}
NeoBundleLazy 'glidenote/memolist.vim',     { 'commands': ['MemoNew',         'MemoList']}
nnoremap <SID>[unite] <Nop>
nmap <Leader>u <SID>[unite]
" default plugins
nnoremap <silent> <SID>[unite]au  :<C-u>Unite<Space>output:autocmd<CR>
nnoremap <silent> <SID>[unite]f   :<C-u>call<Space>KazuakiMUniteFileRecAsyncOrGit()<CR>
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

" http://qiita.com/yuku_t/items/9263e6d9105ba972aea8
function! KazuakiMUniteFileRecAsyncOrGit() abort "{{{
    if isdirectory(getcwd().'/.git')
        Unite -default-action=tabopen file_rec/git
    else
        Unite -default-action=tabopen file_rec/async:!
    endif
endfunction "}}}

let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle) abort "{{{
    let g:unite_data_directory             = s:envHome .'/.vim/unite.vim'
    let g:unite_enable_start_insert        = 1
    let g:unite_source_grep_command        = 'grep'
    let g:unite_source_grep_default_opts   = '--color=auto -i -I'
    let g:unite_source_grep_recursive_opt  = ''
    let g:unite_source_grep_max_candidates = 200
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
nnoremap <Leader>jj         :<C-u>call<Space>KazuakiMTranslate('')<Left><Left>
nnoremap <silent><Leader>jk :<C-u>call<Space>KazuakiMTranslate(expand('<cword>'))<CR>
function! KazuakiMTranslate(text) abort "{{{
    let s:HTTP = ! exists('s:HTTP') ? vital#of('vital').import('Web.HTTP') : s:HTTP
    let s:JSON = ! exists('s:JSON') ? vital#of('vital').import('Web.JSON') : s:JSON
    if match(a:text, '\w') is# -1
        let l:options = {'sl': 'ja', 'tl': 'en'}
    else
        let l:options = {'sl': 'en', 'tl': 'ja'}
    endif
    let l:response = s:HTTP.post('http://translate.google.com/translate_a/t',
    \    extend({'client': '0', 'q': a:text}, l:options),
    \    {'User-Agent': 'Mozilla/5.0'})
    if l:response.status is# 200
        " qfixgrep {{{
        let g:QFix_PreviewEnable = 0
        "}}}
        cgetexpr PrettyPrint(s:JSON.decode(l:response.content))
        copen
    endif
endfunction "}}}
"}}}
" vim-quickrun {{{
NeoBundleLazy 'thinca/vim-quickrun', {'commands': 'QuickRun'}
nnoremap <Leader>run :<C-u>QuickRun<CR>
" Set g:quickrun_config at .vimrc.local .
let g:quickrun_config = {
\    '_': {
\        'hook/close_buffer/enable_empty_data': 1,    'hook/close_buffer/enable_failure': 1,           'outputter': 'multi:buffer:quickfix',
\        'outputter/buffer/close_on_empty':     1,    'outputter/buffer/split':           ':botright', 'runner':    'vimproc',
\        'runner/vimproc/updatetime':           600},
\    'php': {'command': 'phpunit', 'cmdopt': '--no-configuration', 'hook/close_buffer/enable_failure': 0, 'outputter/buffer/split': ':botright 7sp'},
\    'sql': {'type': 'sql/mysql'},
\    'sql/mysql': {'exec': "%c %o < %s | sed -e 's/\t/|/g'", 'outputter': 'buffer', 'outputter/buffer/into': 1},
\    'watchdogs_checker/_': {
\        'hook/close_quickfix/enable_exit':      1, 'hook/back_window/enable_exit':           0, 'hook/back_window/priority_exit': 1,
\        'hook/qfstatusline_update/enable_exit': 1, 'hook/qfstatusline_update/priority_exit': 2, 'outputter/quickfix/open_cmd':    ''},
\    'watchdogs_checker/php': {
\        'command': 'php',        'cmdopt':      '-l -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0',
\        'exec':    '%c %o %s:p', 'errorformat': '%m\ in\ %f\ on\ line\ %l'}}
"}}}
" taglist.vim {{{
"MEMO:$ ctags --list-maps : ctags supported filetype.
"MEMO:$ ctags --list-kinds: ctags tlist setting.
NeoBundleLazy 'vim-scripts/taglist.vim', {'commands': 'Tlist'}
nnoremap <Leader>t :<C-u>Tlist<CR>
let s:hooks = neobundle#get_hooks('taglist.vim')
function! s:hooks.on_source(bundle) abort "{{{
    let s:tlist_go_settings      = 'go;g:enum;s:struct;u:union;f:function;t:type;v:variable'
    let g:tlist_php_settings     = 'php;c:class;f:function;d:constant'
    let g:Tlist_Exit_OnlyWindow  = 1
    let g:Tlist_Show_One_File    = 1
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_WinWidth         = 25
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
NeoBundleLazy 'kannokanno/previm', {'commands': 'PrevimOpen'}
nnoremap <silent> <Leader>pre :<C-u>PrevimOpen<CR>
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
" vim-php-cs-fixer {{{
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {'functions': 'PhpCsFixerFixFile'}
nnoremap <Leader>php :<C-u>call<Space>PhpCsFixerFixFile()<CR>
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle) abort "{{{
    let g:php_cs_fixer_config                 = 'default'
    let g:php_cs_fixer_dry_run                = 0
    let g:php_cs_fixer_enable_default_mapping = 0
    let g:php_cs_fixer_fixers_list            = 'align_equals,align_double_arrow,-braces'
    let g:php_cs_fixer_level                  = 'symfony'
    let g:php_cs_fixer_php_path               = 'php'
    let g:php_cs_fixer_verbose                = 0
endfunction "}}}
"}}}
" open-browser.vim {{{
NeoBundleLazy 'tyru/open-browser.vim', {'functions': 'openbrowser#_keymapping_smart_search'}
nnoremap <Leader>gx :<C-u>call<Space>openbrowser#_keymapping_smart_search('n')<CR>
"}}}
" vim-snippets
" neoinclude.vim
" neocomplete.vim {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {'depends': ['KazuakiM/vim-snippets', 'Shougo/neoinclude.vim'], 'insert': 1}
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle) abort "{{{
    "neocomplete.vim
    let g:neocomplete#auto_completion_start_length     = 3
    let g:neocomplete#data_directory                   = s:envHome .'/.vim/neocomplete.vim'
    let g:neocomplete#delimiter_patterns               = {'php': ['->', '::', '\']}
    let g:neocomplete#enable_at_startup                = 1
    let g:neocomplete#enable_auto_close_preview        = 3
    let g:neocomplete#enable_auto_delimiter            = 1
    let g:neocomplete#enable_auto_select               = 0
    let g:neocomplete#enable_fuzzy_completion          = 0
    let g:neocomplete#enable_smart_case                = 1
    let g:neocomplete#keyword_patterns                 = {'_': '\h\w*'}
    let g:neocomplete#lock_buffer_name_pattern         = '\.log\|.*quickrun.*\|.jax'
    let g:neocomplete#max_keyword_width                = 30
    let g:neocomplete#max_list                         = 8
    let g:neocomplete#min_keyword_length               = 3
    let g:neocomplete#sources                          = {'_': ['ultisnips', 'file', 'dictionary', 'buffer'], 'go': ['ultisnips', 'file', 'omni', 'buffer']}
    let g:neocomplete#sources#buffer#cache_limit_size  = 50000
    let g:neocomplete#sources#buffer#disabled_pattern  = '\.log\|\.jax'
    let g:neocomplete#sources#buffer#max_keyword_width = 30
    let g:neocomplete#sources#dictionary#dictionaries  = {'_': '', 'php': s:envHome .'/.vim/dict/php.dict'}
    let g:neocomplete#sources#omni#input_patterns      = {'go': '\h\w\.\w*'}
    let g:neocomplete#use_vimproc                      = 1

    "neoinclude.vim
    let g:neoinclude#exts          = {'php': ['php', 'inc', 'tpl']}
    let g:neoinclude#max_processes = 5
endfunction "}}}
"}}}
" gundo.vim {{{
NeoBundleLazy 'sjl/gundo.vim', {'insert': 1}
let s:hooks = neobundle#get_hooks('gundo.vim')
function! s:hooks.on_source(bundle) abort "{{{
    nnoremap u g-
    nnoremap U :<C-u>GundoToggle<CR>
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
" vim-markdown {{{
NeoBundleLazy 'plasticboy/vim-markdown', {'filetypes': 'mkd'}
let g:vim_markdown_folding_disabled = 1
"}}}
" vim-go-extra {{{
NeoBundleLazy 'vim-jp/vim-go-extra', {'filetypes': 'go'}
"}}}
"" vim-over {{{
"NeoBundleLazy 'osyo-manga/vim-over', {'commands': 'OverCommandLine'}
"nnoremap <expr><Leader>%s  ':OverCommandLine<CR>%s/'.expand('<cword>').'/'.expand('<cword>').'/gc<Left><Left><Left>'
"nnoremap <expr><Leader>%%s ':OverCommandLine<CR>%s/'.expand('<cword>').'//gc<Left><Left><Left>'
"let s:hooks = neobundle#get_hooks('vim-over')
"function! s:hooks.on_source(bundle) abort "{{{
"    let g:over#command_line#substitute#highlight_string = 'SpellCap'
"endfunction "}}}
""}}}
"" incsearch.vim {{{
"NeoBundleLazy 'haya14busa/incsearch.vim', {'mappings': '<Plug>(incsearch-forward)'}
"nmap / <Plug>(incsearch-forward)
""}}}
nnoremap <expr><Leader>%s  ':%s/'. expand('<cword>') .'/'. expand('<cword>') .'/gc<Left><Left><Left>'
nnoremap <expr><Leader>%%s ':%s/'. expand('<cword>') .'//gc<Left><Left><Left>'
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
    let g:vimproc#dll_path = 'C:\usr\local\bin\Vim\plugins\vimproc\autoload\vimproc_win64.dll'
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
"}}}
"
"
" NeoBundleFetch {{{
NeoBundleFetch 'psychs/lingr-irc'
NeoBundleFetch 'KazuakiM/neosnippet-snippets'
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
"}}}
"
"
" Function {{{
nnoremap <F1> :<C-u>call<Space>KazuakiMDatabaseSwitch()<CR>
set pastetoggle=<F2>

" Database Switch (.vimrc.local)
function! KazuakiMDatabaseSwitch() abort "{{{
    let b:databaseIndex = ! exists('b:databaseIndex') ? 0 : b:databaseIndex + 1
    if len(g:KazuakiMDatabase) <= b:databaseIndex
        let b:databaseIndex = 0
    endif
    let g:quickrun_config['sql/mysql']['cmdopt'] = g:KazuakiMDatabase[b:databaseIndex]
    echo g:KazuakiMDatabase[b:databaseIndex]
endfunction "}}}

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

