set t_Co=16 background=dark
hi clear
syntax reset
if exists('g:colors_name')
    finish
endif
let g:colors_name = 'kazuakim'
" color terminal definitions {{{
highlight Normal       cterm=NONE           gui=NONE           ctermfg=White        guifg=White        ctermbg=Black    guibg=Black
highlight Comment      cterm=NONE           gui=NONE           ctermfg=LightRed     guifg=LightRed     ctermbg=NONE     guibg=NONE
highlight Constant     cterm=NONE           gui=NONE           ctermfg=LightRed     guifg=LightRed     ctermbg=NONE     guibg=NONE
highlight Cursor       cterm=NONE           gui=NONE           ctermfg=NONE         guifg=Black        ctermbg=NONE     guibg=White
highlight CursorColumn cterm=NONE           gui=NONE           ctermfg=Black        guifg=Black        ctermbg=Grey     guibg=Grey
highlight CursorLine   cterm=underline      gui=underline      ctermfg=NONE         guifg=NONE         ctermbg=NONE     guibg=NONE
highlight CursorLineNr cterm=reverse        gui=reverse        ctermfg=NONE         guifg=NONE         ctermbg=NONE     guibg=NONE
highlight DiffAdd      cterm=NONE           gui=NONE           ctermfg=Cyan         guifg=Cyan         ctermbg=DarkGrey guibg=DarkGrey
highlight DiffChange   cterm=NONE           gui=NONE           ctermfg=White        guifg=White        ctermbg=DarkGrey guibg=DarkGrey
highlight DiffDelete   cterm=NONE           gui=NONE           ctermfg=NONE         guifg=NONE         ctermbg=DarkRed  guibg=DarkRed
highlight DiffText     cterm=NONE           gui=NONE           ctermfg=Red          guifg=Red          ctermbg=DarkGrey guibg=DarkGrey
highlight Directory    cterm=NONE           gui=NONE           ctermfg=DarkCyan     guifg=DarkCyan     ctermbg=NONE     guibg=NONE
highlight Error        cterm=bold           gui=bold           ctermfg=White        guifg=White        ctermbg=Red      guibg=Red
highlight ErrorMsg     cterm=bold           gui=bold           ctermfg=White        guifg=White        ctermbg=Red      guibg=Red
highlight FoldColumn   cterm=NONE           gui=NONE           ctermfg=DarkGrey     guifg=DarkGrey     ctermbg=NONE     guibg=NONE
highlight Folded       cterm=NONE           gui=NONE           ctermfg=Blue         guifg=Blue         ctermbg=NONE     guibg=NONE
highlight Identifier   cterm=NONE           gui=NONE           ctermfg=Cyan         guifg=Cyan         ctermbg=NONE     guibg=NONE
highlight Ignore       cterm=bold           gui=bold           ctermfg=White        guifg=White        ctermbg=NONE     guibg=NONE
highlight IncSearch    cterm=NONE           gui=NONE           ctermfg=Yellow       guifg=Yellow       ctermbg=Green    guibg=Green
highlight LineNr       cterm=NONE           gui=NONE           ctermfg=Yellow       guifg=Yellow       ctermbg=NONE     guibg=NONE
highlight ModeMsg      cterm=NONE           gui=NONE           ctermfg=Red          guifg=Red          ctermbg=NONE     guibg=NONE
highlight NonText      cterm=bold           gui=bold           ctermfg=DarkBlue     guifg=DarkBlue     ctermbg=NONE     guibg=NONE
highlight Pmenu        cterm=NONE           gui=NONE           ctermfg=DarkGrey     guifg=DarkGrey     ctermbg=White    guibg=White
highlight PmenuSel     cterm=NONE           gui=NONE           ctermfg=Magenta      guifg=Magenta      ctermbg=Black    guibg=Black
highlight PreProc      cterm=NONE           gui=NONE           ctermfg=LightMagenta guifg=LightMagenta ctermbg=NONE     guibg=NONE
highlight Question     cterm=NONE           gui=NONE           ctermfg=Green        guifg=Green        ctermbg=NONE     guibg=NONE
highlight Search       cterm=NONE           gui=NONE           ctermfg=Grey         guifg=Grey         ctermbg=Blue     guibg=Blue
highlight SignColumn   cterm=NONE           gui=NONE           ctermfg=Grey         guifg=Grey         ctermbg=Black    guibg=Black
highlight Special      cterm=NONE           gui=NONE           ctermfg=LightMagenta guifg=LightMagenta ctermbg=NONE     guibg=NONE
highlight SpecialKey   cterm=NONE           gui=NONE           ctermfg=DarkGreen    guifg=DarkGreen    ctermbg=NONE     guibg=NONE
highlight SpellBad     cterm=NONE           gui=NONE           ctermfg=Red          guifg=Red          ctermbg=White    guibg=White
highlight SpellCap     cterm=NONE           gui=NONE           ctermfg=Blue         guifg=Blue         ctermbg=White    guibg=White
highlight SpellRare    cterm=NONE           gui=NONE           ctermfg=Magenta      guifg=Magenta      ctermbg=NONE     guibg=NONE
highlight Statement    cterm=NONE           gui=NONE           ctermfg=Yellow       guifg=Yellow       ctermbg=NONE     guibg=NONE
highlight StatusLine   cterm=NONE           gui=NONE           ctermfg=Black        guifg=Black        ctermbg=Grey     guibg=Grey
highlight StatusLineNC cterm=NONE           gui=NONE           ctermfg=White        guifg=White        ctermbg=DarkGrey guibg=DarkBlue
highlight TabLine      cterm=NONE           gui=NONE           ctermfg=White        guifg=White        ctermbg=Black    guibg=Black
highlight TabLineSel   cterm=NONE           gui=NONE           ctermfg=Black        guifg=Black        ctermbg=Cyan     guibg=Cyan
highlight Title        cterm=NONE           gui=NONE           ctermfg=LightMagenta guifg=LightMagenta ctermbg=NONE     guibg=NONE
highlight Type         cterm=NONE           gui=NONE           ctermfg=Green        guifg=Green        ctermbg=NONE     guibg=NONE
highlight Underlined   cterm=underline      gui=underline      ctermfg=LightMagenta guifg=LightMagenta ctermbg=NONE     guibg=NONE
highlight VertSplit    cterm=reverse        gui=reverse
highlight Visual       cterm=NONE           gui=NONE           ctermfg=Yellow       guifg=Yellow       ctermbg=DarkGrey guibg=DarkGrey
highlight VisualNOS    cterm=bold,underline gui=bold,underline
highlight WarningMsg   cterm=NONE           gui=NONE           ctermfg=Red          guifg=Red          ctermbg=NONE     guibg=NONE
highlight WildMenu     cterm=NONE           gui=NONE           ctermfg=DarkGrey     guifg=DarkGrey     ctermbg=Yellow   guibg=Yellow
"}}}
" my highlight {{{
highlight KazuakiMCheckString cterm=NONE      gui=NONE      ctermbg=DarkGrey guibg=DarkGrey
highlight KazuakiMQFError     cterm=underline gui=underline ctermfg=Magenta  guifg=Magenta
highlight KazuakiMInfo        cterm=NONE      gui=NONE      ctermfg=Black    guifg=Black ctermbg=Green  guibg=Green
highlight KazuakiMWarning     cterm=NONE      gui=NONE      ctermfg=Black    guifg=Black ctermbg=Yellow guibg=Yellow
highlight KazuakiMError       cterm=NONE      gui=NONE      ctermbg=Red      guibg=Red
highlight YankRoundRegion     cterm=NONE      gui=NONE      ctermfg=Magenta  guifg=Magenta
highlight default link KazuakiMTodo Todo
"}}}
