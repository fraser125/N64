# Test Cases
Test results are:
* Pass
* Fail
* Warning
Other Notes on the results
The only official MIPS ISA's (Instruction Set Architecture) are:
* MIPS I
* MIPS II
* MIPS III
* MIPS IV
* MIPS V (No CPU's released)

The ISA Value 10 is for MIPS Environment Tests
Other values > 10 are for platform specific (ex. N64, Indy R4k, etc)
	
Assumption is that the following instruction pairs have the same implementation until exceptions are implemented.
`addi` and `addiu` 
`add` and `addu`
`sub` and `subu`

## MIPS_I___TestTheTest.bin (MIPS_I___TestTheTest.asm)
This is the core test to 'Bootstrap' the rest of these tests.
At this point nops are used in Delay Slots, but actual Delay Slots don't have to be implemented.
1. Test the Failure Instruction. Only time this should happen.
2. Test the Pass Instruction. Hopefully more to come.
3. beq test that it will skip a few lines (compare is r0==r0)
	nop is used from here on. Not much to really test.
4. beq test that it will skip a few lines backwards (compare is r0==r0)
5. addi +1 (simple register assignment)
6. beq test the comparison and force a failure (compare 1 == r0) !=
7. beq 2 register comparison (compare t0, t1)
8. addi -2
9. addi register addition with negative numbers ( -1 + t0  )
10. beq compare numbers for equal. (1 == 1)
11. beq compare negative numbers for equal. (-2 == -2)
12. beq compare zeros for equal. (0 == 0)  

### Conclusion  
The following instructions are well tested.  
* beq
* nop
* addi

PIF Priority Instructions
	LUI
	MTC0
	
	ORI
	ADDI
	ANDI
	
	BNE
	LW
	SW
	

## MIPS_I___01.bin  (MIPS_I___01.S)
Start with simple tests that are focused on register operations, including moving registers values and bitwise manipulation with immediate values, then the register versions. 
1. mthi & mfhi
2. mtlo & mflo
3. mtc0 & mfc0
4. lui simple
5. andi simple (need this for #6)
6. lui lower 16 bits = zeros
7. lui sign extended
8. andi sign extended
9. 
10. ori (0x555 | 0xAAA = 0xFFF) 
11. 
12. ori sign extended

13. or simple 2 register (0xCCC | 0x333 = 0xFFF)
14. srl
15. add simple 2 register (3 + 4 = 7)
10. 
11. 
12. 
14. 
15. 
### Conclusion
The following instructions are well tested.


## MIPS_I___02.bin  (MIPS_I___02.S)
More involved tests to verify more branch and jump instructions as well as store and load. From here on it's exepected that Delay Slots are implemented.
13. jr
16. jal
17. bne true
18. bne false
19. jr
lw 
sw and lw
### Conclusion
The following instructions are well tested.


## MIPS_I___03.bin  (MIPS_I___03.S)
### Conclusion
The following instructions are well tested.


## MIPS_II__01.bin  (MIPS_II__01.S)
PIF Priority Instructions
* BEQL
* BNEL

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