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

" Variables {{{
let s:envHome      = ! exists('s:envHome')      ? $HOME                                 : s:envHome
let s:envUser      = ! exists('s:envUser')      ? $USER                                 : s:envUser
let s:date         = ! exists('s:date')         ? strftime('%Y%m%d%H%M%S', localtime()) : s:date
let s:lineUpdate   = ! exists('s:lineUpdate')   ? 0                                     : s:lineUpdate
let s:swapFilePath = ! exists('s:swapFilePath') ? ''                                    : s:swapFilePath
let s:deinDir      = ! exists('s:deinDir')      ? s:envHome . '/.vim/dein.vim'          : s:deinDir
"}}}

" Common {{{
" encoding
set encoding=utf-8 fileencoding=utf-8 fileformats=unix,dos,mac
if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    set fileencodings=ucs-bom,utf-8,default,eucjp-ms,latin1,iso-2022-jp-3,cp932
elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    set fileencodings=ucs-bom,utf-8,default,euc-jisx0213,latin1,iso-2022-jp-3,cp932
else
    set fileencodings=ucs-bom,utf-8,default,euc-jp,latin1,iso-2022-jp,cp932
endif
scriptencoding utf-8

let g:mapleader = ','
augroup MyAutoCmd
    autocmd!
augroup END

function! s:AutoMkdir(dir) abort "{{{
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction "}}}

function! s:VimStart(backupDir, undoDir) abort "{{{
    "Check 256KB file size.
    if 262144 <= getfsize(expand('%:p'))
        call kazuakim#Minimal()
        return 1
    endif
    call s:AutoMkdir(a:backupDir.s:envUser.'_'.s:date)
    call s:AutoMkdir(a:undoDir.  s:envUser.'_'.s:date)
    let &backupdir = a:backupDir.s:envUser.'_'.s:date
    let &undodir   = a:undoDir.  s:envUser.'_'.s:date
    return 0
endfunction "}}}

