    .data
array:  .space 10             # Reserve space for 10 bytes in the array
newline: .asciiz "\n"
exit_msg: .asciiz "End of program!"

.text
#    .globl main
main:
    li $t0, 99                # Load immediate value 99 (0x63) into $t0
    la $t1, array             # Load the address of the array into $t1
    li $t2, 10                # Set up loop counter (10 iterations)

loop:
    sb $t0, 0($t1)            # Store the byte in the array (store 99 in current position)
    addi $t1, $t1, 1          # Increment the pointer to the next byte in the array
    subi $t2, $t2, 1          # Decrease the loop counter
    bnez $t2, loop            # Continue looping if $t2 is not zero
    
    
   	la $t1, array #Load back the base address of the array into t1
   	li $t2, 10    #loop counter = 10

   
   
loop2:
	lb $a0, 0($t1)
   	li $v0, 1
   	syscall
	jal print_newline
	addi $t1, $t1, 1  #increment the pointer 1 byte forward
	subi $t2, $t2, 1 #decrease loop counter
	bnez $t2, loop2   #Continue looping if $t2 is not 0
	
	
	li $v0, 4
	la $a0, exit_msg
	syscall
	

    # Exit the program (if you are using the MARS simulator)
    li $v0, 10                # System call for exit
    syscall
    
    
   

print_newline:
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
