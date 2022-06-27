vim9script

if !exists("g:tetradic_base")
	finish
endif

var HUE = 0
var SAT = 1
var LIT = 2

def DivMod(dividend: float, divisor: float): list<any>
	var a: number = float2nr(dividend) / float2nr(divisor)
	var b: float = (dividend * 1.0) - (divisor * 1.0 * a)
	return [a, b]
enddef

def HexRGB_to_HSL(hex: string): list<any>
	var r = str2nr(hex[1 : 2], 16)
	var g = str2nr(hex[3 : 4], 16)
	var b = str2nr(hex[5 : 6], 16)

	var r1 = r / 255.0
	var g1 = g / 255.0
	var b1 = b / 255.0

	# Cannot re-use r1, g1, b1 because max() and min() operator on Numbers,
	# not Floats.
	var cmax = max([r, g, b]) / 255.0
	var cmin = min([r, g, b]) / 255.0
	var cdelta = (cmax - cmin)

    var hue = 0
	if cdelta == 0.0
		hue = 0
	elseif cmax == r1
		hue = float2nr(((g1 - b1) / cdelta) * 60.0)
	elseif cmax == g1
		hue = float2nr((((b1 - r1) / cdelta) + 2.0) * 60)
	elseif cmax == b1
		hue = float2nr((((r1 - g1) / cdelta) + 4.0) * 60)
	else
		message "logic has failed us all"
	endif

	var lightness = (cmax + cmin) / 2.0

    var saturation = 0.0
	if cdelta == 0.0
		saturation = 0.0
	else
		saturation = cdelta / (1 - abs(2 * lightness - 1))
	endif

	return [hue, saturation, lightness]
enddef

def HSL_to_RGB(hsl: list<any>): list<any>
	var C = 1.0 * (1 - abs(2 * hsl[LIT] - 1)) * hsl[SAT]
	var h1 = DivMod(hsl[HUE] / 60.0, 2.0)[1]
	var X = C * (1.0 - abs(h1 - 1.0))
	var m = hsl[LIT] - (C / 2.0)
    var r1 = 0.0
    var g1 = 0.0
    var b1 = 0.0
	if hsl[HUE] >= 360
		echo "logic has failed us all"
		echo hsl
	elseif hsl[HUE] >= 300
		r1 = C
		g1 = 0.0
		b1 = X
	elseif hsl[HUE] >= 240
		r1 = X
		g1 = 0.0
		b1 = C
	elseif hsl[HUE] >= 180
		r1 = 0.0
		g1 = X
		b1 = C
	elseif hsl[HUE] >= 120
		r1 = 0.0
		g1 = C
		b1 = X
	elseif hsl[HUE] >= 60
		r1 = X
		g1 = C
		b1 = 0.0
	else
		r1 = C
		g1 = X
		b1 = 0.0
	endif

	var r = (r1 + m) * 255
	var g = (g1 + m) * 255
	var b = (b1 + m) * 255

	return [r, g, b]
enddef

def HSL_to_HexRGB(hsl: list<any>): string
	var rgb = HSL_to_RGB(hsl)
	return printf("#%02x%02x%02x", float2nr(rgb[0]), float2nr(rgb[1]), float2nr(rgb[2]))
enddef

def TetradicSelfTest(): void
	var hsl = HexRGB_to_HSL("#000000")
	assert_equal(hsl[0], 0)
	assert_equal(hsl[1], 0)
	assert_equal(hsl[2], 0)

	var hex_rgb = HSL_to_HexRGB([0, 0, 0])
	assert_equal(hex_rgb, "#000000")

	hsl = HexRGB_to_HSL("#FFFFFF")
	assert_equal(hsl[0], 0)
	assert_equal(hsl[1], 0)
	assert_equal(hsl[2], 100)

	hex_rgb = HSL_to_HexRGB([0, 0, 100])
	assert_equal(hex_rgb, "#FFFFFF")

	hsl = HexRGB_to_HSL("#FF0000")
	assert_equal(hsl[0], 0)
	assert_equal(hsl[1], 100)
	assert_equal(hsl[2], 50)

	hex_rgb = HSL_to_HexRGB([0, 100, 50])
	assert_equal(hex_rgb, "#FF0000")

	hsl = HexRGB_to_HSL("#BFBFBF")
	assert_equal(hsl[0], 0)
	assert_equal(hsl[1], 0)
	assert_equal(hsl[2], 75)

	hex_rgb = HSL_to_HexRGB([0, 0, 75])
	assert_equal(hex_rgb, "#BFBFBF")

	hsl = HexRGB_to_HSL("#800080")
	assert_equal(hsl[0], 300)
	assert_equal(hsl[1], 100)
	assert_equal(hsl[2], 25)

	hex_rgb = HSL_to_HexRGB([300, 100, 25])
	assert_equal(hex_rgb, "#800080")

	hsl = HexRGB_to_HSL("#E35C0F")
	assert_equal(hsl[0], 74)
	assert_equal(hsl[1], 79)
	assert_equal(hsl[2], 53)

	hex_rgb = HSL_to_HexRGB([74, 79, 53])
	assert_equal(hex_rgb, "#E35C0F")
enddef

TetradicSelfTest()

var base_hsl = g:tetradic_base

var names = ["base", "secondary", "comp", "comp_secondary"]
var lightness_vals = { 'shade': 0.33, 'pure': 0.5, 'tint': 0.84 }
var hue_increments = [0.0, 35.0, 180.0, 215.0]
var hue_vals = map(hue_increments, (idx, val) => abs(DivMod(base_hsl[HUE] + val, 360.0)[1]))
var saturation_vals = [0.33, 0.66, 0.82, 0.98]

def EnumerateList(lst: list<any>): list<any>
	return map(copy(lst), (idx, val) => [idx, val])
enddef

for [h_idx, hue] in EnumerateList(hue_vals)
	for [l_name, lit] in items(lightness_vals)
		for [s_idx, sat] in EnumerateList(saturation_vals)
			var col_name = "tetradic_" .. names[h_idx] .. (s_idx + 1) .. "_" .. l_name
			var hsl = [hue, sat, lit]
			v:colornames[col_name] = HSL_to_HexRGB(hsl)
		endfor
	endfor
endfor

# For gray, since saturation is meaningless but we want 4 different values, we
# pretend the saturation steps are lightness steps.
for [l_idx, lit] in EnumerateList(saturation_vals)
	var col_name = "tetradic_gray" .. (l_idx + 1)
	var hsl = [0, 0, lit]
	v:colornames[col_name] = HSL_to_HexRGB(hsl)
endfor

defcompile

