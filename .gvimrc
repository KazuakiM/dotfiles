"
"
" Common
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
if (has("win32") || has ("win64"))
    set guifont=Source_Code_Pro:h16:cANSI
    set lines=45
    set columns=100
else
    set lines=47
    set columns=96
endif
set antialias
set t_vb=
autocmd MyAutoCmd ColorScheme * highlight Comment ctermfg=darkgray gui=NONE guifg=darkgray
colorscheme jellybeans
"}}}
