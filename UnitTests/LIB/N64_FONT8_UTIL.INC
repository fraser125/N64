// The 8x8 font is 96 characters excludes ASCIII 0-31
// 8 bytes / character
// 759 bytes for full character set
// 
// Expanded for 16-bit color
// 128 bytes / character
// 12 KB for full character set
//
// Expanded for 32-bit color
// 256 bytes / character
// 24 KB for full character set


macro font8_init16(src_start, src_end, dest, forecolor, backcolor) {
	li a0, {src_start}
	li a1, {src_end}
	li a2, {dest}
	li a3, {forecolor}
	li v0, {backcolor}
	jal font8init16
	nop
}

macro font8_init32(forecolor, backcolor, dest) {
	li a0, {forecolor}
	li a1, {backcolor}
	li a2, {dest}
	jal font8init32
	nop
}

macro font8_print16(fontname, framebuffer, top, left, string_address, length) {
	li a0, {fontname}
	li a1, {framebuffer}
	li a2, {top}
	li a3, {left}
	li v0, {string_address}
	li v1, {length}
	jal font8print16
	nop
}

macro font8_print32(fontname, framebuffer, left, top, string_address, length) {
	li a0, {fontname}
	li a1, {framebuffer}
	li a2, {left}
	li a3, {top}
	li v0, {string_address}
	li v1, {length}
	jal font8print32
	nop
}

macro font_conv_hex2dec(text_hex_address, text_hex_length, text_dec_address, text_dec_length) {
	li a0, {text_hex_address}
	li a1, {text_hex_length}
	li a2, {text_dec_address}
	li a3, {text_dec_length}
	jal fontconvhex2dec
	nop
}

