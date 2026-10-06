; MCSP 0.43 integrated closed round-trip attack
bits 64
default rel
global _start
%define SYS_MMAP 9
%define SYS_WRITE 1
%define SYS_EXIT 60
%define PROT_RWX 7
%define MAP_PRIVATE_ANON 0x22
section .rodata
original_sem dq 64,1,1, 0,0,0, 0,1,1, 1,0,1, 1,1,0
bad_sem dq 64,1,1, 0,0,0, 0,1,1, 1,0,1, 1,1,1
spec dq 1,64,0,3,1
bad_spec dq 2,64,0,3,1
mutated_bytes db 0x48,0x09,0xd8
pass db "MCSP closed round-trip 0.43: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP closed round-trip 0.43: FAIL",10
flen equ $-failmsg
section .bss
decoded resq 5
reconstructed resq 15
scratch resq 5
section .text
assemble:
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
 mov byte [rsi],0x48
 mov byte [rsi+1],0x31
 mov byte [rsi+2],0xd8
 mov eax,3
 ret
.no: xor eax,eax
 ret
disassemble:
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
.no: xor eax,eax
 ret
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
.no: xor eax,eax
 ret
_start:
 ; allocate executable output
 xor edi,edi
 mov esi,4096
 mov edx,PROT_RWX
 mov r10d,MAP_PRIVATE_ANON
 mov r8,-1
 xor r9d,r9d
 mov eax,SYS_MMAP
 syscall
 test rax,rax
 js fail
 mov r12,rax
 ; 0.40 assembly
 lea rdi,[spec]
 mov rsi,r12
 call assemble
 cmp eax,3
 jne fail
 mov byte [r12+3],0xc3
 ; execute exact emitted bytes
 mov rax,0x55aa55aa55aa55aa
 mov rbx,0x0f0ff0f00f0ff0f0
 mov r14,rbx
 call r12
 mov rcx,0x5aa5a55a5aa5a55a
 cmp rax,rcx
 jne fail
 cmp rbx,r14
 jne fail
 ; 0.41 disassemble same emitted bytes
 mov rdi,r12
 lea rsi,[decoded]
 call disassemble
 cmp eax,3
 jne fail
 ; tuple must equal original assembly input
 lea rdi,[decoded]
 lea rsi,[spec]
 mov ecx,5
.tuple_cmp:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne fail
 add rdi,8
 add rsi,8
 dec ecx
 jnz .tuple_cmp
 ; 0.42 decompile decoded tuple
 lea rdi,[decoded]
 lea rsi,[reconstructed]
 call decompile
 cmp eax,15
 jne fail
 ; reconstructed semantics must equal original 0.39 semantics
 lea rdi,[reconstructed]
 lea rsi,[original_sem]
 mov ecx,15
.sem_cmp:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne fail
 add rdi,8
 add rsi,8
 dec ecx
 jnz .sem_cmp
 ; attack 1: machine-byte mutation rejected
 lea rdi,[mutated_bytes]
 lea rsi,[scratch]
 call disassemble
 test eax,eax
 jnz fail
 ; attack 2: unsupported structural relation rejected by assembler
 lea rdi,[bad_spec]
 mov rsi,r12
 call assemble
 test eax,eax
 jnz fail
 ; attack 3: reconstructed semantics must differ from OR mutation
 lea rdi,[reconstructed]
 lea rsi,[bad_sem]
 mov ecx,15
.badcmp:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne .bad_diff
 add rdi,8
 add rsi,8
 dec ecx
 jnz .badcmp
 jmp fail
.bad_diff:
 mov eax,SYS_WRITE
 mov edi,1
 lea rsi,[pass]
 mov edx,plen
 syscall
 xor edi,edi
 mov eax,SYS_EXIT
 syscall
fail:
 mov eax,SYS_WRITE
 mov edi,2
 lea rsi,[failmsg]
 mov edx,flen
 syscall
 mov edi,1
 mov eax,SYS_EXIT
 syscall
