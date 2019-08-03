DisplayResult:
	// a0 Pass Tests as bits 
	// a1 Fail Tests as bits
	// Test may both pass and fail, in that case fail
	jr ra
	nop