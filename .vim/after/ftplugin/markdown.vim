function! s:MyMarkdownInit() abort "{{{
    setlocal conceallevel=0
    highlight htmlBold   cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
    highlight htmlItalic cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
endfunction "}}}

augroup MyMarkdownAutoCmd
    autocmd!
    autocmd VimEnter,WinEnter *.{md,mdown,mkd,mkdn,markdown,mdwn} call s:MyMarkdownInit()
augroup END
setlocal nowrap
"setlocal spelllang+=cjk spell
