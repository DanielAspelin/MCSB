; MCSP 0.49 condition continuity witness
bits 64
default rel
global _start

%define SYS_WRITE 1
%define SYS_EXIT 60
%define COND_NONE 0
%define COND_IDLE 1
%define COND_PROCESSING 2
%define MODE_FOREGROUND 1
%define MODE_BACKGROUND 2

section .rodata
pass db "MCSP condition continuity 0.49: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP condition continuity 0.49: FAIL",10
flen equ $-failmsg

section .data
; prior,current,mode,sequence,lineage,state,type,release
record dq COND_NONE,COND_NONE,MODE_FOREGROUND,0,0,0,0,0
last_condition dq COND_NONE

section .text
accept:
    ; rdi=expected prior, rsi=new current, rdx=mode, rcx=sequence
    cmp qword [last_condition],rdi
    jne .fail
    cmp rsi,COND_IDLE
    je .condition_ok
    cmp rsi,COND_PROCESSING
    jne .fail
.condition_ok:
    cmp rdx,MODE_FOREGROUND
    je .mode_ok
    cmp rdx,MODE_BACKGROUND
    jne .fail
.mode_ok:
    cmp qword [record+40],0
    jne .fail
    cmp qword [record+48],0
    jne .fail
    cmp qword [record+56],0
    jne .fail

    mov [record+0],rdi
    mov [record+8],rsi
    mov [record+16],rdx
    mov [record+24],rcx

    ; bounded deterministic lineage witness
    mov rax,[record+32]
    imul rax,rax,5
    add rax,rsi
    add rax,rdx
    add rax,rcx
    mov [record+32],rax
    mov [last_condition],rsi
    mov eax,1
    ret
.fail:
    xor eax,eax
    ret

_start:
    mov rdi,COND_NONE
    mov rsi,COND_IDLE
    mov rdx,MODE_FOREGROUND
    mov rcx,1
    call accept
    test eax,eax
    jz fail

    mov rdi,COND_IDLE
    mov rsi,COND_PROCESSING
    mov rdx,MODE_FOREGROUND
    mov rcx,2
    call accept
    test eax,eax
    jz fail

    ; same condition, new calculation and mode
    mov rdi,COND_PROCESSING
    mov rsi,COND_PROCESSING
    mov rdx,MODE_BACKGROUND
    mov rcx,3
    call accept
    test eax,eax
    jz fail

    mov rdi,COND_PROCESSING
    mov rsi,COND_IDLE
    mov rdx,MODE_FOREGROUND
    mov rcx,4
    call accept
    test eax,eax
    jz fail

    cmp qword [record+24],4
    jne fail
    cmp qword [last_condition],COND_IDLE
    jne fail
    ; deterministic expected lineage: 257
    cmp qword [record+32],257
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
