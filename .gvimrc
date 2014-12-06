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
autocmd MyAutoCmd ColorScheme * highlight Comment ctermfg=darkgray gui=NONE guifg=darkgray
colorscheme jellybeans
"}}}
"
"
" NeoBundleLazy {{{
" nerdtree {{{
nnoremap <expr><Leader>n ':NERDTree '.expand("%:p").'<CR>'
"}}}
"}}}
"
"
" OS type {{{
if (has("win32") || has ("win64"))
    set guifont=Source_Code_Pro:h12:cANSI
    set lines=50
    set columns=87
else
    set guifont=Ricty_Discord_Regular:h16
    set lines=47
    set columns=96
endif
"}}}
