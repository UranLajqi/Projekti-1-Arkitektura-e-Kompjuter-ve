.data
  hapsire:	.asciiz " "
  sheno:	.asciiz "Enter the number of terms of series : "
  seria:	.asciiz "\nFibonnaci Series : "
  
.text

main:
  li $v0, 4
  la $a0, sheno	   # printimi i tekstit qe gjendet tek sheno
  syscall

  li $v0, 5	  # ja mundeson perdoruesit ta shenoj numrin nga tastiera
  syscall
  move $t4, $v0   # e vendosim numrin e dhene nga tastiera ne $t4

  addi $t0, $zero, 0	# deklarimi dhe inicializimi i variables i=0

  li $v0, 4
  la $a0, seria	   # printimi i tekstit qe gjendet tek seria
  syscall

  while:
     bgt $t4, $t0, Shtyp	    # nese x=$t4 > i=$t0 atehere shko te 
     j Exit		    # labela Shtyp, nese jo shkon te Exit
	
     Shtyp:
        move $a1, $t0	# e vendosim i=$t0 ne $a1 per ta derguar 
			# si argument ne funksionin fib 
        jal fib		# thirrja e funksionit

        li $v0, 1
        move $a0, $v1	# printimi i rezultatit qe na e kthen funksioni
        syscall
		
	li $v0, 4
	la $a0, hapsire    # printimi i hapsires
	syscall
		
	addi $t0, $t0, 1   # i++
	j while		   # kercimi te labeli while

  Exit:
    li $v0, 10	# terminimi i programit
    syscall

  fib:
    bne $a1, $zero, elseIf	# nese x=$a1 nuk eshte 0 shkon te labeli elseIf	
    add $v1, $zero, $a1		# return(x)
    jr $ra				
	
    elseIf:
      addi $t1, $zero, 1		# $t1=1 
      bne $a1, $t1, else		# nese x=$a1 nuk eshte 1 shkon te labeli else
      add $v1, $zero, $a1		# return(x)
      jr $ra

    else:
      # As callee, save return address and saved registers
      addi $sp, $sp, -12           # Adjust stack for pushing 3 items
      sw $ra, 8($sp)               # Push return address to stack
      sw $s0, 4($sp)               # Push $s0 to stack
      sw $s1, 0($sp)               # Push $s1 to stack

      # As caller, save arguments
      addi $s0, $a1, -1         # Store n-1 in $s0

      # fib(n-1)
      move $a1, $s0             # Set argument to n-1
      jal fib                   # fib(n-1)
      move $s1, $v1             # Store returned value in $s0

      # fib(n-2)
      addi $s0, $s0, -1         # Calculate n-2 in $s0
      move $a1, $s0             # Set argument to n-2
      jal fib                   # fib(n-2)
    
      # Set return value
      add $v1, $v1, $s1         # Store returned value in $t0

      # Pop registers from the stack
      lw $s1, 0($sp)               # Pop $s1 off stack
      lw $s0, 4($sp)               # Pop $s0 off stack
      lw $ra, 8($sp)               # Pop return address off stack
      addi $sp, $sp, 12            # Adjust stack for popping 3 items off

      jr $ra                         # Return
