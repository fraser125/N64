// TLB tests made by Dudejoe870
    // Set up a TLB Entry to map 0x80002000 to 0x80000000
    li a0, (0x00000000 << 6) | 0x7
    mtc0 a0, EntryLo0
    mtc0 a0, EntryLo1
    li a0, (0x000 << 13)
    mtc0 a0, PageMask
    li a0, (0x00000001 << 13) | 0x00
    mtc0 a0, EntryHi
    li a0, 3
    mtc0 a0, Index
    tlbwi
    
test1: // Read Test
    lui a0, 0x8000
    li t1, 1
    sw t1, $0(a0)
    xor a0, a0
    ori a0, 0x2000
    lw t0, $0(a0)
    
    bne t1, t0, test1F
    nop
test1P: // Pass
    //syscallUTE(1, 1, 'P')
    nop
    b test2
    nop
test1F: // or Fail
    //syscallUTE(1, 1, 'F')
    nop
test2: // Write Test
    li t1, 2
    sw t1, $0(a0)
    lui a0, 0x8000
    lw t0, $0(a0)
    
    bne t1, t0, test2F
    nop
test2P: // Pass
    //syscallUTE(1, 2, 'P')
    nop
    b test3
    nop
test2F: // or Fail
    //syscallUTE(1, 2, 'F')
    nop
test3: // Probe Test
    tlbp
    mfc0 a0, $0
    li a1, 3
    bne a0, a1, test3F
    nop
test3P: // Pass
    //syscallUTE(1, 3, 'P')
    nop
    b test4
    nop
test3F: // or Fail
    //syscallUTE(1, 3, 'F')
    nop
test4:
    b test4
    nop