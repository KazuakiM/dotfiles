function! ale#statusline#Status() abort "{{{
    let l:errorDict = {'lnum': 9999, 'text': ''}
    let l:bufnr = bufnr('')
    if has_key(g:ale_buffer_info, l:bufnr) && has_key(g:ale_buffer_info[l:bufnr], 'loclist')
        for l:row in g:ale_buffer_info[l:bufnr].loclist
            if l:row.lnum <= l:errorDict.lnum
                let l:errorDict = {'lnum': l:row.lnum, 'text': l:row.text}
            endif
        endfor
        if l:errorDict.lnum < 9999
            return '[ ' . l:errorDict.lnum . ' ]' . l:errorDict.text
        endif
    endif
    return ''
endfunction "}}}
