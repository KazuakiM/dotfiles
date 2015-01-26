" Vim color file
" Maintainer:  Hans Fugal <hans@fugal.net>
" Last Change: $Date: 2004/06/13 19:30:30 $
" Last Change: $Date: 2004/06/13 19:30:30 $
" URL:         http://hans.fugal.net/vim/colors/desert.vim
" Version:     $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
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
hi VertSplit    guifg=grey50      guibg=#c2bfa5   gui=none
hi Folded       guifg=gold        guibg=grey30
hi FoldColumn   guifg=tan         guibg=grey30
hi IncSearch    guifg=slategrey   guibg=khaki
"hi LineNr
hi ModeMsg      guifg=goldenrod
hi MoreMsg      guifg=SeaGreen
hi NonText      guifg=LightBlue   guibg=grey30
hi Question     guifg=springgreen
hi Search       guifg=wheat       guibg=peru
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guifg=black       guibg=#c2bfa5   gui=none
hi StatusLineNC guifg=grey50      guibg=#c2bfa5   gui=none
hi Title        guifg=indianred
hi Visual       guifg=khaki       guibg=olivedrab gui=none
"hi VisualNOS
hi WarningMsg   guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip
"}}}
" syntax highlighting groups {{{
hi Comment     guifg=SkyBlue
hi Constant    guifg=#ffa0a0
hi Identifier  guifg=palegreen
hi Statement   guifg=khaki
hi PreProc     guifg=indianred
hi Type        guifg=darkkhaki
hi Special     guifg=navajowhite
"hi Underlined
hi Ignore      guifg=grey40
"hi Error
hi Todo        guifg=orangered   guibg=yellow2
"}}}
" color terminal definitions {{{
hi SpecialKey                        ctermfg=darkgreen
hi NonText      cterm=bold           ctermfg=darkblue
hi Directory                         ctermfg=darkcyan
hi ErrorMsg     cterm=bold           ctermfg=7         ctermbg=1
hi IncSearch    cterm=NONE           ctermfg=yellow    ctermbg=green
hi Search       cterm=NONE           ctermfg=grey      ctermbg=blue
hi MoreMsg                           ctermfg=darkgreen
hi ModeMsg      cterm=NONE           ctermfg=brown
hi LineNr                            ctermfg=3
hi Question                          ctermfg=green
hi StatusLine   cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit    cterm=reverse
hi Title                             ctermfg=5
hi Visual       cterm=reverse
hi VisualNOS    cterm=bold,underline
hi WarningMsg                        ctermfg=1
hi WildMenu                          ctermfg=0         ctermbg=3
hi Folded                            ctermfg=darkgrey  ctermbg=NONE
hi FoldColumn                        ctermfg=darkgrey  ctermbg=NONE
hi DiffAdd                                             ctermbg=4
hi DiffChange                                          ctermbg=5
hi DiffDelete   cterm=bold           ctermfg=4         ctermbg=6
hi DiffText     cterm=bold                             ctermbg=1
hi Comment                           ctermfg=darkcyan
hi Constant                          ctermfg=brown
hi Special                           ctermfg=5
hi Identifier                        ctermfg=6
hi Statement                         ctermfg=3
hi PreProc                           ctermfg=5
hi Type                              ctermfg=2
hi Underlined   cterm=underline      ctermfg=5
hi Ignore       cterm=bold           ctermfg=7
hi Ignore                            ctermfg=darkgrey
hi Error        cterm=bold           ctermfg=7         ctermbg=1
"}}}
