; MCSP 0.49 condition continuity witness - reconciliation
; No manually entered final lineage constant is semantic authority.
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
; Independent reconstruction accumulator.
audit_lineage dq 0
audit_sequence dq 0

section .text
accept:
    ; rdi=expected prior, rsi=new current, rdx=mode, rcx=sequence
    cmp qword [last_condition],rdi
    jne .fail

    ; Sequence must advance exactly by one.
    mov rax,[record+24]
    inc rax
    cmp rcx,rax
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
    ; Stronger dimensions and release remain absent.
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

    ; Primary continuity calculation.
    mov rax,[record+32]
    imul rax,rax,5
    add rax,rsi
    add rax,rdx
    add rax,rcx
    mov [record+32],rax

    ; Independent reconstruction using a separate accumulator.
    mov r8,[audit_lineage]
    lea r8,[r8+r8*4]
    add r8,rsi
    add r8,rdx
    add r8,rcx
    mov [audit_lineage],r8

    ; Compare, rather than trusting a manually supplied terminal constant.
    cmp rax,r8
    jne .fail

    mov rax,[audit_sequence]
    inc rax
    cmp rax,rcx
    jne .fail
    mov [audit_sequence],rax

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

    ; Equal consecutive condition, but a new qualified observation.
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
    cmp qword [audit_sequence],4
    jne fail
    cmp qword [last_condition],COND_IDLE
    jne fail
    mov rax,[record+32]
    cmp rax,[audit_lineage]
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
