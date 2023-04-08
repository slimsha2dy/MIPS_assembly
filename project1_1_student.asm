.data
string: .asciiz "Welcome to Computer Architecture"
string_end:

.text
.main:
	# $a1 points to beginning of string
	la $a1, string
	
	# $a2 points to beginning of string_end (end of string)
	la $a2, string_end
	
	# $a0 = 0
	li $a0, 0
	
Loop:	# while ($a1 != $a2)
	beq $a1, $a2, Exit
	
	# loading first character to $t0
	lb $t0, ($a1)
	
	# add $a0 to $t0
	add $a0, $a0, $t0
	
	# incrementing pointer to point to next character
	addi $a1, $a1, 1
	
	j Loop
	
Exit:	# print sum (stored in $a0)
	li $v0, 1
	syscall
	
	# exit program
	li $v0, 10
	syscall


