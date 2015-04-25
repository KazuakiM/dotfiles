if has('win32') || has ('win64')
elseif isdirectory('/Applications/MacVim.app/Contents/Resources/vim/runtime')
    let $VIMRUNTIME = '/Applications/MacVim.app/Contents/Resources/vim/runtime'
else
    let $VIMRUNTIME = '/usr/local/share/vim/vim74'
endif
set runtimepath+=$VIMRUNTIME
autocmd MyAutoCmd BufNewFile,BufRead *.{vimrc,vim} setlocal filetype=vim
autocmd MyAutoCmd BufNewFile,BufRead *.{php}       setlocal filetype=php
autocmd MyAutoCmd BufNewFile,BufRead *.{html}      setlocal filetype=html
autocmd MyAutoCmd BufNewFile,BufRead *.{css}       setlocal filetype=css
autocmd MyAutoCmd BufNewFile,BufRead *.{js}        setlocal filetype=javascript
autocmd MyAutoCmd BufNewFile,BufRead *.{rb}        setlocal filetype=ruby
autocmd MyAutoCmd BufEnter           *             source $VIMRUNTIME/syntax/syntax.vim

