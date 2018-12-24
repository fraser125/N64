arch n64.cpu
endian msb

output MIPS_I___01.bin, create
fill 1984

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC"
Start:

include "./MIPS_I___01.S"	

origin external_test_name
db "MIPS I Test 1"
origin external_test_steps
instructionCount(TheEnd) // Macro only supports 1024 * 1024 = 1,048,575
	
