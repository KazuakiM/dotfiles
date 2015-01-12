let s:save_cpo = &cpo
set cpo&vim

let s:source = {'name': 'ultisnips', 'kind': 'keyword', 'rank': 8, 'hooks': {}, 'matchers': (g:neocomplete#enable_fuzzy_completion ? ['matcher_fuzzy'] : ['matcher_head'])}
function! s:source.gather_candidates(context) "{{{
    let a:suggestions = []
    let a:snippets    = UltiSnips#SnippetsInCurrentScope()
    for a:trigger in keys(a:snippets)
        call add(a:suggestions, {'word': a:trigger, 'menu': '[K]'.get(a:snippets, a:trigger)})
    endfor
    return a:suggestions
endfunction "}}}
function! neocomplete#sources#ultisnips#define() "{{{
    return s:source
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo
