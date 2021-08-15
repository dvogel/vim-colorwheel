" Vim color file
" Maintainer:	Drew Vogel <drewpvogel@gmail.com>
" Last Change:	August 9, 2021
" Licence:	    Public Domain

" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  " syntax reset
endif

let colors_name = "tetradic"

if !exists("g:tetradic_base")
	let g:tetradic_base = [0, 0.80, 0.50]
endif

runtime colors/lists/tetradic.vim

hi Normal guifg=tetradic_gray4 guibg=#111111 gui=NONE
hi Comment guifg=tetradic_gray3 gui=NONE
hi PreProc guifg=tetradic_comp_secondary4_tint gui=NONE
hi Identifier guifg=tetradic_comp_secondary3_tint gui=NONE
hi Type guifg=tetradic_comp2_shade gui=NONE
hi Function guifg=tetradic_secondary4_pure gui=NONE
hi Statement guifg=tetradic_secondary4_pure gui=NONE
hi Exception guifg=tetradic_secondary2_pure gui=NONE
hi Repeat guifg=tetradic_comp3_pure gui=NONE
hi Conditional guifg=tetradic_comp3_pure gui=NONE
hi Operator guifg=tetradic_secondary3_pure gui=NONE

hi Constant guifg=tetradic_comp_secondary4_tint gui=NONE
hi String guifg=tetradic_comp_secondary1_tint gui=NONE
hi Number guifg=tetradic_comp_secondary2_tint gui=NONE
hi Float guifg=tetradic_comp_secondary2_tint gui=NONE
hi Boolean guifg=tetradic_comp_secondary1_tint gui=NONE
hi Special guifg=tetradic_secondary4_pure gui=NONE
hi Search guifg=tetradic_gray1 guibg=tetradic_comp_secondary4_pure gui=NONE


"hi ErrorMsg guibg=drew_red guifg=drew_ltgray
"hi Error guibg=drew_red guifg=drew_ltgray
"hi IncSearch guibg=drew_tan guifg=drew_darkgray
"hi ModeMsg gui=bold
"hi StatusLine gui=reverse,bold
"hi StatusLineNC gui=reverse
"hi VertSplit guibg=drew_ltgray
"hi Visual gui=reverse guifg=NONE guibg=NONE
"hi VisualNOS gui=underline,bold
"hi DiffText gui=bold guibg=Red
"hi Cursor guibg=NONE guifg=NONE gui=inverse
"hi lCursor guibg=drew_cyan guifg=NONE
"hi Directory guifg=Blue
"hi LineNr guifg=drew_babyyellow
"hi MoreMsg gui=bold guifg=SeaGreen
"hi NonText gui=bold guifg=Blue guibg=Black
"hi Question gui=bold guifg=SeaGreen
"hi Search guibg=drew_tan guifg=drew_darkgray
"hi SpecialKey guifg=Blue
"hi Title gui=bold guifg=Magenta
"hi WarningMsg guifg=Red
"hi WildMenu guibg=Cyan guifg=Black
"hi Folded guibg=DarkBlue guifg=Grey
"hi FoldColumn guibg=Grey guifg=DarkBlue
"hi DiffAdd guibg=LightBlue
"hi DiffChange guibg=LightMagenta
"hi DiffDelete gui=bold guifg=Blue guibg=LightCyan


"hi Constant guifg=drew_cyan
"hi Statement gui=NONE guifg=drew_red
"hi Special guifg=#BB00BB guibg=Black ctermfg=Yellow
"hi Ignore guifg=Grey

"hi link IncSearch		Visual
"hi link String			Constant
"hi link Character		Constant
"hi link Number			Constant
"hi link Boolean			Constant
"hi link Float			Number
"" hi link Function		Identifier
"hi link Conditional		Statement
"hi link Repeat			Statement
"hi link Label			Statement
"hi link Operator		Statement
"hi link Keyword			Statement
"hi link Exception		Statement
"hi link Include			PreProc
"hi link Define			PreProc
"hi link Macro			PreProc
"hi link PreCondit		PreProc
"hi link StorageClass	Type
"hi link Structure		Type
"hi link Typedef			Type
"hi link Tag				Special
"hi link SpecialChar		Special
"hi link Delimiter		Special
"hi link SpecialComment	Special
"hi link Debug			Special

"" vim: sw=2

"hi foldcolumn guibg=NONE guifg=NONE
"hi SignColumn guibg=drew_darkgray guifg=drew_red



"hi Delimiter     gui=NONE   guifg=drew_babyyellow

"highlight Pmenu      ctermfg=7  ctermbg=0  guibg=#444444 guifg=#dddddd
"highlight PmenuSbar  ctermfg=7  ctermbg=7  guibg=#666666 guifg=#ffffff
"highlight PmenuSel   ctermfg=1  ctermbg=7  guibg=#888888 guifg=#dd0000
"highlight PmenuThumb ctermbg=14 ctermbg=14 guibg=#ffff00 guifg=#00ffff

"hi NERDTreeOpenable   gui=NONE   guifg=drew_skyblue
"hi NERDTreeClosable   gui=NONE   guifg=drew_skyblue
"hi NERDTreeDir        gui=NONE   guifg=drew_peach

"hi CtrlPPrtCursor guifg=drew_mtdew

"hi CursorLine guifg=#ffffff guibg=#444444
"hi Todo gui=REVERSE,BOLD guifg=drew_firebrick guibg=drew_babyyellow
