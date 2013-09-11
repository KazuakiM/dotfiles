" Memo
"{{{
"   :help internal-variables
"{{{
"-----------------------------------------------------------------------------------------------------------
" buffer-variable    b:   Local to the current buffer.
" window-variable    w:   Local to the current window.
" tabpage-variable   t:   Local to the current tab page.
" global-variable    g:   Global.
" local-variable     l:   Local to a function.
" script-variable    s:   Local to a :source'ed Vim script.
" function-argument  a:   Function argument (only inside a function).
" vim-variable       v:   Global, predefined by Vim.
"-----------------------------------------------------------------------------------------------------------
"}}}
"   :help map
"{{{
"-----------------------------------------------------------------------------------------------------------
"                                        modes:
" commands:                              Normal Visual Select Operator-pending Insert Command-line Lang-Arg
" :map   :noremap   :unmap   :mapclear    yes    yes    yes         yes          -         -          -
" :nmap  :nnoremap  :nunmap  :nmapclear   yes     -      -           -           -         -          -
" :vmap  :vnoremap  :vunmap  :vmapclear    -     yes    yes          -           -         -          -
" :omap  :onoremap  :ounmap  :omapclear    -      -      -          yes          -         -          -
" :vmap  :vnoremap  :vunmap  :vmapclear    -     yes    yes          -           -         -          -
" :xmap  :xnoremap  :xunmap  :xmapclear    -     yes     -           -           -         -          -
" :smap  :snoremap  :sunmap  :smapclear    -      -     yes          -           -         -          -
" :map!  :noremap!  :unmap!  :mapclear!    -      -      -           -          yes       yes         -
" :imap  :inoremap  :iunmap  :imapclear    -      -      -           -          yes        -          -
" :cmap  :cnoremap  :cunmap  :cmapclear    -      -      -           -           -        yes         -
" :lmap  :lnoremap  :lunmap  :lmapclear    -      -      -           -          yes*      yes*       yes*
"-----------------------------------------------------------------------------------------------------------
"}}}
"   color
"{{{
" confirm the definition of color
"   :so $VIMRUNTIME/syntax/colortest.vim
" check the status of the current Vim
"   :so $VIMRUNTIME/syntax/hitest.vim
"}}}
"}}}
" Common
"{{{
set nocompatible
" Encode
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
" Basic
let mapleader=","
set scrolloff=5
set textwidth=0
set autoread
set hidden
set backspace=indent,eol,start
set vb t_vb= "
set foldmethod=marker
" Color
syntax on
set t_Co=256
colorscheme jellybeans
" Show
set title
set ruler
set laststatus=2
set number
augroup AdditionalHighlights
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TabString     cterm=reverse ctermfg=lightyellow
  autocmd VimEnter,WinEnter * let w:m1 = matchadd("TabString",     '\t')
  autocmd VimEnter,WinEnter,ColorScheme * highlight CrString      cterm=reverse ctermfg=darkred
  autocmd VimEnter,WinEnter * let w:m2 = matchadd("CrString",      '\r')
  autocmd VimEnter,WinEnter,ColorScheme * highlight CrlfString    cterm=reverse ctermfg=darkmagenta
  autocmd VimEnter,WinEnter * let w:m3 = matchadd("CrlfString",    '\r\n')
  autocmd VimEnter,WinEnter,ColorScheme * highlight WhitespaceEOL cterm=reverse ctermfg=lightmagenta
  autocmd VimEnter,WinEnter * let w:m4 = matchadd("WhitespaceEOL", '\s\+$')
  autocmd VimEnter,WinEnter,ColorScheme * highlight ZenkakuSpace  cterm=reverse ctermfg=lightred
  autocmd VimEnter,WinEnter * let w:m5 = matchadd("ZenkakuSpace",  '　')
