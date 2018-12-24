arch n64.cpu
endian msb
output MIPS_I___01.n64, create
fill 1052672

origin $00000000
base $80000000
	include "../LIB/N64_UTE.INC"
	include "../LIB/N64_UTE_SYSCALL.INC" // Include 64 Byte Header
	
	include "../LIB/N64_HEADER.S" // Include 64 Byte Header
	insert "../LIB/N64_BOOTCODE.BOOT" // Include 4032 Byte Boot Code
Start:
	N64_INIT() // Run N64 Initialisation Routine
	LoadExceptionHandler()
	
	include "./MIPS_I___01.S"
	
	include "../LIB/N64_UTE_SYSCALL.S" // Include 64 Byte Header
Loop:
	j Loop
	nop
TheEnd:
