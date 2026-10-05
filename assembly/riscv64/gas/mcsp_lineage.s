# MCSP RISC-V RV64 / GAS lineage witness 0.33
# Independent realization of LINEAGE-NORMAL-FORM-0.31.
# No C/libc. Linux RV64 syscall ABI is realization-only.

.equ OPEN,1
.equ PRESET,2
.equ REALIZATION_DEFINED,3
.equ Q_CONDITIONAL,1
.equ Q_VERIFIED,2
.equ EVENT_NONE,0
.equ EVENT_SETTLE,1
.equ EVENT_NARROW,2
.equ TUPLE_FIELDS,8
.equ TUPLE_COUNT,5

.section .rodata
.align 3
tuples:
.quad 0xA11,0x100,0x101,0xF0,OPEN,Q_CONDITIONAL,1,EVENT_NONE
.quad 0xA11,0x100,0x102,0xF0,OPEN,Q_VERIFIED,1,EVENT_NONE
.quad 0xA11,0x100,0x103,0xF0,PRESET,Q_CONDITIONAL,1,EVENT_SETTLE
.quad 0xA11,0x100,0x104,0x30,OPEN,Q_CONDITIONAL,1,EVENT_NARROW
.quad 0xA11,0x100,0x105,0xF0,REALIZATION_DEFINED,Q_CONDITIONAL,1,EVENT_NONE
expected: .quad 0x0f646d0bb5be8531
msg_pass: .ascii "MCSP RISC-V lineage 0.33: CONDITIONAL PASS\n"
.equ msg_pass_len, .-msg_pass
msg_fail: .ascii "MCSP RISC-V lineage 0.33: FAIL\n"
.equ msg_fail_len, .-msg_fail

.section .text
.global _start
_start:
    la t0,tuples
    li a0,0x14650fb0739d0383
    li t1,1099511628211
    li t2,(TUPLE_FIELDS*TUPLE_COUNT)
1:
    ld t3,0(t0)
    xor a0,a0,t3
    mul a0,a0,t1
    addi t0,t0,8
    addi t2,t2,-1
    bnez t2,1b

    la t0,expected
    ld t3,0(t0)
    bne a0,t3,fail

pass:
    li a0,1
    la a1,msg_pass
    li a2,msg_pass_len
    li a7,64
    ecall
    li a0,0
    li a7,93
    ecall

fail:
    li a0,2
    la a1,msg_fail
    li a2,msg_fail_len
    li a7,64
    ecall
    li a0,1
    li a7,93
    ecall
