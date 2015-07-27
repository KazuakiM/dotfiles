augroup MyXxdAutoCmd
    autocmd!
    autocmd VimEnter,WinEnter * %!xxd
    autocmd BufWritePre       * %!xxd -r
    autocmd BufWritePost      * %!xxd | setlocal nomod
augroup END
