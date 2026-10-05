# MCSP x86-64 / GAS lineage witness 0.31
# Independent realization of the 0.31 projection contract. AT&T syntax.
# No C/libc. Linux syscall ABI is a realization constraint, not semantics.

.set OPEN,1
.set PRESET,2
.set REALIZATION_DEFINED,3
.set Q_FAILED,0
.set Q_CONDITIONAL,1
.set Q_VERIFIED,2
.set EVENT_NONE,0
.set EVENT_SETTLE,1
.set EVENT_NARROW,2

.section .rodata
# tuple: invariant,parent,child,applicability,status,qualification,residue,event
tuples:
.quad 0xA11,0x100,0x101,0xF0,OPEN,Q_CONDITIONAL,1,EVENT_NONE
.quad 0xA11,0x100,0x102,0xF0,OPEN,Q_VERIFIED,1,EVENT_NONE
.quad 0xA11,0x100,0x103,0xF0,PRESET,Q_CONDITIONAL,1,EVENT_SETTLE
.quad 0xA11,0x100,0x104,0x30,OPEN,Q_CONDITIONAL,1,EVENT_NARROW
.quad 0xA11,0x100,0x105,0xF0,REALIZATION_DEFINED,Q_CONDITIONAL,1,EVENT_NONE
.set TUPLE_FIELDS,8
.set TUPLE_COUNT,5
expected:
.quad 0x0f646d0bb5be8531
msg_pass: .ascii "MCSP GAS lineage 0.31: CONDITIONAL PASS\n"
.set msg_pass_len, .-msg_pass
msg_fail: .ascii "MCSP GAS lineage 0.31: FAIL\n"
.set msg_fail_len, .-msg_fail

.section .text
.global _start
_start:
    leaq tuples(%rip),%rsi
    movq $1469598103934665603,%rax
    movq $(TUPLE_FIELDS*TUPLE_COUNT),%rcx
    movabsq $1099511628211,%r8
.fold:
    xorq (%rsi),%rax
    imulq %r8,%rax
    addq $8,%rsi
    decq %rcx
    jnz .fold
    cmpq expected(%rip),%rax
    jne .fail
.pass:
    movq $1,%rax
    movq $1,%rdi
    leaq msg_pass(%rip),%rsi
    movq $msg_pass_len,%rdx
    syscall
    xorq %rdi,%rdi
    movq $60,%rax
    syscall
.fail:
    movq $1,%rax
    movq $2,%rdi
    leaq msg_fail(%rip),%rsi
    movq $msg_fail_len,%rdx
    syscall
    movq $1,%rdi
    movq $60,%rax
    syscall
