# Author:	Vlad Lopatinsky
# Date:		Oct 9, 2024
# Description:	Homework #3: Find 2D array content by row/col

.data
askrow:	.asciiz	"Enter row in the range [0..2]: "
askcol:	.asciiz	"Enter column in the range [0..4]: "
print:	.asciiz	"array[row][col] = "
newline: .asciiz "\n"
indicie: .word 0xFFFF
row: .word 0xF
col .word 0xF

# array oinitialization
array:
	.word	  1, 2, 3, 4, 5
	.word	  6, 7, 8, 9,10
	.word	  11,12,13,14,15

.text

    # (Y,X) or(row,col) for testing -> should be spitting out the indicie, aka arr[0->14]
	addi, $s0, $s0, 1	# Y
	addi, $s1, $s1, 0	# X
	# Store the variables for later use
	sw $s0, row
	sw $s1, col

    