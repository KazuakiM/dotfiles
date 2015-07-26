augroup MyHelpAutoCmd
    autocmd!
    autocmd BufWinEnter * setlocal conceallevel=0
augroup END
setlocal colorcolumn=79
nmap <silent> <buffer> <ESC><ESC> :quit<CR>
