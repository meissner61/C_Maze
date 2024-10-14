

#Examples
#	Y * num_cols + X = indicie
#       #8 = 7th array indicie, = (1,2) (y,x) = 1 * 5 + 2 = 7
#       #1 = 0th array indicie = (0,0) = 0 x 5 + 0 = 0
#######################################################################
.data

	arr: .word 1, 2, 3, 4, 5
	     .word 6, 7, 8, 9, 10
	     .word 11, 12, 13, 14, 15
	     
	newLine: .asciiz "\n"
	msg1: .asciiz "The integer of selected [row, col] is: "
	msg2: .asciiz "The address of selected [row,col] is: "
	indicie: .word 0xFFFF
	
	row: .word 0xF
	col: .word 0xF
	     
.text

	lw $a0, arr
	addi $a0, $a0, 14
	li, $v0, 1
	syscall
	jal print_newline
	
	# (Y,X) or(row,col) for testing -> should be spitting out the indicie, aka arr[0->14]
	addi, $s0, $s0, 1	# Y
	addi, $s1, $s1, 0	# X
	# Store the variables for later use
	sw $s0, row
	sw $s1, col
	
	
	#add the constant 5 = num of collumns
	# Y * num_cols(5) + X = indicie
	addi $t0, $t0, 5
	mult $s0, $t0		# Note: Result is stored in $lo (or both $lo and $hi if overflow)
	mflo $s0		# Move the value stored in $lo register to $s0
	add $s0, $s0, $s1
	
	#Store the value in $s0 to .data
	sw $s0, indicie
	
	#lw $a0, 0($s0) #Why this does not work?
	#la $a0, 0($s0)		#This works 
	move $a0, $s0
	li $v0, 1
	syscall
	jal print_newline
	li $t0, 0 # $t0 = i = 0

#Print the array		
loop:
	li $s0, 14	#while #t1 <= 15
	bge $t0, $s0, end
	
	lw $a0, arr
	add $a0, $a0, $t0 #Add the offset (which is stored in $t0, $t0 is also the counter)
	li $v0, 1
	syscall
	
	jal print_newline
	
	
	addi $t0, $t0, 1

	j loop

end:	

	#print address
	li $t0, 0 # test offset
	la $a0, arr
	sll $t0, $t0, 2   # Multiply offset by 4 (word size is 4 bytes) = sll $dest, $src, shift_amount
	add $a0, $a0, $t0
	
	li $v0, 34
	syscall
	
	jal print_newline
	
	li $v0, 5 # input integer
	syscall
	#move $t0, $v0
	
	la $t1, row
	sw $v0, 0($t1)
	
	#move row, $v0

	li $v0, 5
	syscall
	la $t1, col
	sw $v0, 0($t1)
	
	# Calculate address and display array contents
	move $t0, $zero		#zero out $t1
	addi $t0, $t0, 5
	lw $s0, row
	lw $s1, col
	mult $s0, $t0		# Note: Result is stored in $lo (or both $lo and $hi if overflow)
	mflo $s0		# Move the value stored in $lo register to $s0
	add $s0, $s0, $s1
	sw $s0, indicie         # $s0 now also holds indicie for now
	
	
	jal print_msg2
	
	#Print address of selected indicie
	la $a0, arr
	sll $s0, $s0, 2   # Multiply offset by 4 (word size is 4 bytes) = sll $dest, $src, shift_amount
	add $a0, $a0, $s0
	#print
	li $v0, 34
	syscall
	
	jal print_newline
	jal print_msg1
	
	lw $a0, arr
	lw $t1, indicie
	add $a0, $a0, $t1
	li $v0, 1
	syscall
	
	#Exit
	li, $v0, 10
	syscall
	
	
	
print_newline:
	li $v0, 4
	la $a0, newLine
	syscall
	jr $ra
	
print_msg1:
	li $v0, 4
	la $a0, msg1
	syscall
	jr $ra
	
print_msg2:
	li $v0, 4
	la $a0, msg2
	syscall
	jr $ra
