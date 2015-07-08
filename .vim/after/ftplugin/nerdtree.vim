nmap <silent> <buffer> <ESC><ESC> :quit<CR>
nmap <Leader>b :<C-u>Bookmark<CR>
nmap <expr><Leader>c ':ClearBookmarks '.expand('<cfile>').'<CR>'
