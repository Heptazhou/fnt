const dst = ""
const src = "@org/"
const list = [
	"Thin"
	"ThinItalic"
	"ExtraLight"
	"ExtraLightItalic"
	"Light"
	"LightItalic"
	"Regular"
	"Italic"
	"Medium"
	"MediumItalic"
	"SemiBold"
	"SemiBoldItalic"
	"Bold"
	"BoldItalic"
	"ExtraBold"
	"ExtraBoldItalic"
	"Black"
	"BlackItalic"
]

function update(ext::String)
	n = 0
	isdir(ext) || mkdir(ext)
	for f in "$ext/Inter-" .* list .* ".$ext"
		cmd = `pyftfeatfreeze -f 'zero,cv03,cv04,cv07,cv08,cv10,cv11,ss03' $(src * f) $(dst * f)`
		cmd |> println
		cmd |> run
		n += 1
	end
	@info "完成 > $n"
	println()
end

try
	update("otf")
	update("ttf")
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

