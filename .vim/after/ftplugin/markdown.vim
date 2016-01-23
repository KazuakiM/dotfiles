augroup MyMarkdownAutoCmd
    autocmd!
    autocmd VimEnter,WinEnter *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal conceallevel=0
augroup END
setlocal nowrap
"setlocal spelllang+=cjk spell
highlight htmlBold   cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
highlight htmlItalic cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
