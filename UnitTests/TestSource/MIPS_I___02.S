//# Test  SUBU
	li t0, 0x5
	li t1, 0x10
	subu t2, t1, t0
	beq t2, t0, good1
	nop
	b bad1
	nop
good1:
	syscallUTE(1, 1, 1, 'P')
	b continue2
	nop
bad1:
	syscallUTE(1, 1, 1, 'F')
continue2:
//# Test  SLLV
//# Test  SRLV
//# Test  XOR
//# Test  MULTU
//# Test  SLTU

TheEnd:
fixed_gap(Start, 0x0640)
