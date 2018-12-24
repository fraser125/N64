N64/MIPS Unit Test Emulation

Most programming languages support 'native' Unit Tests. The down side
is that they are language specific, the goal here is to test the 
emulation from inside the emulation. 

This series of test programs perform many tests that build off each other. 

	The Emulator developer must make just a couple of minimal 
code changes to accommodate the tests. Primarily support a 
slightly custom version of the SYSCALL instruction. 

	Since we are operating "inside" the machine we take just a
couple of liberties. Instead of one big "code" value. Parse the
SYSCALL instruction as a Register Type. The following values are
then available.

	RS = Reserved
	RT = P or F for Pass or Fail
		"Encoded" +64 to convert to an ASCII value or test
		as is for 16 = Pass and 6 = Fail
	RD = Test Set i.e. "0.MIPS_I_TestTheTest.bin" is #0
	SA = Test Number inside the Program
The SYSCALL instruction is encoded like this.
	(0b000000, rs, rt, rd, sa, 0b001100)
	
Only the rs, rt, rd, sa values are provided, you can format however you would like.
Example of possible output:
	Test Result - Set:0  Test:1  Result:Fail
	Test Result - Set:0  Test:2  Result:P

Notes for all Tests!
	1. The following are all FAILing test conditions
		1. Failure message
		2. Missing Sequence numbers
		3. Both Pass and Fail are displayed	
	2. Most instructions will be tested in multiple phases
		once other features are verified. (i.e. Load/Save)
	3. Each Test program has a maximum of 400 instructions or 31 tests.
	4. Because of Looping it's possible to run for much longer than
		400 instructions.
	
The UTE64 PIF ROM format has a couple of "extra" features.	
	All ROM locations 0x1FC00640 - 0x1FC007BF RESERVED
	Memory location 0x1FC00640 to 0x1FC006FF is for storing internal test data
	Memory location 0x1FC00700 to 0x1FC007BF is for data that can be read by the emulator
		Memory[0x1FC00700] location there is a 31 byte null terminated name.		
		Memory[0x1FC007BC] location there is a 4 byte value that defines 
			how many CPU cycles to execute. 

	Example:
	uint instructionCount = Memory[0x1FC007BC, 4].SwapBytesToUInt();
	for (int idx = 0; idx < instructionCount; idx++)
	{
		Step();
		PC += 4;
	}

The remaining challenge is to "bootstrap" accurate tests.
	Each test set is for one MIPS ISA, using only verified instructions. The 
tests will use instructions from "lower" ISA's. For example MIPS III tests
can and will use instructions that were already verified in MIPS I & II tests.

	The goal is to be able to run official code as quickly as possible, in the 
case of N64 emulation it's recommended to get the PIF code running. Emulating
other MIPS CPU's may use a different set or sequence of these tests.
	
	Test Sequence for N64 PIF:
		0	MIPS_I_TestTheTest.bin
		1	MIPS_I_01.bin
		2	MIPS_I_02.bin
		3	MIPS_II_01.bin
		4	MIPS_I_03.bin
		5	MIPS_II_02.bin
		6	MIPS_I_04.bin		
		7	Environment_PIF.bin
	Result: The PIF code should execute succesfully
	
"Test The Tests"
	Code is only as accurate and reliable as it's tests. These first tests are 
very simple and slowly build on each other. The later tests may still fluctuate
but the explanation below would be similar for all of the tests in this series.

Instructions Tested
	These instructions will receive additional testing later, but
this is a good start for testing.
		syscall
		nop
		beq
		addi 
		
Test Cases
	0. FailNOP - gotta make sure it works.
		This is the only time you want to see the failure message
	1. GoodNOP - gotta make sure it works.
		Hope you see a lot more of these in your future.
	2. beq true
		Executes syscall for pass or failure
	3. beq false
		Executes syscall for pass or failure
			
Expected Test results (based on example above):
	Test Result - Set:1  Test:1  Result:Fail
	Test Result - Set:1  Test:2  Result:P
	Test Result - Set:1  Test:3  Result:P
	Test Result - Set:1  Test:4  Result:P
	(Continued...)
			
Additional Comments on certain instructions:
	MULT and DIV instructions take more than 1 cycle, Cycle count is tested later
	MTHI, MFHI, MTLO and MFLO needed for mult and div, the 'To' instructions aren't common
	Some tests will also require the Delay slot must be implemented.
	All GPR registers are assumed unsigned 64-bit r0 - ra nothing fancy 
		(r0 and ra will be tested more later)
	All COP0 registers are assumed unsigned 64-bit nothing fancy.

These tests will also include environment and advanced feature tests to verify Registers 
and Memory ranges for reading and writing as well as Cache and TLB features and more.
	PIF from 0x1FC00000
	RSP from 0xA4001000
	VR4300 from 0x80000000