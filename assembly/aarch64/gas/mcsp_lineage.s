// MCSP AArch64 / GAS lineage witness 0.32
// Independent realization of LINEAGE-NORMAL-FORM-0.31.
// No C/libc. Linux AArch64 syscall ABI is realization-only.

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
msg_pass: .ascii "MCSP AArch64 lineage 0.32: CONDITIONAL PASS\n"
.equ msg_pass_len, .-msg_pass
msg_fail: .ascii "MCSP AArch64 lineage 0.32: FAIL\n"
.equ msg_fail_len, .-msg_fail

.section .text
.global _start
_start:
    adrp x1, tuples
    add x1, x1, :lo12:tuples

    // H0 = 1469598103934665603 = 0x14650fb0739d0383
    movz x0, #0x0383
    movk x0, #0x739d, lsl #16
    movk x0, #0x0fb0, lsl #32
    movk x0, #0x1465, lsl #48

    // multiplier = 1099511628211 = 0x00000100000001b3
    movz x3, #0x01b3
    movk x3, #0x0100, lsl #32

    mov x2, #(TUPLE_FIELDS*TUPLE_COUNT)
1:
    ldr x4, [x1], #8
    eor x0, x0, x4
    mul x0, x0, x3
    subs x2, x2, #1
    b.ne 1b

    adrp x5, expected
    ldr x5, [x5, :lo12:expected]
    cmp x0, x5
    b.ne fail

pass:
    mov x0, #1
    adrp x1, msg_pass
    add x1, x1, :lo12:msg_pass
    mov x2, #msg_pass_len
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0

fail:
    mov x0, #2
    adrp x1, msg_fail
    add x1, x1, :lo12:msg_fail
    mov x2, #msg_fail_len
    mov x8, #64
    svc #0
    mov x0, #1
    mov x8, #93
    svc #0
