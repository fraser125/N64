
//# Test mthi and mfhi
	addi t0, r0, 1
	mthi t0
	mfhi t1
	beq t0, t1, good1
	nop
bad1:
	syscallUTE(1, 1, 1, 'F')
	b continue2
	nop
good1:
	syscallUTE(1, 1, 1, 'P')
continue2:

//# Test mtlo and mflo
	addi t0, r0, 1
	mtlo t0
	mflo t1
	beq t0, t1, good2
	nop
bad2:
	syscallUTE(1, 1, 2, 'F')
good2:
	syscallUTE(1, 1, 2, 'P')

//# Test add
	addi t0, r0, 7
	addi t1, r0, 3
	addi t2, r0, 4
	add t3, t1, t2
	beq t0, t3, good3
	nop
bad3:
	syscallUTE(1, 1, 3, 'F')
good3:
	syscallUTE(1, 1, 3, 'P')

//# Test addu
	addi t0, r0, 7
	addi t1, r0, 3
	addi t2, r0, 4
	addu t3, t1, t2
	beq t0, t3, good4
	nop
bad4:
	syscallUTE(1, 1, 4, 'F')
good4:
	syscallUTE(1, 1, 4, 'P')

//# Test srl
	lui t0, 0x000F
	srl t0, t0, 5
	addi t1, r0, 0x7800
	beq t0, t1, good5
	nop
bad5:
	syscallUTE(1, 1, 5, 'F')
good5:
	syscallUTE(1, 1, 5, 'P')
	
//# Test or
	addi t0, r0, 0x0333
	addi t1, r0, 0x0CCC
	addi t2, r0, 0x0FFF
	or t0, t0, t1
	beq t0, t2, good6
	nop
bad6:
	syscallUTE(1, 1, 6, 'F')
good6:
	syscallUTE(1, 1, 6, 'P')
	
//# Test mtc0 and mfc0
	addi t0, r0, 0x10
	mtc0 t0, Compare
	mfc0 t1, Compare
	beq t0, t1, good7
	nop
bad7:
	syscallUTE(1, 1, 7, 'F')
	b continue8
	nop
good7:
	syscallUTE(1, 1, 7, 'P')
continue8:
	
//# Test lui
	lui t0, 0x1
	addi t1, r0, 0x7FFF
	addi t1, t1, 0x7FFF
	addi t1, t1, 2
	beq t0, t1, good8
	nop
bad8:
	syscallUTE(1, 1, 8, 'F')
	beq r0, r0, continue9
	nop
good8:
	syscallUTE(1, 1, 8, 'P')
continue9:

//# Test ori
	addi t0, r0, 0x0555
	ori t1, t0, 0x0AAA
	addi t2, r0, 0x0FFF
	beq t1, t2, good9
	nop
bad9:
	syscallUTE(1, 1, 9, 'F')
	beq r0, r0, continue10
	nop
good9:
	syscallUTE(1, 1, 9, 'P')
continue10:

//# Test lw
	la t0, middle // if #9 ^ passes la and li are good
	lw t1, 0x04(t0)
	li t2, 0x78901234
	beq t1, t2, good10
	nop
bad10:
	syscallUTE(1, 1, 10, 'F')
	beq r0, r0, continue11
	nop
good10:
	syscallUTE(1, 1, 10, 'P')
continue11:

//# Test andi
	addi t0, r0, 0x0FF0
	andi t1, t0, 0x0F00
	addi t2, r0, 0x0F00
	beq t1, t2, good11
	nop
bad11:
	syscallUTE(1, 1, 11, 'F')
	beq r0, r0, continue12
	nop
good11:
	syscallUTE(1, 1, 11, 'P')
continue12:

//# Test mthi and mfhi
	addi t0, r0, 1
	mthi t0
	mfhi t1
	beq t0, t1, good12
	nop
bad12:
	syscallUTE(1, 1, 12, 'F')
	b continue13
	nop
