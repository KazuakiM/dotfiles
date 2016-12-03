"
"
" Common {{{
" Basic
set antialias cmdheight=1 guioptions-=b guioptions-=e guioptions-=g guioptions-=l guioptions-=L guioptions-=m guioptions-=r guioptions-=R guioptions-=t guioptions-=T
set mouse= showtabline=1 t_vb= winaltkeys=no
" Color
if getfsize(expand('%:p')) < 262144
    colorscheme kazuakim
endif
" Mapping
"  ESC
inoremap <silent> <Esc> <Esc>`^
"  Window
function! KazuakiMSetWindow(line, column) abort "{{{
    let s:KazuakiMWindow  = {'lines' : s:KazuakiMWindow.lines + a:line, 'columns': s:KazuakiMWindow.columns + a:column}
    execute 'set lines='.get(s:KazuakiMWindow,'lines').' columns='.get(s:KazuakiMWindow,'columns')
endfunction "}}}
nnoremap <S-Down>  :<C-u>call KazuakiMSetWindow( 3,  0)<CR>
nnoremap <S-Up>    :<C-u>call KazuakiMSetWindow(-3,  0)<CR>
nnoremap <S-Left>  :<C-u>call KazuakiMSetWindow( 0, -3)<CR>
nnoremap <S-Right> :<C-u>call KazuakiMSetWindow( 0,  3)<CR>
"}}}
"
"
" OS type {{{
if has("win32") || has ("win64")
    let s:KazuakiMWindow  = {'lines' : 45, 'columns': 98}
    set guifont=Source_Code_Pro:h12:cANSI
    execute 'set lines='.get(s:KazuakiMWindow,'lines').' columns='.get(s:KazuakiMWindow,'columns')
    winpos 1120 0
else
    let s:KazuakiMWindow  = {'lines' : 44, 'columns': 130}
    set guifont=Ricty\ Diminished\ Discord\ Regular:h16 guifontwide=Ricty\ Diminished\ Discord\ Regular:h16 macmeta
    execute 'set lines='.get(s:KazuakiMWindow,'lines').' columns='.get(s:KazuakiMWindow,'columns')
    winpos 320 0
endif
"}}}
