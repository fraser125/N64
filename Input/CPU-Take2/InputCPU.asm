// N64 'Bare Metal' Input CPU Demo by krom (Peter Lemon):
arch n64.cpu
endian msb
output "InputCPU.N64", create
fill 1052672 // Set ROM Size

origin $00000000
base $80000000 // Entry Point Of Code
include "LIB/N64.INC" // Include N64 Definitions
include "LIB/N64_GFX.INC" // Include Graphics Macros
include "LIB/N64_INPUT.INC" // Include Input Macros
include "LIB/N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
insert "LIB/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code

Start:
	N64_INIT() // Run N64 Initialisation Routine

	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000

	lui t0,$A010 // A0 = VRAM Start Offset
	la t1,$A0100000+(320*240*4)-4 // A1 = VRAM End Offset
	
Clear:
	sw r0, 0(t0)
	bne t0, t1, Clear
	addi t0, 4
	
	// Initialize Controllers
	lui t0,SI_BASE 				// A0 = SI Base Register ($A4800000)
	
	la t1,PIF_SINGLE_REQUEST	// A1 = PIF1 Offset
	sw t1,SI_DRAM_ADDR(t0) 		// Store PIF1 To SI_DRAM_ADDR ($A4800000)
	
	lui t1, PIF_BASE			// A1 = PIF_RAM: JoyChannel ($BFC007C0)
	ori t1, PIF_RAM	
	sw t1,SI_PIF_ADDR_WR64B(t0) // 64 Byte Write DRAM -> PIF ($A4800010)
	
	ori s0, r0, 160				// Pixel X Position
	ori s1, r0, 120				// Pixel Y Position
	//lui t0, $A010				
	//li t1, (120*320*4)+(160*4)	// Set Starting Pixel Location 120 lines from the top, 160 pixels from the left
	//add s0, t0, t1
	
Loop:
	WaitScanline($1E0) // Wait For Scanline To Reach Vertical Blank
	
	// Send Controller Request
	la t0, PIF_SINGLE_REQUEST
	lui t1, SI_BASE
	ori t1, t1, SI_DRAM_ADDR
	sw t0, 0(t1)
	
	lui t0, PIF_BASE
	ori t0, t0, PIF_RAM	
	lui t1, SI_BASE
	ori t1, t1, SI_PIF_ADDR_WR64B
	sw t0, 0(t1)
		
	// Spin Waiting for completion
	jal SI_STATUS_WAIT_UNTIL_NOT_BUSY
	nop
	
	// Receive Controller Response
	la t0, PIF_RESPONSE
	lui t1, SI_BASE
	ori t1, t1, SI_DRAM_ADDR
	sw t0, 0(t1)
	
	lui t0, PIF_BASE
	ori t0, t0, PIF_RAM	
	lui t1, SI_BASE
	ori t1, t1, SI_PIF_ADDR_RD64B
	sw t0, 0(t1)

	// Spin waiting for DMA
	jal SI_STATUS_WAIT_UNTIL_NOT_BUSY
	nop
	
	// Process Input
	la t0, PIF_RESPONSE
	lw t0, 4(t0) 				// Offset to P1 Controller Data
	
	// X axis left/right direction...  ± 61
	// Y axis up/down direction...  ± 63
	// X axis diagonal direction...  ± 45
	// Y axis diagonal direction...  ± 47

	andi t1, t0, $FF00 // X-Axis
	andi t2, t0, $00FF // Y-Axis
	
	srl t1, t1, 2		// 2>>
	srl t2, t2, 2		// 2>>
	
	add s0, s0, t1
	add s1, s1, t2
	
	subi t1, s0, 320
	bgtz t1, CheckY
	nop
	add s0, r0, t1  // Wrap Around

CheckY:
	subi t2, s1, 240
	bgtz t2, drawPixel
	nop
	add s1, r0, t2	// Wrap Around
	
drawPixel:
	// Multiply S0, S1 to final pixel location
	addi t4, r0, 320
	mult t4, s0
	mflo t4
	sll t0, t4, 2	// 4 bytes per pixel so multiply by 4
	sll t1, s1, 2	// 4 bytes per pixel so multiply by 4
	add t2, t0, t1
	
Render:
  li t0,$FFFFFFFF
  sw t0,0(t2)

  j Loop
  nop // Delay Slot

SI_STATUS_WAIT_UNTIL_NOT_BUSY:
	lui a0, SI_BASE
	ori a0, a0, SI_STATUS
ReadSIStatus:
	lw a1, 0(a0)
	ori a1, a1, 0x03 			// SI_STATUS_IO_BUSY | SI_STATUS_DMA_BUSY
	bne a1, r0, ReadSIStatus
	nop
	jr ra
	nop

align(8) // Align 64-Bit
PIF_SINGLE_REQUEST:
	dw $FF010401,0
	dw $FE000000,0
	dw 0,0
	dw 0,0
	dw 0,0
	dw 0,0
	dw 0,0
	dw 0,1

align(8) // Align 64-Bit
PIF_RESPONSE:
	fill 64 // Generate 64 Bytes Containing $00