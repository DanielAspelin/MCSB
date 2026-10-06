; MCSP 0.41 bounded disassembler
bits 64
default rel
global _start
section .rodata
good db 0x48,0x31,0xd8
bad_opcode db 0x48,0x09,0xd8
bad_width db 0x31,0xd8,0x90
expected dq 1,64,0,3,1
pass db "MCSP disassembler 0.41: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP disassembler 0.41: FAIL",10
flen equ $-failmsg
section .bss
out resq 5
section .text
; decode(rdi=bytes,rsi=tuple) -> eax=3 consumed, 0 unsupported
decode:
 cmp byte [rdi],0x48
 jne .no
 cmp byte [rdi+1],0x31
 jne .no
 cmp byte [rdi+2],0xd8
 jne .no
 mov qword [rsi],1
 mov qword [rsi+8],64
 mov qword [rsi+16],0
 mov qword [rsi+24],3
 mov qword [rsi+32],1
 mov eax,3
 ret
.no:
 xor eax,eax
 ret
_start:
 lea rdi,[good]
 lea rsi,[out]
 call decode
 cmp eax,3
 jne fail
 lea rdi,[out]
 lea rsi,[expected]
 mov ecx,5
.check:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne fail
 add rdi,8
 add rsi,8
 dec ecx
 jnz .check
 ; mutated opcode rejected
 lea rdi,[bad_opcode]
 lea rsi,[out]
 call decode
 test eax,eax
 jnz fail
 ; missing 64-bit prefix / incompatible byte sequence rejected
 lea rdi,[bad_width]
 lea rsi,[out]
 call decode
 test eax,eax
 jnz fail
 mov eax,1
 mov edi,1
 lea rsi,[pass]
 mov edx,plen
 syscall
 xor edi,edi
 mov eax,60
 syscall
fail:
 mov eax,1
 mov edi,2
 lea rsi,[failmsg]
 mov edx,flen
 syscall
 mov edi,1
 mov eax,60
 syscall
