# --------------------- BUBBLE SORT ---------------------
# This program will read in an array from the stack and
#   sort it using bubble sort. The array and size of the
#   array are hard-coded in the .data section


###################### DATA SECTION ##############################
	.data
			
Xarray: .word 20, 19, 18, 17, 16, 15
Xsize: .word 6
space: .asciiz " "
			
###################### CODE SECTION ##############################			
	.text

main:	

    lw $t7, Xsize           # load array size into $t7
    li $t0, 0               # initialize counter for sort loop

############# Outer Sort Loop #############
sort:
    li $t1, 0               # set swapped variable to false

    li $t2, 0               # initialize counter for scan loop
    li $t4, 0               # initialize counter for next element
#------------ Inner Scan Loop -------------
scan:
    la $t3, Xarray          # put address of array in $t3
    add $t3, $t3, $t4       # get next element
    lw $a0, 0($t3)          # put first element of array in $a0
    lw $a1, 4($t3)          # put second element of array in $a1

    jal compare             # call subroutine compare

    bne $v0, 1, less        # do nothing if element is in correct place

    jal swap                # call subroutine swap
    sw $a0, 0($t3)          # write the second element into the first spot
    sw $a1, 4($t3)          # write the first element into the second spot

    less:
    beq $t1, 0, exit        # if no swaps occurred, exit loops

    # scan loop condition
    addi $t2, $t2, 1        # increment scan loop counter
    sub $t6, $t7, $t0       # subtract sort loop counter from Xsize
    sub $t6, $t6, 1         # decrement $t6 by one again
    addi $t4, $t4, 4        # increment $t4 for next element
    blt $t2, $t6, scan      # loop if counter is less than $t6
#------------------------------------------

    # sort loop condition
    addi $t0, $t0, 1        # increment sort loop counter
    blt $t0, $t7, sort      # loop if counter is less than Xsize
###########################################

    j exit                  # jump to end program


#@@@@@@@@@@@ Compare Subroutine @@@@@@@@@@@
compare:
    li $v0, 0               # set $v0 to 0
    sgt $v0, $a0, $a1       # set $v0 to 1 if first element is
                            # greater than the second
    jr $ra
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




#@@@@@@@@@@@@ Swap Subroutine @@@@@@@@@@@@@
swap:
    add  $s0, $0, $a0       # copy first element into $s0
    add  $a0, $0, $a1       # set first element to second element
    add  $a1, $0, $s0       # set second element to first element
    li $t1, 1               # set swapped variable to true
    jr $ra
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




#@@@@@@@@@@@ Print Subroutine @@@@@@@@@@@@@
print:
    li $v0, 1               # system call for int print
    lw $a0, Xarray($a2)     # print the value at array($t1)
    syscall

    li $v0, 4               # system call for string print
    la $a0, space           # print a space
    syscall

    addi $a2, $a2, 4        # increment to next element
    addi $a3, $a3, 1        # increment print loop counter
    blt $a3, $t7, print     # loop to print all elements
    jr $ra
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

exit:
    li $a2, 0               # initialize first counter
    li $a3, 0               # initialize second counter
    jal print               # call subroutine print

    li	$v0,10		    	# code for exit
    syscall				    # exit program
