vim9script

# Vim color file
# Maintainer:	Drew Vogel <drewpvogel@gmail.com>
# Last Change:	August 9, 2021
# Licence:	    Public Domain

# First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  # syntax reset
endif

var colors_name = "tetradic"

if !exists("g:tetradic_base")
	g:tetradic_base = [0.0, 0.80, 0.50]
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


