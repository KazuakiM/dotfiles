if exists('g:loaded_after_ftplugin_markdown')
    finish
endif
let g:loaded_after_ftplugin_markdown = 1

autocmd MyAutoCmd VimEnter * PrevimOpen
