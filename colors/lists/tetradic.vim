
if !exists("g:tetradic_base")
	finish
endif

let s:HUE = 0
let s:SAT = 1
let s:LIT = 2

function! s:DivMod(dividend, divisor)
	let l:a = float2nr(a:dividend) / float2nr(a:divisor)
	let l:b = (a:dividend * 1.0) - (a:divisor * 1.0 * l:a)
	return [l:a, l:b]
endfunction

function! HexRGB_to_HSL(hex)
	let l:r = str2nr(a:hex[1:2], 16)
	let l:g = str2nr(a:hex[3:4], 16)
	let l:b = str2nr(a:hex[5:6], 16)

	let l:r1 = l:r / 255.0
	let l:g1 = l:g / 255.0
	let l:b1 = l:b / 255.0

	" Cannot re-use r1, g1, b1 because max() and min() operator on Numbers,
	" not Floats.
	let l:cmax = max([l:r, l:g, l:b]) / 255.0
	let l:cmin = min([l:r, l:g, l:b]) / 255.0
	let l:cdelta = (l:cmax - l:cmin)

	if l:cdelta == 0.0
		let l:hue = 0
	elseif l:cmax == l:r1
		let l:hue = float2nr(((l:g1 - l:b1) / l:cdelta) * 60.0)
	elseif l:cmax == l:g1
		let l:hue = float2nr((((l:b1 - l:r1) / l:cdelta) + 2.0) * 60)
	elseif l:cmax == l:b1
		let l:hue = float2nr((((l:r1 - l:g1) / l:cdelta) + 4.0) * 60)
	else
		message "logic has failed us all"
	endif

	let l:lightness = (l:cmax + l:cmin) / 2.0

	if l:cdelta == 0
		let l:saturation = 0
	else
		let l:saturation = l:cdelta / (1 - abs(2 * l:lightness - 1))
	endif

	return [l:hue, l:saturation, l:lightness]
endfunction

function! HSL_to_RGB(hsl)
	let l:C = (1 - abs(2 * a:hsl[s:LIT] - 1)) * a:hsl[s:SAT]
	let l:h1 = s:DivMod(a:hsl[s:HUE] / 60.0, 2)[1]
	let l:X = l:C * (1.0 - abs(l:h1 - 1.0))
	let l:m = a:hsl[s:LIT] - (C / 2)
	if a:hsl[s:HUE] >= 360
		echo "logic has failed us all"
		echo a:hsl
	elseif a:hsl[s:HUE] >= 300
		let l:r1 = l:C
		let l:g1 = 0
		let l:b1 = l:X
	elseif a:hsl[s:HUE] >= 240
		let l:r1 = l:X
		let l:g1 = 0
		let l:b1 = l:C
	elseif a:hsl[s:HUE] >= 180
		let l:r1 = 0
		let l:g1 = l:X
		let l:b1 = l:C
	elseif a:hsl[s:HUE] >= 120
		let l:r1 = 0
		let l:g1 = l:C
		let l:b1 = l:X
	elseif a:hsl[s:HUE] >= 60
		let l:r1 = l:X
		let l:g1 = l:C
		let l:b1 = 0
	else
		let l:r1 = l:C
		let l:g1 = l:X
		let l:b1 = 0
	endif

	let l:r = (l:r1 + l:m) * 255
	let l:g = (l:g1 + l:m) * 255
	let l:b = (l:b1 + l:m) * 255

	return [l:r, l:g, l:b]
endfunction

function! HSL_to_HexRGB(hsl)
	let l:rgb = HSL_to_RGB(a:hsl)
	return printf("#%02x%02x%02x", float2nr(l:rgb[0]), float2nr(l:rgb[1]), float2nr(l:rgb[2]))
endfunction

function! TetradicSelfTest()
	let l:hsl = HexRGB_to_HSL("#000000")
	call assert_equal(l:hsl[0], 0)
	call assert_equal(l:hsl[1], 0)
	call assert_equal(l:hsl[2], 0)

	let l:hex_rgb = HSL_to_HexRGB([0, 0, 0])
	call assert_equal(l:hex_rgb, "#000000")

	let l:hsl = HexRGB_to_HSL("#FFFFFF")
	call assert_equal(l:hsl[0], 0)
	call assert_equal(l:hsl[1], 0)
	call assert_equal(l:hsl[2], 100)

	let l:hex_rgb = HSL_to_HexRGB([0, 0, 100])
	call assert_equal(l:hex_rgb, "#FFFFFF")

	let l:hsl = HexRGB_to_HSL("#FF0000")
	call assert_equal(l:hsl[0], 0)
	call assert_equal(l:hsl[1], 100)
	call assert_equal(l:hsl[2], 50)

	let l:hex_rgb = HSL_to_HexRGB([0, 100, 50])
	call assert_equal(l:hex_rgb, "#FF0000")

	let l:hsl = HexRGB_to_HSL("#BFBFBF")
	call assert_equal(l:hsl[0], 0)
	call assert_equal(l:hsl[1], 0)
	call assert_equal(l:hsl[2], 75)

	let l:hex_rgb = HSL_to_HexRGB([0, 0, 75])
	call assert_equal(l:hex_rgb, "#BFBFBF")

	let l:hsl = HexRGB_to_HSL("#800080")
	call assert_equal(l:hsl[0], 300)
	call assert_equal(l:hsl[1], 100)
	call assert_equal(l:hsl[2], 25)

	let l:hex_rgb = HSL_to_HexRGB([300, 100, 25])
	call assert_equal(l:hex_rgb, "#800080")

	let l:hsl = HexRGB_to_HSL("#E35C0F")
	call assert_equal(l:hsl[0], 74)
	call assert_equal(l:hsl[1], 79)
	call assert_equal(l:hsl[2], 53)

	let l:hex_rgb = HSL_to_HexRGB([74, 79, 53])
	call assert_equal(l:hex_rgb, "#E35C0F")
endfunction

call TetradicSelfTest()

let s:base_hsl = g:tetradic_base

let s:names = ["base", "secondary", "comp", "comp_secondary"]
let s:lightness_vals = { 'shade': 0.33, 'pure': 0.5, 'tint': 0.84 }
let s:hue_increments = [0, 35, 180, 215]
let s:hue_vals = map(s:hue_increments, {idx, val -> abs(s:DivMod(s:base_hsl[s:HUE] + val, 360)[1]) })
let s:saturation_vals = [0.33, 0.66, 0.82, 0.98]

function! EnumerateList(lst)
	return map(copy(a:lst), {idx, val -> [idx, val]})
endfunction

for [h_idx, hue] in EnumerateList(s:hue_vals)
	for [l_name, lit] in items(s:lightness_vals)
		for [s_idx, sat] in EnumerateList(s:saturation_vals)
			let s:col_name = "tetradic_" . s:names[h_idx] . (s_idx + 1) . "_" . l_name
			let s:hsl = [hue, sat, lit]
			let v:colornames[s:col_name] = HSL_to_HexRGB(s:hsl)
		endfor
	endfor
endfor

" For gray, since saturation is meaningless but we want 4 different values, we
" pretend the saturation steps are lightness steps.
for [l_idx, lit] in EnumerateList(s:saturation_vals)
	let s:col_name = "tetradic_gray" . (l_idx + 1)
	let s:hsl = [0, 0, lit]
	let v:colornames[s:col_name] = HSL_to_HexRGB(s:hsl)
endfor

