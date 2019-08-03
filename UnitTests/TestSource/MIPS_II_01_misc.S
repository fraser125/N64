// The following require Delay Slots to be implemented
//# Test beql True
	beql r0, r0, good12
	syscallUTE(1, 12, 'P')	
bad12:
	syscallUTE(1, 12, 'F')
good12:
	

//# Test beql False
	addi t0, r0, 1
	beql t0, r0, bad13
	syscallUTE(1, 13, 'F')
good13:
	syscallUTE(1, 13, 'P')
	beq r0, r0, continue14
	nop
bad13:
	syscallUTE(1, 13, 'F')
	beq r0, r0, continue14
	nop
continue14:

	
	//# Test beql jump to negative offset
//	beql t0, t1, good14
//	nop
//bad14:
//	failNop(14)
//good14:
//	goodNop(14)

//# Test bnel True
	addi t0, r0, 1
	bnel t0, r0, good15
	syscallUTE(1, 15, 'P')
	syscallUTE(1, 15, 'F')
good15:

//# Test bnel False
	bnel r0, r0, good16
	syscallUTE(1, 16, 'F')
good16:
	syscallUTE(1, 16, 'P')
	

//# Test bnel jump to negative offset
	// beq t0, t1, good24
	// nop
// bad24:
	// failNop(24)
// good24:
	// goodNop(24)