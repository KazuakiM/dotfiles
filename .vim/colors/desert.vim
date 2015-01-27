" Vim color file {{{
" Maintainer:  Hans Fugal <hans@fugal.net>
" Last Change: $Date: 2004/06/13 19:30:30 $
" Last Change: $Date: 2004/06/13 19:30:30 $
" URL:         http://hans.fugal.net/vim/colors/desert.vim
" Version:     $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $
"}}}
if exists('g:colors_name')
    finish
endif
let g:colors_name = 'desert'

" color terminal definitions {{{
hi Comment                           ctermfg=Blue
hi Constant                          ctermfg=Brown
hi CursorLine   cterm=NONE           ctermfg=Cyan
hi CursorLineNr cterm=NONE           ctermfg=Cyan
hi DiffAdd                                               ctermbg=Blue
hi DiffChange                                            ctermbg=Magenta
hi DiffDelete   cterm=bold           ctermfg=Blue        ctermbg=Cyan
hi DiffText     cterm=bold                               ctermbg=Red
hi Directory                         ctermfg=DarkCyan
hi Error        cterm=bold           ctermfg=White       ctermbg=Red
hi ErrorMsg     cterm=bold           ctermfg=White       ctermbg=Red
hi FoldColumn                        ctermfg=DarkGrey    ctermbg=NONE
hi Folded                            ctermfg=Blue        ctermbg=NONE
hi Identifier                        ctermfg=Cyan
hi Ignore       cterm=bold           ctermfg=White
hi IncSearch    cterm=NONE           ctermfg=Yellow      ctermbg=Green
hi LineNr                            ctermfg=Yellow
hi ModeMsg      cterm=NONE           ctermfg=Brown
hi NonText      cterm=bold           ctermfg=DarkBlue
hi Pmenu                             ctermfg=DarkGrey    ctermbg=White
hi PmenuSel                          ctermfg=Magenta     ctermbg=Black
hi PreProc                           ctermfg=Magenta
hi Question                          ctermfg=Green
hi Search       cterm=NONE           ctermfg=Grey        ctermbg=blue
hi Special                           ctermfg=Magenta
hi SpecialKey                        ctermfg=DarkGreen
hi Statement                         ctermfg=Yellow
hi StatusLine   cterm=bold,reverse
hi StatusLineNC cterm=NONE                               ctermbg=DarkGrey
hi TabLine      cterm=NONE           ctermfg=DarkGrey    ctermbg=Black
hi TabLineSel   cterm=NONE           ctermfg=Black       ctermbg=Magenta
hi Title                             ctermfg=Magenta
hi Type                              ctermfg=Green
hi Underlined   cterm=underline      ctermfg=Magenta
hi VertSplit    cterm=reverse
hi Visual       cterm=NONE           ctermfg=Yellow
hi VisualNOS    cterm=bold,underline
hi WarningMsg                        ctermfg=Red
hi WildMenu                          ctermfg=DarkGrey    ctermbg=Yellow
"}}}
" my highlight {{{
hi CrString        cterm=NONE      ctermbg=DarkGrey
hi CrlfString      cterm=NONE      ctermbg=DarkGrey
hi QFError         cterm=underline ctermfg=Magenta
hi TabString       cterm=NONE      ctermbg=DarkGrey
hi WhitespaceEOL   cterm=NONE      ctermbg=DarkGrey
hi YankRoundRegion cterm=NONE      ctermfg=Magenta
"}}}
