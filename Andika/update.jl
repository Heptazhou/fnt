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
	"Italic"
	# "Medium"
	# "MediumItalic"
	# "SemiBold"
	# "SemiBoldItalic"
	"Bold"
	"BoldItalic"
	# "ExtraBold"
	# "ExtraBoldItalic"
	# "Black"
	# "BlackItalic"
]

function update(ext::String)
	n = 0
	isdir(ext) || mkdir(ext)
	for f in "$ext/Andika-" .* list .* ".$ext"
		cmd = `pyftfeatfreeze -f 'cv10,cv19,cv62=1,cv67=1' $(src * f) $(dst * f)`
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
isempty(ARGS) || exit()
print("> ")
readline()

