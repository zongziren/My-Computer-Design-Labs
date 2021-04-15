.text
li t0 0x3
li t1 0x10000020
li t2 0x03010000
sw t2 0(t1)
lw t3 0(t1)
add t4 t0 t2
loop:
addi t3 t3 0x1
beq t4 t3 end
jal loop
end:


