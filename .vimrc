" line number was showed
set number
" encode 
set encoding=utf8
set fileencoding=utf-8
" no backup files 
set noswapfile
set nowritebackup
set nobackup
" NeoBundle
" {{{
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc
" {{{
NeoBundle 'Shougo/vimproc'
" }}}
filetype plugin indent on
" }}}