good12:
	syscallUTE(1, 1, 12, 'P')
continue13:

	la ra, good13
	jr ra
	nop
bad13:
	syscallUTE(1, 1, 13, 'F')
good13:
	syscallUTE(1, 1, 13, 'P')


//# Test sw
	la t0, middle
	lw t0, 0x0(t0)
	lui t1, 0x1FC0
	addi t1, 0x07C0
	sw t0, 0x0(t1)
	nop
	nop
	lw t2, 0x0(t1)
	beq t0, t2, good14
	nop
bad14:
	syscallUTE(1, 1, 14, 'F')
	beq r0, r0, continue15
	nop
good14:
	syscallUTE(1, 1, 14, 'P')
	beq r0, r0, continue15
	nop
	
// Test 15 and 16 jump and link destination
destination15:
	syscallUTE(1, 1, 15, 'P')	
	jr ra
	nop
continue15:	
	jal destination15
	nop		
good15:
	syscallUTE(1, 1, 16, 'P')	
	beq r0, r0, continue16
	nop
bad15:
	syscallUTE(1, 1, 16, 'F')	
continue16:

//# Test bne True
	addi t0, r0, 1
	bne t0, r0, good17
	nop
bad17:
	syscallUTE(1, 1, 17, 'F')
good17:
	syscallUTE(1, 1, 17, 'P')

//# Test bne False
	bne r0, r0, bad18
	nop
good18:
	syscallUTE(1, 1, 18, 'P')
	b continue18
	nop
bad18:
	syscallUTE(1, 1, 18, 'F')
continue18:
	
//# Test jr
	la t0, destination19
	jr t0
	nop
	syscallUTE(1, 1, 19, 'F')
destination19:
	syscallUTE(1, 1, 19, 'P')

//# Test ori always 0 extended	ushort
	li t0, 0x0F00F000
	ori t1, t0, 0xFF00
	li t2, 0xF00FF00
	beq t1, t2, good20
	nop
bad20:
	syscallUTE(1, 1, 20, 'F')
good20:
	syscallUTE(1, 1, 20, 'P')
	
//# Test andi always 0 extended	ushort
	li t0, 0x0F007000
	andi t1, t0, 0xFF00
	addi t2, r0, 0x7000
	beq t1, t2, good21
	nop
bad21:
	syscallUTE(1, 1, 21, 'F')
good21:
	syscallUTE(1, 1, 21, 'P')
continue22:

//# Test lui lower 16 bits are zer0
	lui t0, 1
	andi t1, t0, 0xFFFF
	beq t1, r0, good22
	nop
bad22:
	syscallUTE(1, 1, 22, 'F')
	b continue23
	nop
good22:
	syscallUTE(1, 1, 22, 'P')
	b continue23
	nop

//# Test bgezal True + Negative Offset
destination23:
	syscallUTE(1, 1, 24, 'P')
	jr ra
	nop
continue23:
	addi t0, r0, 1
	bgezal t0, destination23
	syscallUTE(1, 1, 23, 'P')
	syscallUTE(1, 1, 25, 'P')
	b continue25
	nop
	syscallUTE(1, 1, 25, 'F')
	
continue25:
	
//# Test sw negative offset
	// beq t0, t1, good18
	// nop


//# Test from Registers RS, RT, RD, SA to make sure all bits are masked.


//# Test jr alt syntax
	// beq t0, t1, good14
	// nop
// bad14:
	// failNop(14)
// good14:
	// goodNop(14)



//# Test lw negative offset
	// la t0, middle // if #9 ^ passes la is good
	// lw t1, -0x04(t0)
	// li t2, 0x78901234
	// beq t1, t2, good15
	// nop
// bad15:
	// failNop(15)
// good15:
	// goodNop(15)
TheEnd:
fixed_gap(Start, 0x0640)
origin internal_test_data
align(8)
dw 0x12345678
middle:
dw 0x90123456
dw 0x78901234