augroup END
set cursorline
set cursorcolumn
" Clipboard
set clipboard+=autoselect,unnamed
" Backup
set nobackup
set noswapfile
" Indentation
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
"}}}
" NeoBundle
"{{{
if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc
"{{{
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }
"}}}
" unite.vim
"{{{
NeoBundle 'Shougo/unite.vim'
"}}}
" syntastic'
"{{{
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
"}}}
" vim-tags
"{{{
"# command memo
"* :TagsGenerate :Remake tags.
"* <C-]>         :Jump target file
"* <C-t>         :Return before file
"* :ts           :Jump target file list
NeoBundle 'szw/vim-tags'
nnoremap <C-]> g<C-]>
let g:vim_tags_auto_generate = 1
let g:vim_tags_gems_tags_command = "ctags -f $HOME/.vim/tags/.Gemfile.lock.tags `bundle show --paths` 2>/dev/null &"
au BufNewFile,BufRead *.php,*.ctp,*.tol,*.inc let g:vim_tags_project_tags_command = "ctags --languages=PHP -f $HOME/.vim/tags/php.tags `pwd` 2>/dev/null"
au BufNewFile,BufRead *.php,*.ctp,*.tol,*.inc set tags+=$HOME/.vim/tags/php.tags
au BufNewFile,BufRead *.rb let g:vim_tags_project_tags_command = "ctags --languages=Ruby:.rb -f $HOME/.vim/tags/rb.tags  `pwd` 2>/dev/null"
au BufNewFile,BufRead *.rb set tags+=$HOME/.vim/tags/rb.tags,$HOME/.vim/tags/.Gemfile.lock.tags
"}}}
" taglist.vim
"{{{
"# command memo
"* :Tlist :Show class, function and etc at left menu.
NeoBundle 'vim-scripts/taglist.vim'
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
"}}}
" NeoComplete
"{{{
NeoBundleLazy 'Shougo/neocomplete.vim', {
      \   'autoload' : {
      \     'insert' : 1,
      \   },
      \ }
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
endfunction
"}}}
" neosnippet.vim
" vim-snippets
"{{{
NeoBundleLazy "Shougo/neosnippet.vim", {
      \   "depends": ["honza/vim-snippets"],
      \   "autoload": {
      \     "insert": 1,
      \   },
      \ }
let s:hooks = neobundle#get_hooks("neosnippet.vim")
function! s:hooks.on_source(bundle)
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/vim-snippets/snippets'
endfunction
"}}}
" Align
"{{{
"# command memo
"* ,t=   :Align base action
"* ,acom :Align action only commentout
NeoBundle 'vim-scripts/Align'
let g:Align_xstrlen=3
"}}}
" vim-ref
"{{{
"# command memo
"* <S-k> :Show mabual
NeoBundle 'thinca/vim-ref'
let g:ref_phpmanual_path=$HOME.'/.vim/ref/php-chunked-xhtml'
"}}}
" matchit.zip
" vim-endwise
"{{{
"# command memo
"* % :Move from start to end or end to start
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'tpope/vim-endwise'
"}}}
" vim-surround
"{{{
"# command memo
"* cs"'   :Change From  " to '
"* cs'<p> :Change From  ' to <p>
"* ds'    :Delete '
NeoBundle 'tpope/vim-surround'
"}}}
" nerdtree
"{{{
NeoBundle 'scrooloose/nerdtree'
nmap <C-n> :NERDTree<CR>
"}}}
" vim-fugitive
" landscape
" lightline
"{{{
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
      \   'colorscheme': 'landscape',
      \   'mode_map': { 'c': 'NORMAL' },
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \   },
      \   'component_function': {
      \     'modified': 'MyModified',
      \     'readonly': 'MyReadonly',
      \     'fugitive': 'MyFugitive',
      \     'filename': 'MyFilename',
      \     'fileformat': 'MyFileformat',
      \     'filetype': 'MyFiletype',
      \     'fileencoding': 'MyFileencoding',
      \     'mode': 'MyMode',
      \   },
      \   'separator': { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '|', 'right': '|' }
      \ }
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
" jellybeans
"{{{
NeoBundle 'nanotech/jellybeans.vim'
"}}}
filetype plugin indent on
"}}}

