" Vim color file {{{
" Maintainer:  Hans Fugal <hans@fugal.net>
" Last Change: $Date: 2004/06/13 19:30:30 $
" Last Change: $Date: 2004/06/13 19:30:30 $
" URL:         http://hans.fugal.net/vim/colors/desert.vim
" Version:     $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $
"}}}

let g:colors_name='desert'
hi Normal guifg=White guibg=grey20

" highlight groups {{{
hi Cursor       guifg=slategrey   guibg=khaki
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit    guifg=grey50      guibg=#c2bfa5   gui=NONE
hi IncSearch    guifg=slategrey   guibg=khaki
"hi LineNr
hi ModeMsg      guifg=goldenrod
hi MoreMsg      guifg=SeaGreen
hi NonText      guifg=LightBlue   guibg=grey30
hi Question     guifg=springgreen
hi Search       guifg=wheat       guibg=peru
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guifg=black       guibg=#c2bfa5   gui=NONE
hi Title        guifg=indianred
hi Visual       guifg=khaki       guibg=olivedrab gui=NONE
"hi VisualNOS
hi WarningMsg   guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip
"}}}
" syntax highlighting groups {{{
hi Constant    guifg=#ffa0a0
hi Identifier  guifg=palegreen
hi Statement   guifg=khaki
hi PreProc     guifg=indianred
hi Type        guifg=darkkhaki
hi Special     guifg=navajowhite
"hi Underlined
hi Ignore      guifg=grey40
"hi Error
"}}}
" color terminal definitions {{{
hi SpecialKey                        ctermfg=DarkGreen
hi NonText      cterm=bold           ctermfg=DarkBlue
hi Directory                         ctermfg=DarkCyan
hi ErrorMsg     cterm=bold           ctermfg=7         ctermbg=1
hi IncSearch    cterm=NONE           ctermfg=Yellow    ctermbg=Green
hi Search       cterm=NONE           ctermfg=Grey      ctermbg=blue
hi MoreMsg                           ctermfg=DarkGreen
hi ModeMsg      cterm=NONE           ctermfg=Brown
hi LineNr                            ctermfg=3
hi Question                          ctermfg=Green
hi StatusLine   cterm=bold,reverse
hi StatusLineNC cterm=NONE           ctermbg=DarkGrey
hi VertSplit    cterm=reverse
hi Title                             ctermfg=5
hi Visual       cterm=reverse
hi VisualNOS    cterm=bold,underline
hi WarningMsg                        ctermfg=1
hi WildMenu                          ctermfg=0         ctermbg=3
hi Folded                            ctermfg=Blue      ctermbg=NONE
hi FoldColumn                        ctermfg=DarkGrey  ctermbg=NONE
hi DiffAdd                                             ctermbg=4
hi DiffChange                                          ctermbg=5
hi DiffDelete   cterm=bold           ctermfg=4         ctermbg=6
hi DiffText     cterm=bold                             ctermbg=1
hi Comment                           ctermfg=Blue
hi Constant                          ctermfg=Brown
hi Special                           ctermfg=5
hi Identifier                        ctermfg=6
hi Statement                         ctermfg=3
hi PreProc                           ctermfg=5
hi Type                              ctermfg=2
hi Underlined   cterm=underline      ctermfg=5
hi Ignore       cterm=bold           ctermfg=7
hi Ignore                            ctermfg=DarkGrey
hi Error        cterm=bold           ctermfg=7         ctermbg=1
hi CursorLine   cterm=NONE           ctermfg=Cyan
hi CursorLineNr cterm=NONE           ctermfg=Cyan
hi Pmenu                             ctermfg=DarkGrey  ctermbg=White
hi PmenuSel                          ctermfg=Magenta   ctermbg=Black
"}}}
" my highlight {{{
hi TabString       cterm=NONE      ctermbg=DarkGrey
hi CrString        cterm=NONE      ctermbg=DarkGrey
hi CrlfString      cterm=NONE      ctermbg=DarkGrey
hi WhitespaceEOL   cterm=NONE      ctermbg=DarkGrey
hi YankRoundRegion cterm=NONE      ctermfg=Magenta
hi QFError         cterm=underline ctermfg=Magenta
"}}}
