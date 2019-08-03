macro LoadExceptionHandler() {
// Load General Exception Handler
	lui t0, 0x8000
	ori t0, 0x0180
	la t1, exception_caller
	lw t2, 0x0(t1)
	lw t3, 0x4(t1)
	lw t4, 0x8(t1)
	sw t2, 0x0(t0)
	sw t3, 0x4(t0)
	sw t4, 0x8(t0)
}