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
	fnt = "Charis"
	sfx = "SIL-LiteracyCompact"
	tag = "SIL Literacy Compact"
	for f in "$ext/$fnt$sfx-" .* list .* ".$ext"
		cmd = "pyftfeatfreeze -f 'cv19,cv62=1' -R '$fnt $tag/$fnt' $(src * f) $(dst * replace(f, Regex("($fnt)$sfx") => s"\1"))"
		cmd = :(@cmd $cmd) |> eval
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

