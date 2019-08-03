arch n64.cpu
endian msb
fill 1984

output N64_Environment_Level2.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC" 
Start:
	
		constant RCP_V1($01010101)
constant RCP_V2($02020102)

	mfc0 t1, PRId
	addi t0, r0, 0x0b00 
	beq t0, t1, good1
	nop
bad1:
	syscallUTE(11, 1, 1, 'W')
	b continue2
	nop
good1:
	syscallUTE(11, 1, 1, 'P')
continue2:
	
	
	
	
	// Verify Read from 0x1FC00000
	//		Already doing this or the code wouldn't run
	// Verify Write to  0x1FC007C0
	// Verify Read/Write 0xA4000000 4kb
	// Verify Read/Write 0xA4001000 4kb
	// Verify Read/Write 0x80000000 4MB RAM
	// Verify Read/Write 0x80800000 4MB RAM Expansion PAK
	// Verify Read/Write 0x04000000 DMEM / IMEM
	// Verify Read/Write 0x04040000 RSP 
	// Verify Read/Write 0x04400000 Video Inteface
	// Verify Read/Write 0x04500000 Audio Inteface
	// Verify Read/Write 0x04600000 PI Inteface			
	// Verify Read from 0x10000000 Cart Memory at least 1MB
	// Verify DMA between Cart and RAM

TheEnd:
fixed_gap(Start, 0x0640)
origin internal_test_data

origin external_test_name
db "Environment PIF Test"
origin external_test_steps
instructionCount(TheEnd)
