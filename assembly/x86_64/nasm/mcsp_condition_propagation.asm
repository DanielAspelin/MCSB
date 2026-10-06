; MCSP 0.50 condition propagation witness
bits 64
default rel
global _start

%define SYS_WRITE 1
%define SYS_EXIT 60

%define COND_IDLE 1
%define COND_PROCESSING 2
%define MODE_FOREGROUND 1
%define MODE_BACKGROUND 2
%define APP_GENERAL 1
%define APP_TERMINAL 2
%define QUALIFIED 1

%define OP_INHERIT 1
%define OP_REFINE 2
%define OP_NARROW 3
%define OP_PROJECT 4
%define OP_SUSPEND 6
%define OP_REJECT 7

section .rodata
pass db "MCSP condition propagation 0.50: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP condition propagation 0.50: FAIL",10
flen equ $-failmsg

section .data
; condition,mode,applicability,qualification,lineage,operation,state,type,release
record dq COND_PROCESSING,MODE_FOREGROUND,APP_GENERAL,QUALIFIED,1,0,0,0,0

section .text
guard:
    cmp qword [record+24],QUALIFIED
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

advance_lineage:
    ; lineage = lineage*7 + operation + condition + mode + applicability
    mov rax,[record+32]
    imul rax,rax,7
    add rax,[record+40]
    add rax,[record+0]
    add rax,[record+8]
    add rax,[record+16]
    mov [record+32],rax
    ret

inherit:
    call guard
    test eax,eax
    jz .fail
    cmp qword [record+0],COND_PROCESSING
    jne .fail
    mov qword [record+40],OP_INHERIT
    call advance_lineage
    mov eax,1
    ret
.fail: xor eax,eax
    ret

refine:
    call guard
    test eax,eax
    jz .fail
    cmp qword [record+0],COND_PROCESSING
    jne .fail
    mov qword [record+40],OP_REFINE
    call advance_lineage
    mov eax,1
    ret
.fail: xor eax,eax
    ret

narrow:
    call guard
    test eax,eax
    jz .fail
    cmp qword [record+16],APP_GENERAL
    jne .fail
    mov qword [record+16],APP_TERMINAL
    mov qword [record+40],OP_NARROW
    call advance_lineage
    mov eax,1
    ret
.fail: xor eax,eax
    ret

project:
    call guard
    test eax,eax
    jz .fail
    cmp qword [record+0],COND_PROCESSING
    jne .fail
    cmp qword [record+16],APP_TERMINAL
    jne .fail
    mov qword [record+8],MODE_BACKGROUND
    mov qword [record+40],OP_PROJECT
    call advance_lineage
    mov eax,1
    ret
.fail: xor eax,eax
    ret

_start:
    call inherit
    test eax,eax
    jz fail
    call refine
    test eax,eax
    jz fail
    call narrow
    test eax,eax
    jz fail
    call project
    test eax,eax
    jz fail

    cmp qword [record+0],COND_PROCESSING
    jne fail
    cmp qword [record+8],MODE_BACKGROUND
    jne fail
    cmp qword [record+16],APP_TERMINAL
    jne fail
    cmp qword [record+40],OP_PROJECT
    jne fail
    call guard
    test eax,eax
    jz fail

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
