"refer URL
" http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html
" http://vim.wikia.com/wiki/Better_indent_support_for_php_with_html
if exists("b:did_indent")         | finish | endif
if exists('s:doing_indent_inits') | finish | endif

let s:doing_indent_inits = 1
runtime! indent/html.vim
unlet b:did_indent
runtime! indent/php.vim
unlet s:doing_indent_inits

function! GetHtmlPhpIndent(lnum) "{{{
    let l:php_ind = GetPhpIndent()
    if l:php_ind > -1
        return l:php_ind
    endif
    if exists('*HtmlIndent')
        let l:html_ind = HtmlIndent()
    else
        let l:html_ind = HtmlIndentGet(a:lnum)
    endif
    if l:html_ind > -1
        if getline(a:lnum) =~ "^<?" && (0< searchpair('<?', '', '?>', 'nWb') || 0 < searchpair('<?', '', '?>', 'nW'))
            return -1
        endif
        return l:html_ind
    endif
    return -1
endfunction "}}}
setlocal indentexpr=GetHtmlPhpIndent(v:lnum)

if !exists('b:undo_indent') | let b:undo_indent = '' | endif
let b:undo_indent .= '| setlocal '.join(['indentexpr<',])
