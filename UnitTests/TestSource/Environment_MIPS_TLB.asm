arch n64.cpu
endian msb
fill 1984

output N64_Environment_Level2.bin, create

origin $00000000
base $1FC00000
	include "../LIB/N64_UTE.INC" 
Start:
// NEC MIPS CPU's have a different Config register and TLB differences
// Search MIPS3_TYPE_VR4300 in MAME repo
// https://github.com/mamedev/mame/blob/master/src/devices/cpu/mips/mips3com.cpp
// TLB Entry
	mtc0 r1, EntryLo0
	mtc0 r1, EntryLo1
	mtc0 r1, PageMask
	mtc0 r1, EntryHi


TheEnd:
fixed_gap(Start, 0x0640)
origin internal_test_data

origin external_test_name
db "Environment PIF Test"
origin external_test_steps
instructionCount(TheEnd)
