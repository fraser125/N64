// bpset 80000180,(Cause&FFFF)>0,{printf "Status: %c\n",((d@EPC&1F0000)>>10)+40;}
// bpset 80000180,((d@EPC&1F0000)>>10)==6,{printf "Status: Fail"};bpset 80000180,((d@EPC&1F0000)>>10)==16,{printf "Status: P"}
align(8)	
exception_caller:
	jal exception_handler
	nop
	eret
	
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