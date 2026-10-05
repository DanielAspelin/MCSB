; MCSP 0.39 native machine description witness
bits 64
default rel
global _start
section .rodata
pass db "MCSP native machine description 0.39: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP native machine description 0.39: FAIL",10
flen equ $-failmsg
section .text
_start:
 ; realization fixture A and B
 mov rax,0x55aa55aa55aa55aa
 mov rbx,0x0f0ff0f00f0ff0f0
 mov r8,rbx
 ; machine transition under qualification
 xor rax,rbx
 ; predicted result from pre-settled structural relation
 mov rcx,0x5aa5a55a5aa5a55a
 cmp rax,rcx
 jne .fail
 ; source preservation obligation
 cmp rbx,r8
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
