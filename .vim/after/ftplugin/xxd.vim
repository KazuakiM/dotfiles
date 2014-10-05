autocmd MyAutoCmd VimEnter,WinEnter * %!xxd
autocmd MyAutoCmd BufWritePre       * %!xxd -r
autocmd MyAutoCmd BufWritePost      * %!xxd | setlocal nomod
