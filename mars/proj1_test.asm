    .data
array: .space 100          # Allocate 100 bytes (10x10 characters)
newline: .asciiz "\n"      # Newline character for printing

    .text
    .globl main
main:
    # Initialize array to zero
    la $t0, array          # Load base address of array into $t0
    li $t1, 100            # Total elements to initialize
    li $t2, 0              # Loop counter i = 0

Init_Loop:
    bge $t2, $t1, Print_Loop # If i >= 100, exit initialization loop
    sb $zero, 0($t0)         # Store zero in the current byte
    addi $t0, $t0, 1         # Move to the next byte
    addi $t2, $t2, 1         # Increment counter i
    j Init_Loop              # Repeat loop

Print_Loop:
    li $t3, 0              # Row index i = 0

Row_Loop:
    bge $t3, 10, End_Program # If i >= 10, end program
    li $t4, 0                # Column index j = 0

Column_Loop:
    bge $t4, 10, New_Line    # If j >= 10, move to next line
    # Calculate linear index: index = i * number_of_columns + j
    mul $t5, $t3, 10         # t5 = i * 10
    add $t5, $t5, $t4        # t5 = t5 + j
    la $t6, array            # Load base address of array
    add $t6, $t6, $t5        # t6 = base_address + index
    lb $t7, 0($t6)           # Load the byte at array[i][j]

    # Check if the element is zero
    bne $t7, $zero, Skip_Print  # If array[i][j] != 0, skip printing '#'

    # Print '#'
    li $v0, 11               # Syscall code for print_char
    li $a0, '#'              # ASCII code for '#'
    syscall

    j Next_Column            # Move to the next column

Skip_Print:
    # For non-zero elements, you can choose to print a different character
    # For this example, we'll print a space
    li $v0, 11               # Syscall code for print_char
    li $a0, ' '              # ASCII code for space
    syscall

Next_Column:
    addi $t4, $t4, 1         # Increment column index j
    j Column_Loop            # Repeat column loop

New_Line:
    # Print newline character
    li $v0, 4                # Syscall code for print_string
    la $a0, newline          # Address of newline string
    syscall

    addi $t3, $t3, 1         # Increment row index i
    j Row_Loop               # Repeat row loop

End_Program:
    # Exit the program
    li $v0, 10               # Syscall code for exit
    syscall
