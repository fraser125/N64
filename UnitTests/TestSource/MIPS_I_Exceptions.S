// Load Exception Handler
	lui t0, 0x8000
	la t1, exception_tlb_caller
	lw t2, 0x0(t1)
	lw t3, 0x4(t1)
	lw t4, 0x8(t1)
	sw t2, 0x0(t0)
	sw t3, 0x4(t0)
	sw t4, 0x8(t0)
// Load General Exception Handler
	ori t0, 0x0180
	la t1, exception_caller
	lw t2, 0x0(t1)
	lw t3, 0x4(t1)
	lw t4, 0x8(t1)
	sw t2, 0x0(t0)
	sw t3, 0x4(t0)
	sw t4, 0x8(t0)
// Force General Exception Handler
	syscall()
	
// Force TLB Miss Exception
	la t5, 0x60000000
tlb_miss_epc:
	sw t4, 0x0(t5) // Fails here, 
	// if emulator loops on 'sw' then fix 'eret'
	bne t5, t7, bad1 // Continues execution here
	nop
	b good1
	nop
bad1:
	syscallUTE(1, 1, 1, 'F')
	b continue2
	nop
good1:
	syscallUTE(1, 1, 1, 'P')
continue2:

	bne t5, t8, bad2 // Continues execution here
	nop
	b good2
	nop
bad2:
	syscallUTE(1, 1, 2, 'F')
	b continue3
	nop
good2:
	syscallUTE(1, 1, 2, 'P')
continue3:

	la t8, tlb_miss_epc // 0x8000105C
	bne t6, t8, bad3 // Continues execution here
	nop
	b good3
	nop
bad3:
	syscallUTE(1, 1, 3, 'F')
	b continue4
	nop
good3:
	syscallUTE(1, 1, 3, 'P')
continue4:

	la t8, 0x0000800C
	bne t6, t8, bad4 // Continues execution here
	nop
	b good4
	nop
bad4:
	syscallUTE(1, 1, 4, 'F')
	b continue5
	nop
good4:
	syscallUTE(1, 1, 4, 'P')
continue5:

// Need to test when exception occurs in Delay Slot


Loop:
	j Loop
	nop
	
align(8)
exception_handler:
	// Handle/Ignore SYSCALL :(
	mfc0 t6, EPC
	mfc0 t9, Cause
	andi t9, t9, 0x7C
	srl t9, t9, 2
	addi t8, r0, 8
	addi t0, t6, 4
	mtc0 t0, EPC
	bne t8, t9, continue_exception
	nop
	lw t7, 0x0(t6)
	sll t7, t7, 16
	andi t7, t7, 0x1F
	// 16 = Pass
	// 6 = Fail
continue_exception:
	jr ra
	nop
exception_handler_end:

align(8)	
exception_tlb_handler:
	mfc0 t6, EPC
	addi t0, t6, 4
	mtc0 t0, EPC
	mfc0 t7, EntryHi
	mfc0 t8, BadVAddr	
	mfc0 t9, Cause
	jr ra
	nop
exception_tlb_handler_end:

align(8)	
test_status_line:
	// a0 test number
	// a1 pass/fail
	// 		VI_BASE
	// Get Color Depth
	//		VI_STATUS
	// Get Framebuffer Location
	// 		VI_ORIGIN
	// Get Framebuffer Width
	// 		VI_WIDTH
	// Start Line @ line 10 and 11 for 100 Pixels
	// Convert Pass/Fail and Color Depth to u32 Color Value
	// Line1 = 10 + (Test# * 8)
	// Line2 = 11 + (Test# * 8)
	// Test #1 @ line 15 and 16 for 100 Pixels
	// Test #2 @ line 20 and 21 for 100 Pixels
	// Etc ...
	jr ra
	nop
test_status_square_end:

align(8)	
exception_caller:
	jal exception_handler
	nop
	eret
	
align(8)	
exception_tlb_caller:
	jal exception_tlb_handler
	nop
	eret
