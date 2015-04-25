function! KazuakiMDiff() "{{{
    let a:extension = expand('%:e')
    if expand('%:r') ==# '.vimrc' || a:extension ==# 'vimrc'
        setlocal filetype=vim
    elseif a:extension ==# 'lock'
        setlocal filetype=json
    else
        execute 'setlocal filetype='.a:extension
    endif
    source $VIMRUNTIME/syntax/syntax.vim
endfunction "}}}

if has('win32') || has ('win64')
elseif isdirectory('/Applications/MacVim.app/Contents/Resources/vim/runtime')
    let $VIMRUNTIME = '/Applications/MacVim.app/Contents/Resources/vim/runtime'
else
    let $VIMRUNTIME = '/usr/local/share/vim/vim74'
endif
set runtimepath+=$VIMRUNTIME
autocmd MyAutoCmd BufNewFile,BufRead * call KazuakiMDiff()

