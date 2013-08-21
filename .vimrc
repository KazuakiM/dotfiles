" line number was showed
set number
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

