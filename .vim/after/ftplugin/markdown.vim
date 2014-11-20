if &cp || (exists('g:loaded_after_ftplugin_markdown') && g:loaded_after_ftplugin_markdown)
    finish
endif
let g:loaded_after_ftplugin_markdown = 1
autocmd MyAutoCmd VimEnter,WinEnter * PrevimOpen
