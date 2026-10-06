; MCSP 0.42 bounded decompiler
bits 64
default rel
global _start
section .rodata
; decoded tuples as supplied by the 0.41 boundary
good dq 1,64,0,3,1
bad_relation dq 2,64,0,3,1
bad_width dq 1,32,0,3,1
; semantic output layout:
; width, source_preserved, destination_replaced, then four A/B/Z triples
expected dq 64,1,1, 0,0,0, 0,1,1, 1,0,1, 1,1,0
incompatible_or dq 64,1,1, 0,0,0, 0,1,1, 1,0,1, 1,1,1
pass db "MCSP decompiler 0.42: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP decompiler 0.42: FAIL",10
flen equ $-failmsg
section .bss
semantic resq 15
section .text
; decompile(rdi=decoded tuple,rsi=semantic output) -> eax=15 qwords or 0 unsupported
decompile:
 cmp qword [rdi],1
 jne .no
 cmp qword [rdi+8],64
 jne .no
 cmp qword [rdi+16],0
 jne .no
 cmp qword [rdi+24],3
 jne .no
 cmp qword [rdi+32],1
 jne .no
 mov qword [rsi],64
 mov qword [rsi+8],1
 mov qword [rsi+16],1
 mov qword [rsi+24],0
 mov qword [rsi+32],0
 mov qword [rsi+40],0
 mov qword [rsi+48],0
 mov qword [rsi+56],1
 mov qword [rsi+64],1
 mov qword [rsi+72],1
 mov qword [rsi+80],0
 mov qword [rsi+88],1
 mov qword [rsi+96],1
 mov qword [rsi+104],1
 mov qword [rsi+112],0
 mov eax,15
 ret
.no:
 xor eax,eax
 ret
_start:
 lea rdi,[good]
 lea rsi,[semantic]
 call decompile
 cmp eax,15
 jne fail
 ; compare reconstructed semantic structure to pre-settlement
 lea rdi,[semantic]
 lea rsi,[expected]
 mov ecx,15
.check:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne fail
 add rdi,8
 add rsi,8
 dec ecx
 jnz .check
 ; incompatible OR relation must not equal reconstruction
 lea rdi,[semantic]
 lea rsi,[incompatible_or]
 mov ecx,15
 xor r8d,r8d
.diff:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne .different
 add rdi,8
 add rsi,8
 dec ecx
 jnz .diff
 jmp fail
.different:
 ; unsupported relation rejected
 lea rdi,[bad_relation]
 lea rsi,[semantic]
 call decompile
 test eax,eax
 jnz fail
 ; incompatible width rejected
 lea rdi,[bad_width]
 lea rsi,[semantic]
 call decompile
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
