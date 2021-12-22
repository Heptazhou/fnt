const dst = ""
const src = "@org/"
const list = [
	# "Thin"
	# "ThinItalic"
	# "ExtraLight"
	# "ExtraLightItalic"
	# "Light"
	# "LightItalic"
	"Regular"
	# "Italic"
	# "Medium"
	# "MediumItalic"
	# "SemiBold"
	# "SemiBoldItalic"
	# "Bold"
	# "BoldItalic"
	# "ExtraBold"
	# "ExtraBoldItalic"
	# "Black"
	# "BlackItalic"
]

function update(ext::String)
	n = 0
	isdir(ext) || mkdir(ext)
	for f in "$ext/DoulosSIL-" .* list .* ".$ext"
		cmd = `pyftfeatfreeze -f 'ss01' -R 'Doulos SIL/Times Doulos SIL' $(src * f) $(dst * replace(f, r"(DoulosSIL)" => s"Times\1"))`
		cmd |> println
		cmd |> run
		n += 1
	end
	@info "完成 > $n"
	println()
end

try
	update("ttf")
catch e
	@info "错误"
	@info e
end
length(ARGS) > 0 && exit()
print("> ")
readline()

