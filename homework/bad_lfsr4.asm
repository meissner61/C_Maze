.data
# Strings used for printing
output_str:      .asciiz "  |  output: "
lsb_bit0_str:    .asciiz "   LSB: bit0: "
comma_bit1_str:  .asciiz ", bit1: "
newline_str:     .asciiz "\n"

.text
.globl main

# Main function
main:
    # Call lfsr_4(0)
    li $a0, 0          # Argument num4Bit = 0 (unused in lfsr_4)
    jal lfsr_4

    # Exit the program
    li $v0, 10         # Syscall code for exit
    syscall

# Function: lfsr_4
# Simulates a 4-bit LFSR and prints the results
lfsr_4:
    # Function prologue
    addi $sp, $sp, -8  # Allocate stack space
    sw $ra, 4($sp)     # Save return address
    sw $s0, 0($sp)     # Save $s0 (used for lfsr)

    # Initialize variables
    li $t0, 9          # start = 0b1001 (9)
    move $s0, $t0      # lfsr = start

lfsr_loop:
    # Call print4BitBinary(lfsr)
    move $a0, $s0
    jal print4BitBinary

    # output = lfsr & 1
    andi $t5, $s0, 1

    # Print "  |  output: "
    la $a0, output_str
    li $v0, 4          # Syscall code for print string
    syscall

    # Print output value
    move $a0, $t5
    li $v0, 1          # Syscall code for print integer
    syscall

    # Print "   LSB: bit0: "
    la $a0, lsb_bit0_str
    li $v0, 4
    syscall

    # bit0 = lfsr & 1
    andi $t1, $s0, 1

    # bit1 = (lfsr >> 1) & 1
    srl $t2, $s0, 1
    andi $t2, $t2, 1

    # newBit = bit0 ^ bit1
    xor $t3, $t1, $t2

    # Print bit0 value
    move $a0, $t1
    li $v0, 1
    syscall

    # Print ", bit1: "
    la $a0, comma_bit1_str
    li $v0, 4
    syscall

    # Print bit1 value
    move $a0, $t2
    li $v0, 1
    syscall

    # Print newline
    la $a0, newline_str
    li $v0, 4
    syscall

    # Shift lfsr right by 1
    srl $s0, $s0, 1

    # Insert newBit into the 4th bit (MSB)
    sll $t4, $t3, 3
    or $s0, $s0, $t4

    # Loop until lfsr == start
    bne $s0, $t0, lfsr_loop

    # Function epilogue
    lw $s0, 0($sp)     # Restore $s0
    lw $ra, 4($sp)     # Restore return address
    addi $sp, $sp, 8   # Deallocate stack space
    jr $ra             # Return

# Function: print4BitBinary
# Prints a 4-bit binary representation of a number
print4BitBinary:
    # Function prologue
    addi $sp, $sp, -8  # Allocate stack space
    sw $ra, 4($sp)     # Save return address
    sw $s0, 0($sp)     # Save $s0 (used for n)

    # n = n & 0xF
    andi $s0, $a0, 0xF

    # Initialize i = 3
    li $t1, 3

print_loop:
    # bit = (n >> i) & 1
    srlv $t2, $s0, $t1   # Use srlv for variable shift
    andi $t2, $t2, 1

    # Print bit value
    move $a0, $t2
    li $v0, 1          # Syscall code for print integer
    syscall

    # Decrement i
    addi $t1, $t1, -1

    # Loop while i >= 0
    bgez $t1, print_loop

    # Function epilogue
    lw $s0, 0($sp)     # Restore $s0
    lw $ra, 4($sp)     # Restore return address
    addi $sp, $sp, 8   # Deallocate stack space
    jr $ra             # Return
