" Vim color file {{{
" Maintainer:  Hans Fugal <hans@fugal.net>
" Last Change: $Date: 2004/06/13 19:30:30 $
" Last Change: $Date: 2004/06/13 19:30:30 $
" URL:         http://hans.fugal.net/vim/colors/desert.vim
" Version:     $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $
"}}}
set t_Co=16 background=dark
hi clear
syntax reset
if exists('g:colors_name')
    finish
endif
let g:colors_name = 'desert'
" color terminal definitions {{{
hi Normal       cterm=NONE           gui=NONE           ctermfg=White     guifg=White     ctermbg=Black    guibg=Black
hi Comment      cterm=NONE           gui=NONE           ctermfg=Red       guifg=Red       ctermbg=NONE     guibg=NONE
hi Constant     cterm=NONE           gui=NONE           ctermfg=Brown     guifg=Brown
hi CursorColumn cterm=NONE           gui=NONE           ctermfg=Black     guifg=Black     ctermbg=Grey     guibg=Grey
hi CursorLine   cterm=underline      gui=underline      ctermfg=NONE      guifg=NONE      ctermbg=NONE     guibg=NONE
hi CursorLineNr cterm=reverse        gui=reverse        ctermfg=NONE      guifg=NONE      ctermbg=NONE     guibg=NONE
hi DiffAdd      cterm=NONE           gui=NONE                                             ctermbg=Blue     guibg=Blue
hi DiffChange   cterm=NONE           gui=NONE                                             ctermbg=Magenta  guibg=Magenta
hi DiffDelete   cterm=bold           gui=bold           ctermfg=Blue      guifg=Blue      ctermbg=Cyan     guibg=Cyan
hi DiffText     cterm=bold           gui=bold                                             ctermbg=Red      guibg=Red
hi Directory    cterm=NONE           gui=NONE           ctermfg=DarkCyan  guifg=DarkCyan
hi Error        cterm=bold           gui=bold           ctermfg=White     guifg=White     ctermbg=Red      guibg=Red
hi ErrorMsg     cterm=bold           gui=bold           ctermfg=White     guifg=White     ctermbg=Red      guibg=Red
hi FoldColumn   cterm=NONE           gui=NONE           ctermfg=DarkGrey  guifg=DarkGrey  ctermbg=NONE     guibg=NONE
hi Folded       cterm=NONE           gui=NONE           ctermfg=Blue      guifg=Blue      ctermbg=NONE     guibg=NONE
hi Identifier   cterm=NONE           gui=NONE           ctermfg=Cyan      guifg=Cyan
hi Ignore       cterm=bold           gui=bold           ctermfg=White     guifg=White
hi IncSearch    cterm=NONE           gui=NONE           ctermfg=Yellow    guifg=Yellow    ctermbg=Green    guibg=Green
hi LineNr       cterm=NONE           gui=NONE           ctermfg=Yellow    guifg=Yellow
hi ModeMsg      cterm=NONE           gui=NONE           ctermfg=Brown     guifg=Brown
hi NonText      cterm=bold           gui=bold           ctermfg=DarkBlue  guifg=DarkBlue
hi Pmenu        cterm=NONE           gui=NONE           ctermfg=DarkGrey  guifg=DarkGrey  ctermbg=White    guibg=White
hi PmenuSel     cterm=NONE           gui=NONE           ctermfg=Magenta   guifg=Magenta   ctermbg=Black    guibg=Black
hi PreProc      cterm=NONE           gui=NONE           ctermfg=Magenta   guifg=Magenta
hi Question     cterm=NONE           gui=NONE           ctermfg=Green     guifg=Green
hi Search       cterm=NONE           gui=NONE           ctermfg=Grey      guifg=Grey      ctermbg=Blue     guibg=Blue
hi Special      cterm=NONE           gui=NONE           ctermfg=Magenta   guifg=Magenta
hi SpecialKey   cterm=NONE           gui=NONE           ctermfg=DarkGreen guifg=DarkGreen
hi Statement    cterm=NONE           gui=NONE           ctermfg=Yellow    guifg=Yellow
hi StatusLine   cterm=NONE           gui=NONE           ctermfg=Black     guifg=Black     ctermbg=Grey     guibg=Grey
hi StatusLineNC cterm=NONE           gui=NONE           ctermfg=White     guifg=White     ctermbg=DarkGrey guibg=DarkBlue
hi TabLine      cterm=NONE           gui=NONE           ctermfg=White     guifg=White     ctermbg=Black    guibg=Black
hi TabLineSel   cterm=NONE           gui=NONE           ctermfg=Black     guifg=Black     ctermbg=Magenta  guibg=Magenta
hi Title        cterm=NONE           gui=NONE           ctermfg=Magenta   guifg=Magenta
hi Type         cterm=NONE           gui=NONE           ctermfg=Green     guifg=Green
hi Underlined   cterm=underline      gui=underline      ctermfg=Magenta   guifg=Magenta
hi VertSplit    cterm=reverse        gui=reverse
hi Visual       cterm=NONE           gui=NONE           ctermfg=Yellow    guifg=Yellow
hi VisualNOS    cterm=bold,underline gui=bold,underline
hi WarningMsg   cterm=NONE           gui=NONE           ctermfg=Red       guifg=Red       ctermbg=NONE     guibg=NONE
hi WildMenu     cterm=NONE           gui=NONE           ctermfg=DarkGrey  guifg=DarkGrey  ctermbg=Yellow   guibg=Yellow
"}}}
" my highlight {{{
hi CrString        cterm=NONE      gui=NONE      ctermbg=DarkGrey guibg=DarkGrey
hi CrlfString      cterm=NONE      gui=NONE      ctermbg=DarkGrey guibg=DarkGrey
hi QFError         cterm=underline gui=underline ctermfg=Magenta  guifg=Magenta
hi TabString       cterm=NONE      gui=NONE      ctermbg=DarkGrey guibg=DarkGrey
hi WhitespaceEOL   cterm=NONE      gui=NONE      ctermbg=DarkGrey guibg=DarkGrey
hi YankRoundRegion cterm=NONE      gui=NONE      ctermfg=Magenta  guifg=Magenta
"}}}
