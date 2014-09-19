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
" context_filetype.vim {{{
" Set php filetype(HTML default_filetype + PHP), and setlocal html filetype.
" add .vimrc.local ( views/**/*.php is html filetype).
let g:context_filetype#filetypes = {
\    'php': [
\        {
\            'start': '<script>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)charset="[^\"]*"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<style\%( [^>]*\)\? type="text/css"\%( [^>]*\)\?>',
\            'end':   '</style>', 'filetype': 'css',},
\        {
\            'start': '<SQL',
\            'end':   'SQL;', 'filetype': 'php',},
\        {
\            'start': '<\/\a\{-}\|<\a\{-1}',
\            'end':   '>', 'filetype': 'html',},],
\    'html': [
\        {
\            'start': '<script>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)charset="[^\"]*"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'javascript',},
\        {
\            'start': '<script\%( [^>]*\)\? type="text/coffeescript"\%( [^>]*\)\?>',
\            'end':   '</script>', 'filetype': 'coffee',},
\        {
\            'start': '<style\%( [^>]*\)\? type="text/css"\%( [^>]*\)\?>',
\            'end':   '</style>', 'filetype': 'css',},
\        {
\            'start': '<?',
\            'end':   '?>', 'filetype': 'php',},],}
"}}}
" vim-sqlfix(local file refer) {{{
NeoBundle 'vim-sqlfix', {
\    'base': '/srv/vim-plugin',
\    'type': 'nosync',}
"}}}
" neosnippet.vim {{{
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
"}}}

