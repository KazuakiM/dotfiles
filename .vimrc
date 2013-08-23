"{{{
" vim visual 
set number
set ruler
set laststatus=2
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
syntax on
" other version support
set nocompatible
" backspace support
set backspace=indent,eol,start
" indent
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set list
set listchars=eol:\ ,tab:>\ 
" no wrap
set nowrap
" MarkDown Folding
set foldmethod=marker
" encode 
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
" no backup files 
set noswapfile
set nowritebackup
set nobackup
"}}}
" NeoBundle
"{{{
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc
"{{{
NeoBundle 'Shougo/vimproc', {
\   'build' : {
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
"}}}
filetype plugin indent on
"}}}

