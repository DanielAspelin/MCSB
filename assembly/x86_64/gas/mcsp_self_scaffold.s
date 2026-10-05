# MCSP 0.37 x86-64 GAS self-scaffold structural projection
# Independent assembler realization. Documentary names are excluded from hash input.
.equ PAIRS,8
.section .rodata
.align 8
scaffold:
.quad 1,0xA11, 2,0xF0, 3,1, 4,1, 5,1, 6,0, 7,0x100, 8,0
expected:
.quad 0x9d6b7df91f1a67c5
msg_pass: .ascii "MCSP GAS self-scaffold 0.37: CONDITIONAL PASS\n"
.equ plen,.-msg_pass
msg_fail: .ascii "MCSP GAS self-scaffold 0.37: FAIL\n"
.equ flen,.-msg_fail
.section .text
.global _start
_start:
 lea scaffold(%rip),%rsi
 movabs $0x14650fb0739d0383,%rax
 movabs $1099511628211,%r8
 mov $(PAIRS*2),%ecx
1:
 xor (%rsi),%rax
 imul %r8,%rax
 add $8,%rsi
 dec %ecx
 jnz 1b
 cmp expected(%rip),%rax
 jne fail
 mov $1,%eax
 mov $1,%edi
 lea msg_pass(%rip),%rsi
 mov $plen,%edx
 syscall
 xor %edi,%edi
 mov $60,%eax
 syscall
fail:
 mov $1,%eax
 mov $2,%edi
 lea msg_fail(%rip),%rsi
 mov $flen,%edx
 syscall
 mov $1,%edi
 mov $60,%eax
 syscall
