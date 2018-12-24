arch n64.cpu
endian msb
fill 1984

output MIPS_I___TestTheTest.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC" 
Start:
	
//# Test the Test Instructions
	syscallUTE(0, 1, 'F')	// Output Expected!
	syscallUTE(0, 2, 'P')	// Output Expected!
	
//# Test beq True, nop ignored for now
	beq r0, r0, good3
	nop
bad3:
	syscallUTE(0, 3, 'F')
good3:
	syscallUTE(0, 3, 'P') 


//# Test beq True Negative
	b test4
	nop
good4:
	syscallUTE(0, 4, 'P')
	b continue5
	nop
test4:
	beq r0, r0, good4
	nop
bad4:
	syscallUTE(0, 4, 'F') 
continue5:	
	
	
//# Test beq False
//# Test addi instruction
	addi t0, r0, 1	
	beq t0, r0, bad6
	nop
	beq r0, r0, good6
	nop
bad6:
	syscallUTE(0, 5, 'F') 
	syscallUTE(0, 6, 'F') 
	b continue7
	nop
good6:
	syscallUTE(0, 5, 'P')
	syscallUTE(0, 6, 'P')
continue7:

//# Test addi instruction
	addiu t0, r0, 1
	addiu t1, r0, 1
	beq t0, t1, good7
	nop
bad7:
	syscallUTE(0, 7, 'F')
	b continue8
	nop
good7:
	syscallUTE(0, 7, 'P')
continue8:
	
//# Test addi negative numbers
	addiu t0, r0, -2
	addiu t1, r0, -2
	beq t0, t1, good8
	nop
bad8:
	syscallUTE(0, 8, 'F')
	b continue9
	nop
good8:
	syscallUTE(0, 8, 'P')
continue9:
	
//# Test addi negative numbers
	addiu t0, r0, -1
	addiu t1, r0, -1
	addiu t0, t0, 1
	addiu t1, t1, 1
	
	beq t0, t1, good9
	nop
bad9:
	syscallUTE(0, 9, 'F')
	b continue10
	nop
good9:
	syscallUTE(0, 9, 'P')
continue10:
	
//# Test addiu instruction
	addi t0, r0, 1
	addi t1, r0, 1
	beq t0, t1, good10
	nop
bad10:
	syscallUTE(0, 10, 'F')
	b continue11
	nop
good10:
	syscallUTE(0, 10, 'P')
continue11:
	
//# Test addi negative numbers
	addi t0, r0, -2
	addi t1, r0, -2
	beq t0, t1, good11
	nop
bad11:
	syscallUTE(0, 11, 'F')
	beq r0, r0, continue10
good11:
	syscallUTE(0, 11, 'P')
continue12:
	
//# Test addi negative numbers
	addi t0, r0, -1
	addi t1, r0, -1
	addi t0, t0, 1
	addi t1, t1, 1
	
	beq t0, t1, good12
	nop
bad12:
	syscallUTE(0, 12, 'F')
	b continue13
	nop
good12:
	syscallUTE(0, 12, 'P')
continue13:
TheEnd:

fixed_gap(Start, 0x0700)
