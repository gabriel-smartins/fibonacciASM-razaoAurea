.data
  
  msg_fib30: .asciiz "O valor do 30° termo da Série de Fibonacci é: "
  msg_fib41: .asciiz "\nO valor do 41° termo da Série de Fibonacci é: "
  msg_fib40: .asciiz "\nO valor do 40° termo da Série de Fibonacci é: "
  msg_phi: .asciiz "\nO valor da razão áurea phi é: "

.text
  .globl main

main:

  li $a0, 30            
  jal fibonacci
  move $s1, $v0         

  
  li $a0, 41            
  jal fibonacci
  move $s2, $v0        

  
  li $a0, 40           
  jal fibonacci
  move $s3, $v0 
  
  mtc1 $s2, $f4         # move F_41 para o registrador de ponto flutuante $f4
  mtc1 $s3, $f6         # move F_40 para o registrador de ponto flutuante $f6
  cvt.s.w $f4, $f4      # converte F_41 para ponto flutuante
  cvt.s.w $f6, $f6      # converte F_40 para ponto flutuante
  div.s $f0, $f4, $f6   # calcula phi = F_41 / F_40 em ponto flutuante
  
  li $v0, 4
  la $a0, msg_fib30
  syscall

  li $v0, 1
  move $a0, $s1
  syscall

  li $v0, 4
  la $a0, msg_fib41
  syscall

  li $v0, 1
  move $a0, $s2
  syscall

  li $v0, 4
  la $a0, msg_fib40
  syscall

  li $v0, 1
  move $a0, $s3
  syscall

  li $v0, 4
  la $a0, msg_phi
  syscall

  li $v0, 2
  mov.s $f12, $f0
  syscall

  
  li $v0, 10
  syscall


fibonacci:
  li $t0, 0            
  li $t1, 1            
  beq $a0, 0, fib_return_zero  
  beq $a0, 1, fib_return_one   

  li $t2, 2            
fib_loop:
  add $t3, $t0, $t1    
  move $t0, $t1        
  move $t1, $t3        
  addi $t2, $t2, 1     

  bne $t2, $a0, fib_loop 

  move $v0, $t3        
  jr $ra              

fib_return_zero:
  move $v0, $t0
  jr $ra

fib_return_one:
  move $v0, $t1
  jr $ra