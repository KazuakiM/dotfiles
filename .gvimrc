"
"
" Common {{{
" Basic
set antialias
set t_vb=
set showtabline=1
set guioptions-=T
set guioptions-=m
set guioptions-=g
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=t
set guioptions-=b
set winaltkeys=no
" Color
colorscheme desert
" Show
set cmdheight=1
"}}}
"
"
" OS type {{{
if has("win32") || has ("win64")
    set guifont=Source_Code_Pro:h12:cANSI
    set lines=54
    set columns=150
    winpos 704 0
else
    set guifont=Ricty_Discord_Regular:h16
    set lines=44
    set columns=170
    winpos 0 23
endif
"}}}
