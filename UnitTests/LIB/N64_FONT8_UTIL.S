


align(8)
font8init16:
	//li a0, {src_start}
	//li a1, {src_end}
	//li a2, {dest}
	//li a3, {forecolor}
	//li v0, {backcolor}
	
	beq a2, r0, _FONT8_INIT16_END
	lui t0, 0x8000 // top bit bitmask
	
_FONT8_INIT16_SRC_LOOP:
	beq a0, a1, _FONT8_INIT16_END
	addi t2, r0, 32
	lw t1, 0(a0)
_FONT8_INIT16_BIT_LOOP_TOP:	
	and t3, t1, t0 // Show only the high bit	
	beql t3, r0, _FONT8_INIT16_BIT_LOOP_BOTTOM
	sh a3, 0(a2)
	b _FONT8_INIT16_BIT_LOOP_BOTTOM
	sh v0, 0(a2)	
_FONT8_INIT16_BIT_LOOP_BOTTOM:
	addi a2, a2, 2	
	addi t2, t2, -1	
	bne t2, r0, _FONT8_INIT16_BIT_LOOP_TOP
	sll t1, t1, 1
	b _FONT8_INIT16_SRC_LOOP
	addi a0, a0, 4
_FONT8_INIT16_END:	
	jr ra
	addi v0, 0x3000
	nop
	nop
	nop

font8init32:
	//li a0, {src_start}
	//li a1, {src_end}
	//li a2, {dest}
	//li a3, {forecolor}
	//li v0, {backcolor}
	beq a2, r0, _FONT8_INIT32_END
	lui t0, 0x8000 // top bit bitmask
	
_FONT8_INIT32_SRC_LOOP:
	beq a0, a1, _FONT8_INIT32_END
	addi t2, r0, 32
	lw t1, 0(a0)
_FONT8_INIT32_BIT_LOOP_TOP:	
	and t3, t1, t0 // Show only the high bit	
	beql t3, r0, _FONT8_INIT32_BIT_LOOP_BOTTOM
	sw a3, 0(a2)
	b _FONT8_INIT32_BIT_LOOP_BOTTOM
	sw v0, 0(a2)
_FONT8_INIT32_BIT_LOOP_BOTTOM:
	addi a2, a2, 4
	addi t2, t2, -1	
	bne t2, r0, _FONT8_INIT32_BIT_LOOP_TOP
	sll t1, t1, 1
	b _FONT8_INIT32_SRC_LOOP
	addi a0, a0, 4
_FONT8_INIT32_END:	
	jr ra
	addi v0, 0x6000
	nop
	nop
	nop
	
	nop
	nop
	nop
font8print16:
	//li a0, {fontname}
variable font_addr(a0)
	//li a1, {framebuffer}
variable frame_buffer(a1)
	//li a2, {top}
variable video_top(a2)
	//li a3, {left}
variable video_left(a3)
	//li v0, {string_address}
variable string_start(v0)
	//li v1, {length}
variable string_end(v1)
	
variable video_width(t0) 
variable ch(t1)
variable char_font_loc(t2)
variable fb_top(t3)
variable idx(t4)

	lui video_width, 0xA440
	lw video_width, 0x08(video_width) // Get Video Width
	sll video_width, video_width, 1
	// If top is zero, dont calculate
	beq video_top, r0, _FONT8_PRINT16_LINE_LOOP_START
	nop
	// Calculate top pixel position in frame_buffer
	mult video_top, video_width
	// get end of string 
	add string_end, string_start, string_end
	nop
	mflo video_top	
_FONT8_PRINT16_LINE_LOOP_START:
	beq string_start, string_end, _FONT8_PRINT16_END
	nop	
	lb ch, 0(string_start)
	addi char_font_loc, r0, 128
	addi ch, ch, -32
	mult ch, char_font_loc
	add fb_top, video_top, frame_buffer
	add fb_top, fb_top, video_left
	addi idx, r0, 7
	mflo char_font_loc // Character Location
	add char_font_loc, char_font_loc, font_addr
	
_FONT8_PRINT16_CHAR_FOR:
	lw t5, 0x0(char_font_loc)
	lw t6, 0x4(char_font_loc)
	lw t7, 0x8(char_font_loc)
	lw t8, 0xc(char_font_loc)
	sw t5, 0x0(fb_top)
	sw t6, 0x4(fb_top) 
	sw t7, 0x8(fb_top) 
	sw t8, 0xC(fb_top)
	add fb_top, fb_top, video_width
	addi char_font_loc, char_font_loc, 16
	
	bnel idx, r0, _FONT8_PRINT16_CHAR_FOR
	addi idx, idx, -1
	
_FONT8_PRINT16_CHAR_END:
	addi video_left, video_left, 20
	b _FONT8_PRINT16_LINE_LOOP_START
	addi string_start, string_start, 1
_FONT8_PRINT16_END:
	jr ra
	nop
	nop
	nop
	nop

font8print32:
	//li a0, {fontname}
	//li a1, {framebuffer}
	//li a2, {left}
	//li a3, {top}
	//li v0, {string_address}
	//li v1, {length}
	jr ra
	nop

fontconvhex2dec:
	//li a0, {text_hex_address}
	//li a1, {text_hex_length}
	//li a2, {text_dec_address}
	//li a3, {text_dec_length}
	jr ra
	nop
