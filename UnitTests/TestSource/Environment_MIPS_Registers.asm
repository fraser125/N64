arch n64.cpu
endian msb
fill 1984

output Environment_MIPS_Registers.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC" 
Start:
	// Verify Read/Write GPR Registers
	addi r0, r0, 32
	addi r1, r0, 31
	addi r2, r0, 30
	addi r3, r0, 29
	addi r4, r0, 28
	addi r5, r0, 27
	addi r6, r0, 26
	addi r7, r0, 25
	addi r8, r0, 24
	addi r9, r0, 23
	addi r10, r0, 22
	addi r11, r0, 21
	addi r12, r0, 20
	addi r13, r0, 19
	addi r14, r0, 18
	addi r15, r0, 17
	addi r16, r0, 16
	addi r17, r0, 15
	addi r18, r0, 14
	addi r19, r0, 13
	addi r20, r0, 12
	addi r21, r0, 11
	addi r22, r0, 10
	addi r23, r0, 9
	addi r24, r0, 8
	addi r25, r0, 7
	addi r26, r0, 6
	addi r27, r0, 5
	addi r28, r0, 4
	addi r29, r0, 3
	addi r30, r0, 2
	addi r31, r0, 1
	add r1, r1, r0
	add r1, r1, r2
	add r1, r1, r3
	add r1, r1, r4
	add r1, r1, r5
	add r1, r1, r6
	add r1, r1, r7
	add r1, r1, r8
	add r1, r1, r9
	add r1, r1, r10
	add r1, r1, r11
	add r1, r1, r12
	add r1, r1, r13
	add r1, r1, r14
	add r1, r1, r15
	add r1, r1, r16
	add r1, r1, r17
	add r1, r1, r18
	add r1, r1, r19
	add r1, r1, r20
	add r1, r1, r21
	add r1, r1, r22
	add r1, r1, r23
	add r1, r1, r24
	add r1, r1, r25
	add r1, r1, r26
	add r1, r1, r27
	add r1, r1, r28
	add r1, r1, r29
	add r1, r1, r30
	add r1, r1, r31
	addi r2, r0, 496
	beq r1, r2, good1
	nop
bad1:
	syscallUTE(10, 1, 1, 'F')
	b continue2
	nop
good1:
	syscallUTE(10, 1, 1, 'P')
continue2:

	lui t0, 0x8000
	ori t0, t0, 0x003F
	mtc0 t0, Index
	nop
	mfc0 t1, Index
	beq t1, t0, good2
	nop
bad2:
	syscallUTE(10, 1, 2, 'F')
	b continue3
	nop
good2:
	syscallUTE(10, 1, 2, 'P')
continue3:

	addi t0, r0, -1	
	mtc0 t0, Index
	lui t1, 0x8000
	ori t1, t1, 0x003F
	mfc0 t2, Index
	beq t1, t2, good3
	nop
bad3:
	syscallUTE(10, 1, 3, 'W')
	b continue4
	nop
good3:
	syscallUTE(10, 1, 3, 'P')
continue4:
		
	ori t0, r0, 0x003F
	mtc0 t0, Random
	nop
	mfc0 t1, Random
	beq t1, t0, good4
	nop
bad4:
	syscallUTE(10, 1, 4, 'F')
	b continue5
	nop
good4:
	syscallUTE(10, 1, 4, 'P')
continue5:

	addi t0, r0, -1
	mtc0 t0, Random	
	ori t1, r0, 0x003F
	mfc0 t2, Random
	beq t1, t2, good5
	nop
warn5:
	syscallUTE(10, 1, 5, 'W')
	b continue6
	nop
good5:
	syscallUTE(10, 1, 5, 'P')
continue6:

	ori t0, r0, 0x003F
	mtc0 t0, Wired
	nop
	mfc0 t1, Wired
	beq t1, t0, good6
	nop
bad6:
	syscallUTE(10, 1, 6, 'F')
	b continue7
	nop
good6:
	syscallUTE(10, 1, 6, 'P')