if has('vim_starting')
    if has('win32') || has ('win64')
        set runtimepath^=$HOME\.vim runtimepath+=$HOME\.vim\after
        if s:VimStart('C:\temp\backup\', 'C:\temp\undo\')
            finish
        endif
        let s:osType = 'win'
        " vimproc.vim {{{
        let g:vimproc#dll_path             = s:deinDir . '/repos/github.com/Shougo/vimproc.vim/lib/vimproc_win64.dll'
        let g:vimproc#download_windows_dll = 1
        "}}}
    elseif has('macunix')
        if s:VimStart('/tmp/backup/', '/tmp/undo/')
            finish
        endif
        let s:osType = 'macunix'
    else
        if s:VimStart('/tmp/backup/', '/tmp/undo/')
            finish
        endif
        let s:osType = 'unix'
    endif
endif

function! s:CheckString() abort "{{{
    let w:m1 = matchadd('KazuakiMCheckString', '\t\|\r\|\r\n\|\s\+$\|　')
    let w:m2 = matchadd('KazuakiMTodo',        'FIXME\|MEMO\|NOTE\|TODO\|XXX')
endfunction "}}}

function! s:BufEnter() abort "{{{
    " Auto close VimDiff or primary NERDTree
    if winnr('$') is# 1 && (&l:diff || (exists('b:NERDTree') && b:NERDTree.isTabTree()) || &filetype is# 'quickrun')
        quit

    " Duplicate ban
    elseif v:servername is# 'GVIM1'
        setlocal noswapfile viminfo=
        call remote_send('GVIM', '<ESC>:tabnew '.expand('%:p').'<CR>')
        call remote_foreground('GVIM')
        quit
    elseif v:servername is# 'VIM1'
        setlocal noswapfile viminfo=
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

function! s:BufReadPost() abort "{{{
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

function! s:InsertLeave() abort "{{{
    set nopaste
    if &l:diff
        diffupdate
    endif
endfunction "}}}

function! s:VimEnter() abort "{{{
    " Forcibly update
    set ambiwidth=double showtabline=2
    call s:CheckString()

    if &l:diff
        wincmd h
    endif

    if 0 < len(s:swapFilePath)
        call delete(s:swapFilePath)
        let s:swapFilePath = ''
    endif
endfunction "}}}

function! s:WinEnter() abort "{{{
    checktime
    call s:CheckString()
endfunction "}}}

autocmd MyAutoCmd BufEnter             * call s:BufEnter()
autocmd MyAutoCmd BufReadPost          * call s:BufReadPost()
autocmd MyAutoCmd CmdwinEnter          * nmap <silent> <ESC><ESC> :quit<CR>
autocmd MyAutoCmd CmdwinLeave          * nunmap <ESC><ESC>
autocmd MyAutoCmd FocusGained          * checktime
autocmd MyAutoCmd SwapExists           * let s:swapFilePath = v:swapname
autocmd MyAutoCmd InsertLeave          * call s:InsertLeave()
autocmd MyAutoCmd QuickfixCmdPost *grep* cwindow
autocmd MyAutoCmd QuickfixCmdPost      * call kazuakim#QuickfixCmdPost()
autocmd MyAutoCmd VimEnter             * call s:VimEnter()
autocmd MyAutoCmd WinEnter             * call s:WinEnter()

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
function! s:TabpageLabelUpdate(tabNumber) abort "{{{
    let l:highlight = a:tabNumber is# tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let l:bufnrs    = tabpagebuflist(a:tabNumber)
    let l:bufnr     = len(l:bufnrs)
    if l:bufnr is# 1
        let l:bufnr = ''
    endif
    let l:modified = len(filter(copy(l:bufnrs), 'getbufvar(v:val, "&modified")')) ? '[+]' : ''
    return '%' . a:tabNumber . 'T' . l:highlight . l:bufnr . ' ' . fnamemodify(bufname(l:bufnrs[tabpagewinnr(a:tabNumber) - 1]), ':t') . ' ' . l:modified . '%T%#TabLineFill#'
endfunction "}}}

function! KazuakiMTabLineUpdate() abort "{{{
    return join(map(range(1, tabpagenr('$')), 's:TabpageLabelUpdate(v:val)'), '|') . '%#TabLineFill#%T%=%#TabLineSel# ' . getcwd() . ' '
endfunction "}}}

" Basic
set autoindent autoread
set backspace=indent,eol,start backup belloff=all
set clipboard+=autoselect,unnamed cmdheight=1 concealcursor=i conceallevel=2 completeopt=longest,menu
set diffopt=filler,context:5,iwhite,horizontal directory=$HOME/.vim/swap display=lastline
set expandtab
set fillchars+=diff:* foldmethod=marker
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m guioptions+=M
set helplang=ja hidden history=1000 hlsearch
set ignorecase iminsert=0 imsearch=-1 incsearch
set laststatus=2 nolazyredraw
set matchpairs+=<:> matchtime=1 mouse=
set nobomb noequalalways nofixendofline nogdefault noimcmdline noimdisable noruler notitle nowrap number
set pumheight=8
set scrolloff=999 shellslash shiftwidth=4 shortmess+=a shortmess+=I showcmd showmatch smartcase smartindent smarttab softtabstop=4 swapfile switchbuf=usetab
set synmaxcol=300
set tabline=%!KazuakiMTabLineUpdate() tabstop=4 titleold= ttyfast t_vb=
set undofile updatecount=30 updatetime=1000
set viminfo='10,/100,:100,@100,c,f1,h,<100,s100,n~/.vim/viminfo/.viminfo virtualedit+=block
set wildmenu wildmode=longest:full,full wrapscan
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude='*.log'\ --exclude='*min.js'\ --exclude='*min.css'
set wildignore+=*.bmp,*.gif,*.git,*.ico,*.jpeg,*.jpg,*.log,*.mp3,*.ogg,*.otf,*.pdf,*.png,*.qpf2,*.svn,*.ttf,*.wav,C,.DS_Store,.,..
set statusline=\ %t\ %{KazuakiMStatuslinePaste()}\ %m\ %r\ %h\ %w\ %q\ %{KazuakiMStatuslineSyntax()}%=%l/%L\ \|\ %Y\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ 
let &runtimepath = &runtimepath . ',' . s:deinDir . '/repos/github.com/Shougo/dein.vim'
if &l:diff
    set cursorline
else
    set nocursorline
endif
"set foldopen-=search
"helptags $HOME/.vim/dein.vim/repos/github.com/vim-jp/vimdoc-ja/doc
" Color
colorscheme kazuakim
" Mapping
"  ESC
inoremap jk <Esc>
inoremap kj <Esc>
"  Visual
xnoremap Y y`>
"  Fold
nnoremap zx :foldopen<CR>
"  Line
noremap 0 $
noremap 1 ^
nnoremap Y y$
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
"  Tab
nnoremap gr gT
"  Window Size
nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap > <C-w>>
nnoremap < <C-w><
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
cmap <M-v> <C-R><C-O>*
"  Replace
nnoremap R gR
nnoremap <expr><Leader>%s  ':%s/' . expand('<cword>') . '/' . expand('<cword>') . '/gc<Left><Left><Left>'
nnoremap <expr><Leader>%%s ':%s/' . expand('<cword>') . '//gc<Left><Left><Left>'
"  Search
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
nnoremap +* *N
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
" $VIMRUNTIME/syntax/vim.vim
let g:vimsyn_embed = 1
" $VIMRUNTIME/ftplugin/sql.vim
let g:ftplugin_sql_objects        = 1
let g:ftplugin_sql_omni_key       = 1
let g:ftplugin_sql_omni_key_left  = 1
let g:ftplugin_sql_omni_key_right = 1
let g:ftplugin_sql_statements     = 1
let g:omni_sql_no_default_maps    = 1
" dummy functions.
function! SQL_SetType() abort "{{{
endfunction "}}}
" disable plugin
let g:did_install_default_menus = 1 "$VIMRUNTIME/menu.vim
let g:loaded_2html_plugin       = 1 "$VIMRUNTIME/plugin/tohtml.vim
let g:loaded_getscript          = 1 "$VIMRUNTIME/autoload/getscript.vim
let g:loaded_getscriptPlugin    = 1 "$VIMRUNTIME/plugin/getscriptPlugin.vim
let g:loaded_gzip               = 1 "$VIMRUNTIME/plugin/gzip.vim
let g:loaded_logiPat            = 1 "$VIMRUNTIME/plugin/logiPat.vim
let g:loaded_matchparen         = 1 "$VIMRUNTIME/plugin/matchparen.vim
let g:loaded_netrw              = 1 "$VIMRUNTIME/autoload/netrw.vim
let g:loaded_netrwFileHandlers  = 1 "$VIMRUNTIME/autoload/netrwFileHandlers.vim
let g:loaded_netrwPlugin        = 1 "$VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_netrwSettings      = 1 "$VIMRUNTIME/autoload/netrwSettings.vim
let g:loaded_rrhelper           = 1 "$VIMRUNTIME/plugin/rrhelper.vim
let g:loaded_spellfile_plugin   = 1 "$VIMRUNTIME/plugin/spellfile.vim
let g:loaded_sql_completion     = 1 "$VIMRUNTIME/autoload/sqlcomplete.vim
let g:loaded_syntax_completion  = 1 "$VIMRUNTIME/autoload/syntaxcomplete.vim
let g:loaded_tar                = 1 "$VIMRUNTIME/autoload/tar.vim
let g:loaded_tarPlugin          = 1 "$VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_vimball            = 1 "$VIMRUNTIME/autoload/vimball.vim
let g:loaded_vimballPlugin      = 1 "$VIMRUNTIME/plugin/vimballPlugin.vim
let g:loaded_zip                = 1 "$VIMRUNTIME/autoload/zip.vim
let g:loaded_zipPlugin          = 1 "$VIMRUNTIME/plugin/zipPlugin.vim
" Vim
nnoremap <SID>[vim] <Nop>
nmap <Leader>f <SID>[vim]
nnoremap <SID>[vim]e :<C-u>tabnew<Space>$MYVIMRC<CR>
nnoremap <SID>[vim]w :<C-u>source<Space>$MYVIMRC<CR>
nnoremap <SID>[vim]s :<C-u>tabnew<Space>$HOME/.vim/vim-sqlfix/sqlfix.sql<CR>
nnoremap <SID>[vim]h :<C-u>source<Space>$VIMRUNTIME/syntax/colortest.vim<CR>
nnoremap <SID>[vim]c :<C-u>IndentLinesToggle<CR>
nnoremap <SID>[vim]p :<C-u>echo<Space>substitute(&runtimepath,<Space>',',<Space>'\n',<Space>'g')<CR>
"}}}

" dein.vim {{{
if dein#load_state(s:deinDir)
    call dein#begin(s:deinDir)
    call dein#add('fuenor/qfixgrep')
    call dein#add('gcmt/wildfire.vim')
    call dein#add('glidenote/memolist.vim')
    call dein#add('hail2u/vim-css3-syntax')
    call dein#add('junegunn/vim-easy-align')
    call dein#add('kannokanno/previm')
    call dein#add('KazuakiM/neosnippet-snippets')
    call dein#add('KazuakiM/vim-qfstatusline')
    call dein#add('KazuakiM/vim-sqlfix')
    call dein#add('KazuakiM/unite-help')
    call dein#add('koron/codic-vim')
    call dein#add('LeafCage/yankround.vim')
    call dein#add('mattn/emmet-vim')
    call dein#add('mojako/ref-sources.vim')
    call dein#add('osyo-manga/unite-highlight')
    call dein#add('pangloss/vim-javascript')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('rhysd/clever-f.vim')
    call dein#add('rhysd/unite-codic.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/neocomplete.vim')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('Shougo/unite.vim')
    call dein#add('sjl/gundo.vim')
    call dein#add('t9md/vim-quickhl')
    call dein#add('thinca/vim-prettyprint')
    call dein#add('thinca/vim-quickrun')
    call dein#add('thinca/vim-qfreplace')
    call dein#add('thinca/vim-ref')
    call dein#add('tpope/vim-surround')
    call dein#add('tyru/open-browser.vim')
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('vim-jp/vital.vim')
    call dein#add('vim-scripts/matchit.zip')
    call dein#add('vim-scripts/taglist.vim')
    call dein#add('Yggdroot/indentLine')
    if s:osType !=# 'win'
        call dein#add('osyo-manga/shabadou.vim')
        call dein#add('osyo-manga/vim-watchdogs')
    endif

    call dein#add('KazuakiM/vim-qfsigns',  {'lazy':1})
    call dein#add('KazuakiM/vim-regexper', {'lazy':1})
    call dein#add('KazuakiM/vim-snippets', {'lazy':1})
    call dein#add('Kuniwak/vint',          {'lazy':1})
    call dein#add('mustardamus/jqapi',     {'lazy':1})
    call dein#add('psychs/lingr-irc',      {'lazy':1})
    call dein#add('thinca/vim-themis',     {'lazy':1})
    call dein#add('tokuhirom/jsref',       {'lazy':1})
    call dein#end()
    call dein#save_state()
endif
filetype plugin indent on
syntax enable

" qfixgrep {{{
let g:disable_MyGrep     = 1
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
let g:yankround_dir                 = s:envHome . '/.vim/yankround.vim'
let g:yankround_region_hl_groupname = 'YankRoundRegion'
let g:yankround_use_region_hl       = 1
"}}}

" indentLine {{{
let g:indentLine_faster = 1
"}}}

" nerdtree {{{
nnoremap <SID>[nerdtree] <Nop>
nmap <Leader>n <SID>[nerdtree]
nnoremap <expr><SID>[nerdtree]n ':NERDTree ' . kazuakim#Path2ProjectDirectory('%') . '<CR>'
nnoremap       <SID>[nerdtree]b :<C-u>NERDTree<CR>
let g:NERDTreeBookmarksFile     = s:envHome . '/.vim/nerdtree/.NERDTreeBookmarks'
let g:NERDTreeMinimalUI         = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowBookmarks     = 1
let g:NERDTreeShowHidden        = 1
let g:NERDTreeWinSize           = 20
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
" unite.vim
let g:loaded_unite_source_bookmark     = 1
let g:unite_data_directory             = s:envHome .'/.vim/unite.vim'
let g:unite_enable_start_insert        = 1
let g:unite_source_grep_command        = 'grep'
let g:unite_source_grep_default_opts   = '--color=auto -i -I'
let g:unite_source_grep_recursive_opt  = ''
let g:unite_source_grep_max_candidates = 200
call unite#custom#source('help', 'ignore_pattern', 'in\ \(runtime\|vimdoc-ja\)')
" memolist
nnoremap <SID>[memolist] <Nop>
nmap <Leader>m <SID>[memolist]
nnoremap <SID>[memolist]n :<C-u>MemoNew<CR>
nnoremap <SID>[memolist]l :<C-u>MemoList<CR>
let g:memolist_filename_prefix_none = 1
let g:memolist_template_dir_path    = s:envHome .'/.vim/memolist.vim'
let g:memolist_unite                = 1
let g:memolist_unite_option         = '-default-action=tabopen'
let g:memolist_unite_source         = 'file_rec'
"}}}

" vim-quickrun {{{
nnoremap <Leader>run  :<C-u>QuickRun<CR>
nnoremap <Leader>runt :<C-u>call<Space>kazuakim#Test()<CR>
nnoremap <Leader>runl :<C-u>call<Space>kazuakim#Lint()<CR>
nnoremap <Leader>phpi :<C-u>call<Space>kazuakim#PhpInfo()<CR>
" Set g:quickrun_config at .vimrc.local .
let s:quickrun_config_javascript = {
\    'command':     'eslint',
\    'cmdopt':      '--cache --cache-location ' . s:envHome . '/.cache/eslint/.eslintcache --format compact --max-warnings 1 --no-color --no-ignore --quiet',
\    'errorformat': '%E%f: line %l\, col %c\, Error - %m,%W%f: line %l\, col %c\, Warning - %m,%-G%.%#',
\    'exec':        '%c %o %s:p'
\}
let g:quickrun_config = {
\    '_': {
\        'hook/close_buffer/enable_empty_data': 0,
\        'hook/close_buffer/enable_failure':    0,
\        'outputter':                           'multi:buffer:quickfix',
\        'outputter/buffer/close_on_empty':     1,
\        'outputter/buffer/split':              ':botright',
\        'runner':                              'vimproc',
\        'runner/vimproc/updatetime':           600
\    },
\    'javascript': {
\        'command':     s:quickrun_config_javascript['command'],
\        'cmdopt':      s:quickrun_config_javascript['cmdopt'] . ' --config ' . s:envHome . '/.eslintrc.js',
\        'errorformat': s:quickrun_config_javascript['errorformat'],
\        'exec':        s:quickrun_config_javascript['exec']
\    },
\    'javascript/watchdogs_checker': {
\        'type': 'watchdogs_checker/javascript'
\    },
\    'json': {
\        'command':               'python',
\        'cmdopt':                '-m json.tool',
\        'exec':                  '%c %o %s:p',
\        'outputter':             'buffer',
\        'outputter/buffer/into': 1
\    },
\    'php': {
\        'command':                             'php',
\        'exec':                                '%c %s:p',
\        'hook/close_buffer/enable_empty_data': 0,
\        'hook/close_buffer/enable_failure':    0,
\        'outputter':                           'buffer',
\        'outputter/buffer/close_on_empty':     0,
\        'outputter/buffer/into':               1,
\        'outputter/buffer/split':              ':botright 7sp'
\    },
\    'php/watchdogs_checker': {
\        'type': 'watchdogs_checker/php'
\    },
\    'sql': {
\        'type': 'sql/mysql'
\    },
\    'sql/mysql': {
\        'exec':                  "%c %o < %s | sed -e 's/\t/|/g'",
\        'outputter':             'buffer',
\        'outputter/buffer/into': 1
\    },
\    'watchdogs_checker/_': {
\        'hook/close_quickfix/enable_exit':        1,
\        'hook/back_window/enable_exit':           0,
\        'hook/back_window/priority_exit':         1,
\        'hook/qfstatusline_update/enable_exit':   1,
\        'hook/qfstatusline_update/priority_exit': 2,
\        'outputter/quickfix/open_cmd':            ''
\    },
\    'watchdogs_checker/javascript': {
\        'command':     s:quickrun_config_javascript['command'],
\        'cmdopt':      s:quickrun_config_javascript['cmdopt'] . ' --config ' . s:envHome . '/.eslintrc.limit.js',
\        'errorformat': s:quickrun_config_javascript['errorformat'],
\        'exec':        s:quickrun_config_javascript['exec']
\    },
\    'watchdogs_checker/php': {
\        'command': 'php',
\        'cmdopt':  '-l -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0',
\        'exec':    '%c %o %s:p'
\    },
\    'xml': {
\        'command':               'xmllint',
\        'cmdopt':                '--noblanks --nowrap --encode UTF-8 --format',
\        'exec':                  '%c %o %s:p',
\        'outputter':             'buffer',
\        'outputter/buffer/into': 1
\    }
\}
unlet s:quickrun_config_javascript
"}}}

" taglist.vim {{{
"MEMO:$ ctags --list-maps : ctags supported filetype.
"MEMO:$ ctags --list-kinds: ctags tlist setting.
nnoremap <Leader>t :<C-u>Tlist<CR>
let g:tlist_javascript_settings = 'javascript;c:classes;f:function;p:propertie;m:methods;C:constant;v:variable'
let g:tlist_php_settings        = 'php;n:namespace;c:class;i:interface;t:trait;f:function;d:constant;v:variable'
let g:Tlist_Exit_OnlyWindow     = 1
let g:Tlist_Show_One_File       = 1
let g:Tlist_Use_Right_Window    = 1
let g:Tlist_WinWidth            = 25
"}}}

" vim-qfreplace {{{
nnoremap <Leader>qr :<C-u>Qfreplace<CR>
"}}}

" vim-easy-align {{{
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
nnoremap <Space>m :<C-u>call<Space>quickhl#manual#this('n')<CR>
nnoremap <Space>M :<C-u>call<Space>quickhl#manual#reset()<CR>
    let g:quickhl_manual_colors = [
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=Blue        guibg=Blue',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Cyan        guibg=Cyan',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Magenta     guibg=Magenta',
    \    'cterm=NONE gui=NONE ctermfg=Black guifg=Black ctermbg=Yellow      guibg=Yellow',
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=DarkBlue    guibg=DarkBlue',
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=DarkCyan    guibg=DarkCyan',
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=DarkMagenta guibg=DarkMagenta',
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=DarkRed     guibg=DarkRed',
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=DarkGreen   guibg=DarkGreen',
    \    'cterm=NONE gui=NONE ctermfg=White guifg=White ctermbg=Brown       guibg=Brown',
    \]
"}}}

" vim-sqlfix {{{
let g:sqlfix#Config = {'direcotry_path': s:envHome . '/.vim/vim-sqlfix'}
"}}}

" previm {{{
nnoremap <silent> <Leader>pre :<C-u>PrevimOpen<CR>
"}}}

" vim-ref {{{
inoremap <silent><C-k> <C-o>:call<Space>ref#K('normal')<CR><ESC>
nmap <silent>K <Plug>(ref-keyword)
let g:ref_no_default_key_mappings = 1
let g:ref_cache_dir               = s:envHome . '/.vim/vim-ref/cache'
let g:ref_detect_filetype         = {
\    'css':        'phpmanual',
\    'html':       ['phpmanual',  'javascript', 'jquery'],
\    'javascript': ['javascript', 'jquery'],
\    'php':        ['phpmanual',  'javascript', 'jquery']
\}
let g:ref_javascript_doc_path = s:envHome . '/.vim/dein.vim/repos/github.com/tokuhirom/jsref/htdocs'
let g:ref_jquery_doc_path     = s:envHome . '/.vim/dein.vim/repos/github.com/mustardamus/jqapi'
let g:ref_phpmanual_path      = s:envHome . '/.vim/vim-ref/php-chunked-xhtml'
let g:ref_use_cache           = 1
let g:ref_use_vimproc         = 1
"}}}

" open-browser.vim {{{
nmap <Leader>gx <Plug>(openbrowser-open)
"}}}

" clever-f.vim {{{
nmap f <Plug>(clever-f-f)
let g:clever_f_across_no_line = 0
let g:clever_f_smart_case     = 1
let g:clever_f_use_migemo     = 0
"}}}

" vim-surround {{{
nmap cs <Plug>Csurround
"}}}

" neosnippet-snippets
" neosnippet.vim
" neoinclude.vim
" neocomplete.vim {{{
imap <silent><expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" neosnippet.vim
smap <silent><expr><TAB>  neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
nmap <silent><expr><TAB>  neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <silent><expr><C-x>  KazuakiMNeoCompleteCr()
imap <silent><expr><CR>   KazuakiMNeoCompleteCr()
nmap <silent><S-TAB> <ESC>a<C-r>=neosnippet#commands#_clear_markers()<CR>
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
"neocomplete.vim
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#data_directory               = s:envHome .'/.vim/neocomplete.vim'
let g:neocomplete#delimiter_patterns           = {
\    'javascript': ['.'],
\    'php':        ['->', '::', '\'],
\    'ruby':       ['::']
\}
let g:neocomplete#enable_at_startup         = 1
let g:neocomplete#enable_auto_close_preview = 1
let g:neocomplete#enable_auto_delimiter     = 1
let g:neocomplete#enable_auto_select        = 0
let g:neocomplete#enable_fuzzy_completion   = 0
let g:neocomplete#enable_smart_case         = 1
let g:neocomplete#keyword_patterns          = {'_': '\h\w*'}
let g:neocomplete#lock_buffer_name_pattern  = '\.log\|.*quickrun.*\|.jax'
let g:neocomplete#max_keyword_width         = 30
let g:neocomplete#max_list                  = 8
let g:neocomplete#min_keyword_length        = 3
let g:neocomplete#sources                   = {
\    '_':          ['neosnippet', 'file',               'buffer'],
\    'css':        ['neosnippet',         'dictionary', 'buffer'],
\    'html':       ['neosnippet', 'file', 'dictionary', 'buffer'],
\    'javascript': ['neosnippet', 'file', 'dictionary', 'buffer'],
\    'php':        ['neosnippet', 'file', 'dictionary', 'buffer']
\}
let g:neocomplete#sources#buffer#cache_limit_size  = 50000
let g:neocomplete#sources#buffer#disabled_pattern  = '\.log\|\.jax'
let g:neocomplete#sources#buffer#max_keyword_width = 30
let g:neocomplete#sources#dictionary#dictionaries  = {
\    '_':          '',
\    'css':        s:envHome . '/.vim/dict/css.dict',
\    'html':       s:envHome . '/.vim/dict/html.dict',
\    'javascript': s:envHome . '/.vim/dict/javascript.dict',
\    'php':        s:envHome . '/.vim/dict/php.dict'
\}
let g:neocomplete#use_vimproc = 1
"neoinclude.vim
let g:neoinclude#exts          = {'php': ['php', 'inc', 'tpl']}
let g:neoinclude#max_processes = 5
"neosnippet.vim
let g:neosnippet#data_directory                = s:envHome . '/.vim/neosnippet.vim'
let g:neosnippet#disable_runtime_snippets      = {'_' : 1}
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory            = s:envHome . '/.vim/dein.vim/repos/github.com/KazuakiM/neosnippet-snippets/neosnippets'
function! KazuakiMNeoCompleteCr() abort "{{{
    if pumvisible() is# 0
        return "\<CR>X\<C-h>"
    elseif neosnippet#expandable_or_jumpable()
        return "\<Plug>(neosnippet_expand_or_jump)"
    endif
    return "\<Left>\<Right>"
endfunction "}}}
"}}}

" gundo.vim {{{
nnoremap cu :<C-u>call<Space>kazuakim#ClearUndo()<CR>
nnoremap u g-
nnoremap U g-
nnoremap <C-r> g+
"}}}

" emmet-vim {{{
"
" MEMO
" * URL: http://docs.emmet.io/cheat-sheet/
" * <C+y>,  :execute trigger key
" * html:5  && <C+y>,
" * div>ul>li.class#id_$$*5  && <C+y>,
let g:user_emmet_complete_tag = 1
let g:user_emmet_settings     = {
\    'variables': {
\        'lang':               'ja',
\        'default_attributes': {
\            'a': {
\                'href': ''
\            },
\            'link': [
\                {
\                    'rel': 'stylesheet'
\                },
\                {
\                    'href': ''
\                }
\            ]
\        }
\    },
\    'html': {
\        'filters':     'html',
\        'indentation': '    '
\    },
\    'php' : {
\        'extends': 'html',
\        'filters': 'html,c'
\    }
\}
let g:user_emmet_mode        = 'a'
"let g:user_emmet_leader_key = ''
"}}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
"}}}

" Exclusive {{{
if s:osType !=# 'macunix'
endif

if s:osType !=# 'win'
    " memolist.vim {{{
    let g:memolist_path = s:envHome .'/.vim/memolist.vim'
    "}}}
    " neoinclude.vim {{{
    let g:neoinclude#delimiters = '\'
    "}}}
    " shabadou.vim
    " vim-watchdogs {{{
    let g:watchdogs_check_BufWritePost_enable  = 1
    let g:watchdogs_check_BufWritePost_enables = {'vim': 0}
    let g:watchdogs_check_CursorHold_enable    = 1
    let g:watchdogs_check_CursorHold_enables   = {'vim': 0}
    "}}}
endif

if s:osType !=# 'unix'
endif
"}}}

" Only {{{
if s:osType ==# 'macunix'
    " mapping {{{
    nnoremap ao :<C-u>!open<Space>-a<Space>
    nnoremap aq :<C-u>!osascript<Space>-e<Space>'tell<Space>application<Space>""<Space>to<Space>quit'<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
    nnoremap af :<C-u>!osascript<Space>-e<Space>'tell<Space>application<Space>""<Space>to<Space>activate'<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
    "}}}
    " previm {{{
    let g:previm_open_cmd = 'open -a "Google Chrome"'
    "}}}

elseif s:osType ==# 'win'
    " previm {{{
    let g:previm_open_cmd = 'C:/Program\ Files\ (x86)/Google/Chrome/Application/chrome.exe'
    "}}}
    " memolist.vim {{{
    let g:memolist_path = '/cygwin64/home/' . $USER . '/.vim/memolist.vim'
    "}}}
    " neoinclude.vim {{{
    let g:neoinclude#delimiters = '/'
    "}}}

elseif s:osType ==# 'unix'
endif
"}}}

"}}}

" FileType {{{
autocmd MyAutoCmd BufNewFile,BufRead *.coffee    setlocal filetype=coffee
autocmd MyAutoCmd BufNewFile,BufRead *.tpl       setlocal filetype=php
autocmd MyAutoCmd BufNewFile,BufRead *.snip*     setlocal filetype=snippets
autocmd MyAutoCmd BufNewFile,BufRead *.vim*      setlocal filetype=vim
autocmd MyAutoCmd BufNewFile,BufRead *.{bin,exe} setlocal filetype=xxd
autocmd MyAutoCmd FileType html,js,php,xml syntax sync minlines=2000
"}}}

" Function {{{
nnoremap <F1> :<C-u>call<Space>kazuakim#DatabaseSwitch()<CR>
set pastetoggle=<F2>
nnoremap <F3> :<C-u>edit++enc=utf-8<CR>
"}}}

" Other setting files {{{
" Environment setting file
if s:osType ==# 'win'
    source ~/.vimrc.win
else
    source ~/.vimrc.local
endif
"}}}
