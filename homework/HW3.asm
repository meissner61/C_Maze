

.data
# Reserve space for the 2D array 'arr' (3 rows x 5 columns)
arr: .space 60             # 15 integers * 4 bytes each = 60 bytes

# String literals used in the program
newline: .asciiz "\n"
prompt_y: .asciiz "Enter y: "
prompt_x: .asciiz "Enter x: "
str_arr_open: .asciiz "arr["
str_close_open: .asciiz "]["
str_colon_space: .asciiz "]: "
str_address: .asciiz "Address: "

# Number of columns
ncolumns: .word 5          # ncolumns = 5

.text
.globl main

main:
    # Init the array
    li $t0, 0          # y = 0

init_outer_loop:
    bge $t0, 3, init_done      # if y >= 3, exit outer loop

    li $t1, 0          # x = 0

init_inner_loop:
    bge $t1, 5, init_outer_increment_y  # if x >= 5, increment y

    # Calculate num = y * 5
    li $t2, 5
    mul $t3, $t0, $t2          # $t3 = y * 5

    # Calculate value = num + x + 1
    add $t4, $t3, $t1          # $t4 = num + x
    addi $t4, $t4, 1           # $t4 += 1

    # Prepare arguments for arrayAddress
    move $a0, $t0              # $a0 = y (row)
    move $a1, $t1              # $a1 = x (col)
    li $a2, 5                  # $a2 = ncolumns (5)
    la $a3, arr                # $a3 = base address of arr

    # Call arrayAddress
    jal arrayAddress           # Returns address in $v0

    # Store the value into arr[y][x]
    sw $t4, 0($v0)

    addi $t1, $t1, 1           # x++
    j init_inner_loop

init_outer_increment_y:
    addi $t0, $t0, 1           # y++
    j init_outer_loop

init_done:

    #### Print the array elements ####
    li $t0, 0                  # y = 0

print_outer_loop:
    bge $t0, 3, print_done     # if y >= 3, exit loop

    li $t1, 0                  # x = 0

print_inner_loop:
    bge $t1, 5, print_outer_increment_y  # if x >= 5, increment y

    # Print "arr["
    la $a0, str_arr_open
    li $v0, 4                  # syscall: print string
    syscall

    # Print y value
    move $a0, $t0
    li $v0, 1                  # syscall: print integer
    syscall

    # Print "]["
    la $a0, str_close_open
    li $v0, 4
    syscall

    # Print x value
    move $a0, $t1
    li $v0, 1
    syscall

    # Print "]: "
    la $a0, str_colon_space
    li $v0, 4
    syscall

    # Prepare arguments for arrayAddress
    move $a0, $t0              # $a0 = y (row)
    move $a1, $t1              # $a1 = x (col)
    li $a2, 5                  # $a2 = ncolumns (5)
    la $a3, arr                # $a3 = base address of arr

    # Call arrayAddress
    jal arrayAddress           # Returns address in $v0

    # Load arr[y][x] value
    lw $t8, 0($v0)             # $t8 = arr[y][x]

    # Print arr[y][x] value
    move $a0, $t8
    li $v0, 1
    syscall

    # Print newline
    la $a0, newline
    li $v0, 4
    syscall

    addi $t1, $t1, 1           # x++
    j print_inner_loop

print_outer_increment_y:
    addi $t0, $t0, 1           # y++
    j print_outer_loop

print_done:

    #### Prompt user for 'y' and 'x' ####
    # Prompt "Enter y: "
    la $a0, prompt_y
    li $v0, 4
    syscall

    # Read integer into $s0 (y)
    li $v0, 5                  # syscall: read integer
    syscall
    move $s0, $v0

    # Prompt "Enter x: "
    la $a0, prompt_x
    li $v0, 4
    syscall

    # Read integer into $s1 (x)
    li $v0, 5
    syscall
    move $s1, $v0

    #### Display arr[y][x] and its address ####
    # Print "arr["
    la $a0, str_arr_open
    li $v0, 4
    syscall

    # Print y value
    move $a0, $s0
    li $v0, 1
    syscall

    # Print "]["
    la $a0, str_close_open
    li $v0, 4
    syscall

    # Print x value
    move $a0, $s1
    li $v0, 1
    syscall

    # Print "]: "
    la $a0, str_colon_space
    li $v0, 4
    syscall

    # Prepare arguments for arrayAddress
    move $a0, $s0              # $a0 = y (row)
    move $a1, $s1              # $a1 = x (col)
    li $a2, 5                  # $a2 = ncolumns (5)
    la $a3, arr                # $a3 = base address of arr

    # Call arrayAddress
    jal arrayAddress           # Returns address in $v0

    # Load arr[y][x] value
    lw $t8, 0($v0)             # $t8 = arr[y][x]

    # Print arr[y][x] value
    move $a0, $t8
    li $v0, 1
    syscall

    # Print newline
    la $a0, newline
    li $v0, 4
    syscall

    # Print "Address: "
    la $a0, str_address
    li $v0, 4
    syscall

    # Print address of arr[y][x]
    move $a0, $v0              # Address returned in $v0 from arrayAddress
    li $v0, 34                 # syscall: print integer in hexadecimal (MARS-specific)
    syscall

    # Print newline
    la $a0, newline
    li $v0, 4
    syscall

    #### Exit the program ####
    li $v0, 10                 # syscall: exit
    syscall

#### Function: arrayAddress ####
# int* arrayAddress(int row, int col, int ncolumns, array)
# Arguments:
#   $a0: row
#   $a1: col
#   $a2: ncolumns
#   $a3: array base address
# Returns:
#   $v0: address of array[row][col]

arrayAddress:
    # Function prologue
    addi $sp, $sp, -8          # Adjust stack for saved registers
    sw $ra, 4($sp)             # Save return address
    sw $t0, 0($sp)             # Save $t0

    # Compute offset = (row * ncolumns + col) * 4
    mul $t0, $a0, $a2          # $t0 = row * ncolumns
    add $t0, $t0, $a1          # $t0 += col
    sll $t0, $t0, 2            # $t0 *= 4 (size of int)

    # Compute address = array base + offset
    add $v0, $a3, $t0          # $v0 = array base + offset

    # Function epilogue
    lw $t0, 0($sp)             # Restore $t0
    lw $ra, 4($sp)             # Restore return address
    addi $sp, $sp, 8           # Restore stack pointer
    jr $ra                     # Return to caller
