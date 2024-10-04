
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

    # Calculate arr[y][x] = y * 5 + x + 1
    li $t2, 5
    mul $t3, $t0, $t2          # $t3 = y * 5
    add $t3, $t3, $t1          # $t3 += x
    addi $t3, $t3, 1           # $t3 += 1

    # Compute address of arr[y][x]
    mul $t5, $t0, $t2          # $t5 = y * 5
    add $t5, $t5, $t1          # $t5 += x
    sll $t5, $t5, 2            # $t5 *= 4 (byte offset)
    la $t6, arr                # $t6 = base address of arr
    add $t7, $t6, $t5          # $t7 = address of arr[y][x]

    # Store the value into arr[y][x]
    sw $t3, 0($t7)

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

    # Load arr[y][x]
    mul $t5, $t0, $t2          # $t5 = y * 5
    add $t5, $t5, $t1          # $t5 += x
    sll $t5, $t5, 2            # $t5 *= 4
    la $t6, arr
    add $t7, $t6, $t5          # $t7 = &arr[y][x]
    lw $t8, 0($t7)             # $t8 = arr[y][x]

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

    # Calculate address and load arr[y][x]
    mul $t5, $s0, $t2          # $t5 = y * 5
    add $t5, $t5, $s1          # $t5 += x
    sll $t5, $t5, 2            # $t5 *= 4
    la $t6, arr
    add $t7, $t6, $t5          # $t7 = &arr[y][x]
    lw $t8, 0($t7)             # $t8 = arr[y][x]

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
    move $a0, $t7
    li $v0, 34                 # syscall: print integer in hexadecimal 
    syscall

    # Print newline
    la $a0, newline
    li $v0, 4
    syscall

    # Exit 
    li $v0, 10                 # syscall: exit
    syscall
