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
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc
"{{{
NeoBundle 'Shougo/vimproc', {
\   'build' : {
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
"}}}
" vim-tags
"{{{
NeoBundle 'szw/vim-tags'
let g:vim_tags_auto_generate = 1
au BufNewFile,BufRead *.php,*.ctp let g:vim_tags_project_tags_command = "ctags --languages=PHP:.php,.ctp -f $HOME/.vim/tags/php.tags `pwd` 2>/dev/null"
au BufNewFile,BufRead *.php,*.ctp set tags+=$HOME/.vim/tags/php.tags 
au BufNewFile,BufRead *.rb        let g:vim_tags_project_tags_command = "ctags --languages=Ruby:.rb -f $HOME/.vim/tags/rb.tags  `pwd` 2>/dev/null"
let g:vim_tags_gems_tags_command = "ctags -f $HOME/.vim/tags/.Gemfile.lock.tags `bundle show --paths` 2>/dev/null &"
au BufNewFile,BufRead *.rb  set tags+=$HOME/.vim/tags/rb.tags,$HOME/.vim/tags/.Gemfile.lock.tags
"}}}
" NeoComplete
"{{{
NeoBundleLazy 'Shougo/neocomplete', {
\   'autoload' : {
\     'insert' : 1,
\   },
\ }
let g:neocomplete#enable_startup = 1
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
endfunction
"}}}
filetype plugin indent on
"}}}

