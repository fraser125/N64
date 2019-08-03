align(16)
HandlerStart:
	mfc0 s5, EPC
	nop
	lw s6, 0x0(s5)
	
	addi s5, s5, 4
	mtc0 s5, EPC
	eret
align(16)
HandlerEnd:

align(8)
HandlerLoad:
	la t0, HandlerStart
	la t1, HandlerEnd
	la t2, 0x80000080
	addi t3, r0, HandlerEnd - HandlerStart
HandlerLoadLoop:
	lw t4, 0x0(t0)
	lw t5, 0x4(t0)
	lw t6, 0x8(t0)
	lw t7, 0xC(t0)
	sw t4, 0x0(t2)
	sw t5, 0x4(t2)
	sw t6, 0x8(t2)
	sw t7, 0xC(t2)
	addi t0, t0, 16
	addi t2, t2, 16
	beq t0, t1, HandlerLoadLoop
	nop
	jr ra
	nop