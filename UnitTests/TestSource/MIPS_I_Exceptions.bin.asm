arch n64.cpu
endian msb
fill 1984

output 9.MIPS_I_Exceptions.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC"
Start:
	N64_INIT()
include "./MIPS_I_Exceptions.S"
	break

TheEnd:
fixed_gap(Start, 0x0640)
origin internal_test_data
align(8)
dw 0x12345678
middle:
dw 0x90123456
dw 0x78901234
origin external_test_name
db "PIF Exceptions"
origin external_test_steps
instructionCount(TheEnd)