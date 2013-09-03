" Common
"{{{
set nocompatible
" Encode 
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
" Basic
set textwidth=0
set nowrap
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
set list
set listchars=eol:\ ,tab:>\
highlight ZenkakuSpace cterm=reverse ctermfg=Yellow
match ZenkakuSpace /　/
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
" Language
"{{{
augroup PHP
  autocmd FileType php set makeprg=php\ -l\ %
  autocmd BufWritePost *.php,*.ctp silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
augroup END
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
" vim-tags
"{{{
NeoBundle 'szw/vim-tags'
let g:vim_tags_auto_generate = 1
au BufNewFile,BufRead *.php,*.ctp,*.inc let g:vim_tags_project_tags_command = "ctags --languages=PHP -f $HOME/.vim/tags/php.tags `pwd` 2>/dev/null"
au BufNewFile,BufRead *.php,*.ctp,*.inc set tags+=$HOME/.vim/tags/php.tags 
au BufNewFile,BufRead *.rb              let g:vim_tags_project_tags_command = "ctags --languages=Ruby:.rb -f $HOME/.vim/tags/rb.tags  `pwd` 2>/dev/null"
let g:vim_tags_gems_tags_command = "ctags -f $HOME/.vim/tags/.Gemfile.lock.tags `bundle show --paths` 2>/dev/null &"
au BufNewFile,BufRead *.rb              set tags+=$HOME/.vim/tags/rb.tags,$HOME/.vim/tags/.Gemfile.lock.tags
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
" vim-endwise
"{{{
NeoBundle 'tpope/vim-endwise'
"}}}
" powerline
"{{{
NeoBundle 'Lokaltog/powerline', {
\   'rtp' : 'powerline/bindings/vim'
\ }
"}}}
" jellybeans
"{{{
NeoBundle 'nanotech/jellybeans.vim'
"}}}
filetype plugin indent on
"}}}

