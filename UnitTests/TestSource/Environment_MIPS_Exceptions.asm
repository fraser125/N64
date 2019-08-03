arch n64.cpu
endian msb
fill 1984

output N64_Environment_Level2.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC" 
Start:
	

// Exception Registers
	mtc0 r1, Context
	mtc0 r1, BadVAddr
	mtc0 r1, Count
	mtc0 r1, Compare
	mtc0 r1, Status
	mtc0 r1, Cause
	mtc0 r1, EPC
	mtc0 r1, WatchLo
	mtc0 r1, WatchHi
	mtc0 r1, XContext
	mtc0 r1, ErrorEPC
		

TheEnd:
fixed_gap(Start, 0x0640)
origin internal_test_data

origin external_test_name
db "Environment PIF Test"
origin external_test_steps
instructionCount(TheEnd)
