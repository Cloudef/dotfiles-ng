" Author:      Jari Vetoniemi (Cloudef)
" Description: Colorshceme modified from slate
" Usage:       This colorscheme is meant only for use with vim in a terminal

" .Xresources for urxvt/xterm
"
" *foreground: #CACACA
" *background: #121212

" !black
" *color0: #1C1C1C
" *color8: #4d4d4d
" !red
" *color1: #D81860
" *color9: #F00060
" !green
" *color2:  #B7CE42
" *color10: #BDE077
" !yellow
" *color3:  #FEA63C
" *color11: #FFE863
" !blue
" *color4:  #66AABB
" *color12: #AACCBB
" !magenta
" *color5:  #B7416E
" *color13: #BB4466
" !cyan
" *color6:  #5E7175
" *color14: #A3BABF
" !white
" *color7:  #DDEEDD
" *color15: #6C887A

set bg=dark
hi clear
let colors_name = 'colorshot'

" General colors
hi Normal      guifg=#F8F8F8 guibg=#12384B gui=NONE
hi NonText     guifg=#A3FEFE gui=NONE      ctermfg=blue

hi Cursor      guifg=NONE  guibg=#8BA7A7
hi LineNr      guifg=#B0B3B9  gui=bold ctermfg=darkgray cterm=bold

hi VertSplit   guifg=#F8F8F8  guibg=#0F2130  gui=NONE ctermfg=lightgray ctermbg=black cterm=NONE

hi Visual      guibg=#B0C3DA  ctermbg=cyan

hi Title       guifg=#F1B356  guibg=NONE ctermfg=magenta ctermbg=NONE
hi WildMenu    guifg=#0F2130  guibg=#B0B3B9 ctermfg=black ctermbg=lightgray
hi ErrorMsg    guifg=#F8F8F8  guibg=#D22613	gui=bold ctermfg=lightgray ctermbg=darkred cterm=bold
hi WarningMsg  guifg=#F4EF82  guibg=#0F2130	gui=bold ctermfg=yellow ctermbg=black cterm=bold

hi ModeMsg     guifg=#B0B3B9 guibg=#0F2130 gui=bold ctermfg=lightgray ctermbg=black cterm=bold

if version >= 700 " Vim 7 specific colors
   hi CursorLine  guibg=#0F2130 ctermbg=black cterm=NONE
   hi! link CursorColumn CursorLine
   hi MatchParen  guifg=#0F2130 guibg=#B0B3B9 ctermfg=black ctermbg=lightgray
   hi Search      guifg=NONE guibg=NONE gui=inverse ctermfg=NONE ctermbg=NONE cterm=inverse
endif

hi Pmenu       guifg=#000000  guibg=#F8F8F8 ctermfg=black ctermbg=lightgray
hi PmenuSbar   guifg=#8A95A7  guibg=#F8F8F8	gui=NONE ctermfg=darkcyan ctermbg=lightgray	cterm=NONE
hi PmenuThumb  guifg=#F8F8F8  guibg=#8A95A7	gui=NONE ctermfg=lightgray ctermbg=darkcyan	cterm=NONE

" Syntax highlighting
hi Comment  guifg=#2C9ADE gui=italic ctermfg=darkblue
hi String   guifg=#7CDE53 ctermfg=darkgreen

hi Keyword  guifg=#ffa705 ctermfg=darkmagenta
hi PreProc  guifg=#f1994a ctermfg=magenta

hi Todo     guifg=#abc4dd guibg=NONE ctermfg=cyan ctermbg=NONE
hi Constant guifg=#fa6870 ctermfg=red

hi Identifier  guifg=#f1994a ctermfg=magenta cterm=NONE
hi Type        guifg=#f5f16e gui=NONE ctermfg=yellow
hi Statement   guifg=#f1994a gui=NONE ctermfg=magenta

hi Special     guifg=#84f796 ctermfg=green
hi Delimiter   guifg=#f1994a gui=NONE ctermfg=magenta

hi  link Number         Constant
hi! link StatusLine     VertSplit
hi! link StatusLineNC   VertSplit
hi! link Question       Special
hi! link MoreMsg        Special
hi! link Folded         Normal

hi link Operator        Delimiter
hi Function	ctermfg=3
hi link PmenuSel        PmenuThumb
hi link Error           ErrorMsg
hi link Conditional     Keyword
hi link Character       String
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special

" Ruby
hi link rubyClass             Keyword
hi link rubyModule            Keyword
hi link rubyKeyword           Keyword
hi link rubyOperator          Operator
hi link rubyIdentifier        Identifier
hi link rubyInstanceVariable  Identifier
hi link rubyGlobalVariable    Identifier
hi link rubyClassVariable     Identifier
hi link rubyConstant          Type

" HTML/XML
hi link xmlTag             HTML
hi link xmlTagName         HTML
hi link xmlEndTag          HTML
hi link htmlTag            HTML
hi link htmlTagName        HTML
hi link htmlSpecialTagName HTML
hi link htmlEndTag         HTML
hi link HTML               NonText

" JavaScript
hi link javaScriptNumber   Number

" Objc
hi link objcDirective      Type
hi objcMethodName ctermfg=darkyellow guifg=#eceb00

" CSS
hi link cssBraces          Normal
hi link cssTagName         NonText
hi link StorageClass       Special
hi link cssClassName       Special
hi link cssIdentifier      Identifier
hi link cssColor           Type
hi link cssValueInteger    Type
hi link cssValueNumber     Type
hi link cssValueLength     Type
hi cssPseudoClassId guifg=#eceb00 ctermfg=darkyellow

hi clear SpellBad
hi SpellBad ctermfg=red term=underline cterm=underline
hi clear SpellCap
hi SpellCap term=underline cterm=underline
hi clear SpellRare
hi SpellRare term=underline cterm=underline
hi clear SpellLocal
hi SpellLocal term=underline cterm=underline

" vim: set ts=4 sw=4 tw=78 :
