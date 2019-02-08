# N64/MIPS Unit Test Emulation

Most programming languages support 'native' Unit Tests. The down side
is that they are language specific, the goal here is to test the 
emulation from inside the emulation. 

This series of test programs perform many tests that build off each other. 

The Emulator developer must make just a couple of minimal code changes to 
accommodate the tests. Primarily support a slightly custom version of the 
SYSCALL instruction. 

Since we are operating "inside" the machine we take just a couple of liberties. 
Instead of one big "code" value. Parse the SYSCALL instruction as a Register 
Type. The following values are then available. 

NOTE: There are a couple of small reasons that these tests
<b>Will NOT run on Hardware</b>
This is a decision that was made. Where appropriate the resulting values are 
verified on hardware, but this code takes some liberties that don't work on hardware.  
For example reading from PIF memory after boot.

* RS = MIPS ISA (i.e. 1, 2, 3, 4 aka I, II, III, IV)
* RT = P or F for Pass or Fail
  * The value for P is 16 and F is 6 
  * +64 to convert to an ASCII value or test	
* RD = Test Set i.e. "0.MIPS_I_TestTheTest.bin" is #0
* SA = Test Number inside the Program  
The SYSCALL instruction is encoded like this.
> (0b000000, rs, rt, rd, sa, 0b001100)
	
Only the actual values of rs, rt, rd, sa are provided, you can format however you would like.
Example of possible output:  
> Test Result - MIPS ISA:1 Set:0  Test:1  Result:Fail  
> Test Result - MIPS ISA:1 Set:0  Test:2  Result:P  

### Implementation of the SYSCALL
Just in case the above sounds like a lot of complexity, here is my implementation in C#.  
Hint: It's mostly about displaying the instructions parsed values
```
case OpCodeAll.SYSCALL:
	if (instruction.SA > 0)
	{
		string resultText = (instruction.RT == 16) ? "P" : "Fail";
		Console.WriteLine("Test Result - ISA:{0}  Set:{1,2:##}  Test:{2,2:##}  Result:{3}", instruction.RS, instruction.RD, instruction.SA, resultText);
	}
	else
	{
		// Standard SYSCALL behavior
	}
break;
```

Notes for all Tests!
1. The following are all FAILing test conditions
   1. Failure message
   2. Missing Sequence numbers
   3. Both Pass and Fail are displayed	
2. Most instructions will be tested in multiple phases once other features are verified.
3. Each Test program has a maximum of 400 instructions or 31 tests.
4. Because of Looping it's possible to run for much longer than 400 instructions.
	
The UTE64 PIF ROM format has a couple of "extra" features.	
* All ROM locations 0x1FC00640 - 0x1FC007BF RESERVED
* Memory location 0x1FC00640 to 0x1FC006FF is for storing internal test data
* Memory location 0x1FC00700 to 0x1FC007BF is for data that can be read by the emulator
*	Memory[0x1FC00700] location there is a 31 byte null terminated name.		
*	Memory[0x1FC007BC] location there is a 4 byte value that defines how many CPU cycles to execute. 

```
Example:
uint instructionCount = Memory[0x1FC007BC, 4].SwapBytesToUInt();
for (int idx = 0; idx < instructionCount; idx++)
{
	Step();
	PC += 4;
}
```

## The remaining challenge is to "bootstrap" accurate tests.  
The following guidelines apply:  
1. Successfully execute the following tests first  
   1. MIPS_I_TestTheTest  
   2. MIPS_I_01.bin  
   3. MIPS_I_02.bin  
2. At this point most other ISA tests will work.
3. Inside each ISA the tests must be done in sequence.  

This may sound confusing but here is an example for the N64
1. MIPS_I_TestTheTest.bin
2. MIPS_I_01.bin
3. MIPS_I_02.bin
4. MIPS_II_01.bin
5. MIPS_I_03.bin
6. MIPS_II_02.bin
7. MIPS_I_04.bin		

Emulating other MIPS CPU's may use a different set or sequence of these tests.
The goal is to be able to run official code as quickly as possible, in the 
case of N64 emulation it's recommended to get the PIF code running. 

The final step for PIF code to run is verifying the Environment:
8. Environment_PIF.bin
	
## "Test The Tests"
> Code is only as accurate and reliable as it's tests.  

These first tests are very simple and slowly build on each other. The later tests and
their sequence may change but the explanation below would be similar for all of the 
tests in this series.

###Instructions Tested:  
These instructions will receive additional testing later, but these are required for testing.
* syscall
* nop
* beq
* addi 
		
Test Cases  
0. FailNOP - confirm it works. Only time you want to see a failure  
1. GoodNOP - confirm it works. Hopefully a lot more of these in the future.  
2. beq true - Executes syscall for pass or failure  
3. beq false - Executes syscall for pass or failure  
			
Expected Test results (based on example above):
> Test Result - MIPS ISA:1 Set:1  Test:1  Result:Fail  
> Test Result - MIPS ISA:1 Set:1  Test:2  Result:P  
> Test Result - MIPS ISA:1 Set:1  Test:3  Result:P  
> Test Result - MIPS ISA:1 Set:1  Test:4  Result:P  
> 	(Continued...)  
			
Instruction Specific Comments:
* MULT and DIV instructions take more than 1 cycle, Cycle count is tested later
* MTHI, MFHI, MTLO and MFLO needed for mult and div, the 'To' instructions aren't common
* Some tests will also require the Delay slot must be implemented.
* All GPR registers are assumed unsigned 64-bit r0 - ra nothing fancy 
		(r0 and ra will be tested more later)
* All COP0 registers are assumed unsigned 64-bit nothing fancy.

These tests will eventually include environment and advanced feature tests to verify 
registers and memory ranges for reading and writing as well as Cache and TLB features and more.
