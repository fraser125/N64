arch n64.cpu
endian msb
fill 1984

output MIPS_I___02.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC"
Start:

include "./MIPS_I___02.S"

origin external_test_name
db "MIPS I Test 2"
origin external_test_steps
instructionCount(TheEnd) // Macro only supports 1024 * 1024 = 1,048,575