
//# Test  BEQL
//# Test  BNEL


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