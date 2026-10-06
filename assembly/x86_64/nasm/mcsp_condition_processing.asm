; MCSP 0.48 condition processing assurance
bits 64
default rel
global _start

%define SYS_WRITE 1
%define SYS_EXIT 60

%define COND_IDLE 1
%define COND_PROCESSING 2
%define MODE_FOREGROUND 1
%define MODE_BACKGROUND 2

section .rodata
pass db "MCSP condition processing 0.48: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP condition processing 0.48: FAIL",10
flen equ $-failmsg

section .data
; condition, mode, observation(work), calculation, count,
; state_introduced, type_introduced, release_invoked
record dq 0, MODE_FOREGROUND, 0, 0, 0, 0, 0, 0

section .text
calculate_condition:
    ; observation accepts only bounded work values 0 or 1.
    mov rax,[record+16]
    cmp rax,0
    je .idle
    cmp rax,1
    je .processing
    xor eax,eax
    ret
.idle:
    mov qword [record+24],COND_IDLE
    mov qword [record+0],COND_IDLE
    inc qword [record+32]
    mov eax,1
    ret
.processing:
    mov qword [record+24],COND_PROCESSING
    mov qword [record+0],COND_PROCESSING
    inc qword [record+32]
    mov eax,1
    ret

assure_dimensions:
    cmp qword [record+40],0
    jne .fail
    cmp qword [record+48],0
    jne .fail
    cmp qword [record+56],0
    jne .fail
    mov rax,[record+8]
    cmp rax,MODE_FOREGROUND
    je .ok
    cmp rax,MODE_BACKGROUND
    jne .fail
.ok:
    mov eax,1
    ret
.fail:
    xor eax,eax
    ret

_start:
    ; 1: no work -> IDLE
    mov qword [record+16],0
    call calculate_condition
    test eax,eax
    jz fail
    cmp qword [record+0],COND_IDLE
    jne fail
    call assure_dimensions
    test eax,eax
    jz fail

    ; 2: work present -> PROCESSING
    mov qword [record+16],1
    call calculate_condition
    test eax,eax
    jz fail
    cmp qword [record+0],COND_PROCESSING
    jne fail

    ; Operational mode changes do not create TYPE or release terminal.
    mov qword [record+8],MODE_BACKGROUND
    call assure_dimensions
    test eax,eax
    jz fail
    mov qword [record+8],MODE_FOREGROUND
    call assure_dimensions
    test eax,eax
    jz fail

    ; 3: no work -> IDLE again
    mov qword [record+16],0
    call calculate_condition
    test eax,eax
    jz fail
    cmp qword [record+0],COND_IDLE
    jne fail
    cmp qword [record+32],3
    jne fail
    call assure_dimensions
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
