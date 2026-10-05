; MCSP 0.38 decompilation qualification fixture
; Machine behavior intentionally contains a compact structural algorithm:
; accumulator H starts at H0, then for each qword: H=(H XOR field)*P.
bits 64
default rel
global _start
section .rodata
fields dq 1,0xA11,2,0xF0,3,1,4,1,5,1,6,0,7,0x100,8,0
expected dq 0x8c8892de1e018683
pass db "MCSP decompilation 0.38 fixture: PASS",10
plen equ $-pass
failmsg db "MCSP decompilation 0.38 fixture: FAIL",10
flen equ $-failmsg
section .text
_start:
 lea rsi,[fields]
 mov rax,0x14650fb0739d0383
 mov r8,1099511628211
 mov ecx,16
.next:
 xor rax,[rsi]
 imul rax,r8
 add rsi,8
 dec ecx
 jnz .next
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
