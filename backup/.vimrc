" plugnin setting memo backup
"
"
" NeoBundle
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" syntastic {{{
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
"}}}
" vim-sqlfix(local file refer) {{{
NeoBundle 'vim-sqlfix', {
\    'base': '/srv/vim-plugin',
\    'type': 'nosync',}
"}}}
"}}}
"
"
" NeoBundleLazy
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" vim-over {{{
NeoBundleLazy 'osyo-manga/vim-over', {
\    'autoload' : {
\        'commands' : 'OverCommandLine',},}
nnoremap <expr><Leader>%s ':OverCommandLine<CR>%s/'.expand('<cword>').'/'
"}}}
" neosnippet-snippets
" neosnippet.vim {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {
\    'depends': ['KazuakiM/neosnippet-snippets', 'Shougo/neosnippet.vim', 'Shougo/context_filetype.vim'],
\    'autoload' : {
\        'insert' : 1,},}
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ '\<Plug>(neosnippet_expand_or_jump)'
            \: pumvisible() ? '\<C-n>' : '\<TAB>'
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ '\<Plug>(neosnippet_expand_or_jump)'
            \: '\<TAB>'
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
let g:neosnippet#disable_runtime_snippets = {
\    '_' : 1,}
let g:neosnippet#data_directory=$HOME.'/.vim/neosnippet.vim'
let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/neosnippet-snippets/neosnippets'
snoremap <ESC> <ESC>:NeoSnippetClearMarkers<CR>
"}}}
"}}}
