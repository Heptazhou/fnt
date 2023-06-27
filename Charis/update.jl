# Copyright (C) 2021-2023 Heptazhou <zhou@0h7z.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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

# https://software.sil.org/lcgfonts/download/
# Charis SIL Literacy Compact

function update(ext::String)
	isdir(ext) || mkdir(ext)
	fnt, tag = "Charis", "SIL Literacy Compact"
	sfx, n   = replace(tag, " " => ""), 0
	for f in "$ext/$fnt$sfx-" .* list .* ".$ext"
		cmd = ["pyftfeatfreeze",
			"-f", "cv19,cv62=1",
			"-R", "$fnt $tag/$fnt",
			src * f,
			dst * replace(f, fnt * sfx => fnt),
		] |> Cmd
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

