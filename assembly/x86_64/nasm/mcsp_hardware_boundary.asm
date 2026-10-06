; MCSP 0.51 hardware boundary reconciliation
bits 64
default rel
global _start

%define SYS_WRITE 1
%define SYS_EXIT 60

%define REL_EXCLUSIVE 1
%define WIDTH_64 64
%define HW_X86_64 1
%define HW_AARCH64 2
%define HW_RISCV64 3
%define HW_UNKNOWN 255
%define OP_REALIZE 5
%define OP_SUSPEND 6
%define OP_REJECT 7

section .rodata
pass db "MCSP hardware boundary 0.51: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP hardware boundary 0.51: FAIL",10
flen equ $-failmsg

section .data
; relation,width,hardware,operation,lineage,state,type,semantic_mutation,release
record dq REL_EXCLUSIVE,WIDTH_64,HW_X86_64,0,1,0,0,0,0

section .text
guard_semantics:
    cmp qword [record+0],REL_EXCLUSIVE
    jne .fail
    cmp qword [record+8],WIDTH_64
    jne .fail
    cmp qword [record+40],0
    jne .fail
    cmp qword [record+48],0
    jne .fail
    cmp qword [record+56],0
    jne .fail
    cmp qword [record+64],0
    jne .fail
    mov eax,1
    ret
.fail:
    xor eax,eax
    ret

advance:
    ; bounded lineage: prior*11 + operation + hardware + relation + width
    mov rax,[record+32]
    imul rax,rax,11
    add rax,[record+24]
    add rax,[record+16]
    add rax,[record+0]
    add rax,[record+8]
    mov [record+32],rax
    ret

realize:
    call guard_semantics
    test eax,eax
    jz .fail
    mov rax,[record+16]
    cmp rax,HW_X86_64
    je .supported
    cmp rax,HW_AARCH64
    je .supported
    cmp rax,HW_RISCV64
    je .supported
    ; unknown compatibility is contained, not guessed
    mov qword [record+24],OP_SUSPEND
    call advance
    mov eax,2
    ret
.supported:
    mov qword [record+24],OP_REALIZE
    call advance
    mov eax,1
    ret
.fail:
    mov qword [record+24],OP_REJECT
    xor eax,eax
    ret

_start:
    ; x86-64 witness class
    mov qword [record+16],HW_X86_64
    call realize
    cmp eax,1
    jne fail
    cmp qword [record+24],OP_REALIZE
    jne fail

    ; AArch64 witness class: same semantics, different hardware identity
    mov qword [record+16],HW_AARCH64
    call realize
    cmp eax,1
    jne fail

    ; RISC-V witness class
    mov qword [record+16],HW_RISCV64
    call realize
    cmp eax,1
    jne fail

    ; unresolved hardware must suspend
    mov qword [record+16],HW_UNKNOWN
    call realize
    cmp eax,2
    jne fail
    cmp qword [record+24],OP_SUSPEND
    jne fail

    ; semantic obligation remains unchanged across boundary processing
    cmp qword [record+0],REL_EXCLUSIVE
    jne fail
    cmp qword [record+8],WIDTH_64
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
