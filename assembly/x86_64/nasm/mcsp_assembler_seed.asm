; MCSP 0.40 bounded assembler seed
bits 64
default rel
global _start
%define SYS_MMAP 9
%define SYS_WRITE 1
%define SYS_EXIT 60
%define PROT_RWX 7
%define MAP_PRIVATE_ANON 0x22
section .rodata
; structural tuple: relation,width,dst-reg,src-reg,form
spec dq 1,64,0,3,1
bad_spec dq 1,32,0,3,1
expected db 0x48,0x31,0xd8
pass db "MCSP assembler seed 0.40: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP assembler seed 0.40: FAIL",10
flen equ $-failmsg
section .text
; assemble(rdi=spec,rsi=out) -> eax length or 0 unsupported
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
.no:
 xor eax,eax
 ret
_start:
 ; allocate executable realization buffer
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
 ; positive structural assembly
 lea rdi,[spec]
 mov rsi,r12
 call assemble
 cmp eax,3
 jne fail
 mov byte [r12+3],0xc3 ; harness RET boundary
 ; emitted bytes must equal expected realization
 lea r13,[expected]
 xor ecx,ecx
.check:
 mov dl,[r12+rcx]
 cmp dl,[r13+rcx]
 jne fail
 inc ecx
 cmp ecx,3
 jne .check
 ; unsupported mutation must reject
 lea rdi,[bad_spec]
 lea rsi,[r12+16]
 call assemble
 test eax,eax
 jnz fail
 ; execute bytes emitted by assembler seed
 mov rax,0x55aa55aa55aa55aa
 mov rbx,0x0f0ff0f00f0ff0f0
 mov r14,rbx
 call r12
 mov rcx,0x5aa5a55a5aa5a55a
 cmp rax,rcx
 jne fail
 cmp rbx,r14
 jne fail
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