continue7:

	addi t0, r0, -1
	mtc0 t0, Wired	
	addi t1, r0, 0x003F
	mfc0 t2, Wired
	beq t1, t2, good7
	nop
bad7:
	syscallUTE(10, 1, 7, 'W')
	b continue8
	nop
good7:
	syscallUTE(10, 1, 7, 'P')
continue8:

	addi t0, r0, -1
	mtc0 t0, PRId	
	nop
	mfc0 t1, PRId
	beq t0, t1, bad8
	nop
good8:
	syscallUTE(10, 1, 8, 'P')
	b continue9
	nop
bad8:
	syscallUTE(10, 1, 8, 'F')
continue9:
		
	addi t0, r0, -1
	mtc0 t0, Config	
	nop
	mfc0 t1, Config
	beq t0, t1, bad9
	nop
good9:
	syscallUTE(10, 1, 9, 'P')
	b continue10
	nop
bad9:
	syscallUTE(10, 1, 9, 'F')
continue10:
	
	lui t0, 0x7F06
	ori t0, t0, 0xE46F
	mtc0 t0, Config
	nop
	mfc0 t1, Config
	beq t0, t1, good10
	nop
good10:
	syscallUTE(10, 1, 10, 'P')
	b continue11
	nop
bad10:
	syscallUTE(10, 1, 10, 'F')
continue11:
	
	addi t0, r0, -1
	mtc0 t0, TagLo	
	nop
	mfc0 t1, TagLo
	beq t0, t1, bad11
	nop
good11:
	syscallUTE(10, 1, 11, 'P')
	b continue12
	nop
bad11:
	syscallUTE(10, 1, 11, 'W')
continue12:

	lui t0, 0x7FFF
	ori t0, t0, 0xFFC0	
	mtc0 t0, TagLo
	nop
	mfc0 t1, TagLo
	beq t0, t1, good12
	nop
bad12:
	syscallUTE(10, 1, 12, 'F')
	b continue13
	nop
good12:
	syscallUTE(10, 1, 12, 'P')
continue13:

	// Test 13 TagHi 0xFFFFFFFF (always reads zero)
	addi t0, r0, -1
	mtc0 t0, TagHi
	nop
	mfc0 t1, TagHi
	beq t1, r0, good13
	nop
bad13:
	syscallUTE(10, 1, 13, 'W')
	b continue14
	nop
good13:
	syscallUTE(10, 1, 13, 'P')
continue14:

	// Test 14 LLAddr 0xFFFFFFFF 32-bit R/W anything
	addi t0, r0, -1
	mtc0 t0, LLAddr	
	nop
	mfc0 t1, LLAddr
	beq t0, t1, good14
	nop
bad14:
	syscallUTE(10, 1, 14, 'F')
	b continue15
	nop
good14:
	syscallUTE(10, 1, 14, 'P')
continue15:

	// Test ## PErr 0xFFFFFFFF
	addi t0, r0, -1
	mtc0 t0, PErr	
	nop
	mfc0 t1, PErr
	beq t0, t1, bad15
	nop
good15:
	syscallUTE(10, 1, 15, 'P')
	b continue16
	nop
bad15:
	syscallUTE(10, 1, 15, 'F')
continue16:

	// Test PErr 0xFF
	addi t0, r0, 0xFF
	mtc0 t0, PErr	
	nop
	mfc0 t1, PErr
	beq t0, t1, good16
	nop
bad16:
	syscallUTE(10, 1, 16, 'W')
	b continue17
	nop
good16:
	syscallUTE(10, 1, 16, 'P')
continue17:

	// Test CacheErr 0xFFFFFFFF (always reads zero)
	addi t0, r0, -1
	mtc0 t0, CacheErr	
	nop
	mfc0 t1, CacheErr
	beq t1, r0, good17
	nop
bad17:
	syscallUTE(10, 1, 17, 'F')
	b continue18
	nop
good17:
	syscallUTE(10, 1, 17, 'P')
continue18:


TheEnd:
fixed_gap(Start, 0x0640)
origin internal_test_data

origin external_test_name
db "Environment PIF Test"
origin external_test_steps
instructionCount(TheEnd)
