; MCSP 0.37 NASM self-scaffold structural projection
bits 64
default rel
global _start
%define PAIRS 8
section .rodata
scaffold: dq 1,0xA11, 2,0xF0, 3,1, 4,1, 5,1, 6,0, 7,0x100, 8,0
expected: dq 0x9d6b7df91f1a67c5
pass db "MCSP NASM self-scaffold 0.37: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP NASM self-scaffold 0.37: FAIL",10
flen equ $-failmsg
section .text
_start:
 lea rsi,[scaffold]
 mov rax,0x14650fb0739d0383
 mov r8,1099511628211
 mov ecx,PAIRS*2
.loop:
 xor rax,[rsi]
 imul rax,r8
 add rsi,8
 dec ecx
 jnz .loop
 cmp rax,[expected]
 jne .fail
 mov eax,1
 mov edi,1
 lea rsi,[pass]
 mov edx,plen
 syscall
 xor edi,edi
 mov eax,60
 syscall
.fail:
 mov eax,1
 mov edi,2
 lea rsi,[failmsg]
 mov edx,flen
 syscall
 mov edi,1
 mov eax,60
 syscall
