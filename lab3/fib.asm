.data
number1: .byte 3
number2: .byte 20
delimiter:  .string      ", "
.text
la t0 number1
lw t2 0(t0)
la t0 number2
lw t3 0(t0)
addi a0 t2 0
call print2
call print1
addi a0 t3 0
call print2
call print1
add t4 t2 t3
loop:
addi a0 t4 0
call print2
call print1
addi t5 t4 0
add t4 t3 t4
addi t3 t5 0
j loop


print1:
li a7 4
la a0 delimiter
ecall
ret

print2:
li a7 1
ecall
ret