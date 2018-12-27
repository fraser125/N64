# Test Cases
Test results are:
* Pass
* Fail
* Warning
Other Notes on the results
The only official MIPS ISA's (Instruction Set Architecture) are:
MIPS I
MIPS II
MIPS III
MIPS IV
MIPS V (No CPU's released)

The ISA Value 10 is for MIPS Environment Tests
Other values > 10 are for platform specific (ex. N64, Indy R4k, etc)
	
## MIPS_I___TestTheTest.bin (MIPS_I___TestTheTest.asm)

## MIPS_I___01.bin  (MIPS_I___01.S)

## MIPS_I___01.bin  (MIPS_I___01.S)

## MIPS_I___01.bin  (MIPS_I___01.S)

## Environment_MIPS_Registers.bin  (Environment_MIPS_Registers.asm)  
Many of these register settings are not MIPS specific, but will vary depending on manufacturer, make and model of CPU.  
1. Check all General Purpose Registers for r/w and make sure register 0 always reads zero
// Verify Read/Write COP0 Registers
2. Index register set max official Value / read back and compare
3. Index register set max value (0xFFFFFFFF) / read back and compare
		Pass and Warning only
4. Random register set max official Value / read back and compare
5. Random register set max value (0xFFFFFFFF) / read back and compare
		Pass and Warning only
6. Wired register set max official Value / read back and compare
7. Wired register set max value (0xFFFFFFFF) / read back and compare
		Pass and Warning only
8. PRId is a Read Only Register, Attempt to write 0xFFFFFFFF and compare
9. Config register set max value (0xFFFFFFFF) / read back and compare
10. Config register set max official Value / read back and compare
11. TagLo register set max value (0xFFFFFFFF) / read back and compare
12. TagLo register set max official Value / read back and compare
13. TagHi register set max value (0xFFFFFFFF) / read back and compare
		Pass and Warning only
14. LLAddr register set max official value (0xFFFFFFFF) / read back and compare
15. PErr register set max value (0xFFFFFFFF) / read back and compare
		Pass and Warning only
16. TagLo register set max official Value / read back and compare
17. CacheErr register set max value (0xFFFFFFFF) / read back and compare
		Pass and Warning only