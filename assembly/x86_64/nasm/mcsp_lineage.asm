; MCSP x86-64 / NASM deterministic lineage projection 0.31
; Independent implementation of LINEAGE-NORMAL-FORM-0.31.
bits 64
default rel
global _start
%define OPEN 1
%define PRESET 2
%define REALIZATION_DEFINED 3
%define Q_CONDITIONAL 1
%define Q_VERIFIED 2
%define EVENT_NONE 0
%define EVENT_SETTLE 1
%define EVENT_NARROW 2
%define TUPLE_FIELDS 8
%define TUPLE_COUNT 5
section .rodata
tuples:
dq 0xA11,0x100,0x101,0xF0,OPEN,Q_CONDITIONAL,1,EVENT_NONE
dq 0xA11,0x100,0x102,0xF0,OPEN,Q_VERIFIED,1,EVENT_NONE
dq 0xA11,0x100,0x103,0xF0,PRESET,Q_CONDITIONAL,1,EVENT_SETTLE
dq 0xA11,0x100,0x104,0x30,OPEN,Q_CONDITIONAL,1,EVENT_NARROW
dq 0xA11,0x100,0x105,0xF0,REALIZATION_DEFINED,Q_CONDITIONAL,1,EVENT_NONE
expected: dq 0x0f646d0bb5be8531
msg_pass: db "MCSP NASM lineage 0.31: CONDITIONAL PASS",10
msg_pass_len equ $-msg_pass
msg_fail: db "MCSP NASM lineage 0.31: FAIL",10
msg_fail_len equ $-msg_fail
section .text
_start:
    lea rsi,[tuples]
    mov rax,1469598103934665603
    mov rcx,TUPLE_FIELDS*TUPLE_COUNT
    mov r8,1099511628211
.fold:
    xor rax,[rsi]
    imul rax,r8
    add rsi,8
    dec rcx
    jnz .fold
    cmp rax,[expected]
    jne .fail
.pass:
    mov eax,1
    mov edi,1
    lea rsi,[msg_pass]
    mov edx,msg_pass_len
    syscall
    xor edi,edi
    mov eax,60
    syscall
.fail:
    mov eax,1
    mov edi,2
    lea rsi,[msg_fail]
    mov edx,msg_fail_len
    syscall
    mov edi,1
    mov eax,60
    syscall
