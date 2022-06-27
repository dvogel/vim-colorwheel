vim9script

# B = base, S = secondary, C = complementary, Q = secondary complementary, G = gray
# S = shade (darker), P = pure (natural color), T = tint (lighter)
# 1-4 = saturation levels for colors, lightness for grays

# >> BS1 BS2 BS3 BS4 BP1 BP2 BP3 BP4 BT1 BT2 BT3 BT4 <<
# >> SS1 SS2 SS3 SS4 SP1 SP2 SP3 SP4 ST1 ST2 ST3 ST4 <<
# >> CS1 CS2 CS3 CS4 CP1 CP2 CP3 CP4 CT1 CT2 CT3 CT4 <<
# >> QS1 QS2 QS3 QS4 QP1 QP2 QP3 QP4 QT1 QT2 QT3 QT4 <<
# >> GG1 GG2 GG3 GG4 <<

var hue_names = {
	\ 'mid red': 0,
	\ 'warm red': 15,
	\ 'orange': 30,
	\ 'warm yellow': 45,
	\ 'mid yellow': 60,
	\ 'cool yellow': 75,
	\ 'yellow green': 90,
	\ 'warm green': 105,
	\ 'mid green': 120,
	\ 'cool green': 135,
	\ 'green cyan': 150,
	\ 'warm cyan': 165,
	\ 'mid cyan': 180,
	\ 'cool cyan': 195,
	\ 'blue cyan': 205,
	\ 'cool blue': 225,
	\ 'mid blue': 240,
	\ 'warm blue': 255,
	\ 'violet': 270,
	\ 'cool magenta': 285,
	\ 'mid magenta': 300,
	\ 'warm magenta': 315,
	\ 'red magenta': 330,
	\ 'cool red': 345,
	\ }

# g:tetradic_base = [hue_names['orange'], 0.87, 0.53]
g:tetradic_base = [21.7, 0.87, 0.53]
# g:tetradic_base = [325.0, 0.87, 0.53]

syn clear

colorscheme tetradic

syn region tetradicDemoComment start=/# >>/ end=/<</ contains=
            \ BS1,BS2,BS3,BS4,
            \ BP1,BP2,BP3,BP4,
            \ BT1,BT2,BT3,BT4,
            \ SS1,SS2,SS3,SS4,
            \ SP1,SP2,SP3,SP4,
            \ ST1,ST2,ST3,ST4,
            \ CS1,CS2,CS3,CS4,
            \ CP1,CP2,CP3,CP4,
            \ CT1,CT2,CT3,CT4,
            \ QS1,QS2,QS3,QS4,
            \ QP1,QP2,QP3,QP4,
            \ QT1,QT2,QT3,QT4,
            \ GG1,GG2,GG3,GG4

var hue_words = {'B': 'base', 'S': 'secondary', 'C': 'comp', 'Q': 'comp_secondary'}
var lightness_words = {'S': 'shade', 'P': 'pure', 'T': 'tint'}

for h in ['B', 'S', 'C', 'Q']
	for l in ['S', 'P', 'T']
		for s in [1, 2, 3, 4]
			var kw = h .. l .. s
			var syn_cmd = "syn keyword " .. kw .. " contained " .. kw
			execute syn_cmd

			var col_name = "tetradic_" .. hue_words[h] .. s .. "_" .. lightness_words[l]
			var hi_cmd = "highlight " .. kw .. " guifg=" .. col_name
			execute hi_cmd
		endfor
	endfor
endfor

syn keyword GG1 contained GG1
syn keyword GG2 contained GG2
syn keyword GG3 contained GG3
syn keyword GG4 contained GG4

highlight GG1 guifg=tetradic_gray1
highlight GG2 guifg=tetradic_gray2
highlight GG3 guifg=tetradic_gray3
highlight GG4 guifg=tetradic_gray4

b:current_syntax = "tetradic_demo"

defcompile

