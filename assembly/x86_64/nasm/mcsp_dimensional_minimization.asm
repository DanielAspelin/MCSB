; MCSP 0.47 semantic dimensional minimization witness
; CONDITION before STATE; MODE before TYPE.
bits 64
default rel
global _start
%define SYS_WRITE 1
%define SYS_EXIT 60

%define COND_PROCESSING 1
%define MODE_FOREGROUND 1
%define MODE_BACKGROUND 2

section .rodata
pass db "MCSP dimensional minimization 0.47: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP dimensional minimization 0.47: FAIL",10
flen equ $-failmsg

section .data
; record:
; condition, mode, state_introduced, type_introduced,
; condition_sufficient, mode_sufficient
record dq COND_PROCESSING, MODE_FOREGROUND, 0, 0, 1, 1

section .text
process_record:
    ; Required condition must be determinate.
    cmp qword [record+0],COND_PROCESSING
    jne .fail

    ; Operational distinction is expressed as MODE.
    mov rax,[record+8]
    cmp rax,MODE_FOREGROUND
    je .mode_ok
    cmp rax,MODE_BACKGROUND
    jne .fail
.mode_ok:

    ; The bounded fixture declares weaker dimensions sufficient.
    cmp qword [record+32],1
    jne .fail
    cmp qword [record+40],1
    jne .fail

    ; No automatic semantic promotion is permitted.
    cmp qword [record+16],0
    jne .fail
    cmp qword [record+24],0
    jne .fail

    mov eax,1
    ret
.fail:
    xor eax,eax
    ret

_start:
    call process_record
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
