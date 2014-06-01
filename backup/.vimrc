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
"}}}
"
"
" NeoBundleLazy
"----------------------------------------------------------------------------------------------------------------------------------
"{{{
" neosnippet.vim
" vim-snippets @ honza's fork. Anded add folding function. {{{
NeoBundleLazy 'Shougo/neosnippet.vim', {
\    'depends': 'KazuakiM/vim-snippets',
\    'autoload': {
\        'insert': 1,},}
let s:hooks = neobundle#get_hooks('neosnippet.vim')
function! s:hooks.on_source(bundle)
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
    let g:neosnippet#disable_runtime_snippets = {
    \    '_' : 1,}
    let g:neosnippet#data_directory=$HOME.'/.vim/neosnippet'
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/vim-snippets/snippets'
endfunction
unlet s:hooks
"}}}
"}}}

