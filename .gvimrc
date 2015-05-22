"
"
" Common {{{
" Basic
set antialias cmdheight=1 guioptions-=b guioptions-=g guioptions-=l guioptions-=L guioptions-=m guioptions-=r guioptions-=R guioptions-=t guioptions-=T mouse=
set showtabline=1 t_vb= winaltkeys=no
" Color
colorscheme kazuakim
"}}}
"
"
" OS type {{{
function! KazuakiMSetWindow(line, column) abort "{{{
    let s:KazuakiMWindow  = {'lines' : s:KazuakiMWindow.lines + a:line, 'columns': s:KazuakiMWindow.columns + a:column}
    execute 'set lines='.get(s:KazuakiMWindow,'lines').' columns='.get(s:KazuakiMWindow,'columns')
endfunction "}}}
nnoremap <S-j> :<C-u>call KazuakiMSetWindow( 3,  0)<CR>
nnoremap <S-k> :<C-u>call KazuakiMSetWindow(-3,  0)<CR>
nnoremap <S-h> :<C-u>call KazuakiMSetWindow( 0, -3)<CR>
nnoremap <S-l> :<C-u>call KazuakiMSetWindow( 0,  3)<CR>
if has("win32") || has ("win64")
    let s:KazuakiMWindow  = {'lines' : 41, 'columns': 78}
    execute 'set guifont=Source_Code_Pro:h12:cANSI lines='.get(s:KazuakiMWindow,'lines').' columns='.get(s:KazuakiMWindow,'columns')
    winpos 1120 0
else
    let s:KazuakiMWindow  = {'lines' : 44, 'columns': 170}
    execute 'set guifont=Ricty\ Diminished\ Discord\ Regular:h16 lines='.get(s:KazuakiMWindow,'lines').' columns='.get(s:KazuakiMWindow,'columns')
    winpos 0 23
endif
"}}}
