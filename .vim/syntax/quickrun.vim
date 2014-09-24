if exists("b:current_syntax") | finish | endif
if !exists("main_syntax") | let main_syntax = 'quickrun' | endif

syntax case match

syntax match PhpUnitOk       /OK.*/
highlight PhpUnitOk       ctermfg=DarkGreen
syntax match PhpUnitFailures /FAILURES.*\|.*failure:/
highlight PhpUnitFailures ctermfg=DarkRed

let b:current_syntax = 'quickrun'
if main_syntax == 'quickrun' | unlet main_syntax | endif
