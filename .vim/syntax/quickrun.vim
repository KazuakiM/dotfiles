if exists("b:current_syntax") | finish | endif
if !exists("main_syntax") | let main_syntax = 'quickrun' | endif

syntax case match

syntax match QuickrunOk       /.*OK.*/
highlight QuickrunOk       ctermfg=DarkGreen guifg=DarkGreen
syntax match QuickrunFailures /.*\(FAILURES\|failure\|Error\).*/
highlight QuickrunFailures ctermfg=DarkRed   guifg=DarkRed

let b:current_syntax = 'quickrun'
if main_syntax == 'quickrun' | unlet main_syntax | endif
