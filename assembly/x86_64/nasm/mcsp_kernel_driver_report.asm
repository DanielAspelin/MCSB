; MCSP 0.55 kernel driver-builder report witness
bits 64
default rel
global _start

%define SYS_EXIT 60
%define SCHEMA 55
%define REL_EXCLUSIVE 1
%define WIDTH64 64
%define ROLE_SOURCE 1
%define ROLE_DESTINATION 2
%define PRESERVE 1
%define REPLACE 1
%define HW_X86_64 1
%define MODE_CALLABLE 1
%define MODE_REGISTER 1
%define MODE_INTERRUPT_NONE 0
%define KERNEL_LINUX 1
%define QUALIFIED 1
%define REALIZE 5
%define SUSPEND 6
%define REJECT 7

section .data
; schema, relation, width, source-role, destination-role, preservation,
; replacement, hardware, access-mode, transfer-mode, interrupt-mode,
; kernel-projection, qualification, residue, lineage
report dq SCHEMA,REL_EXCLUSIVE,WIDTH64,ROLE_SOURCE,ROLE_DESTINATION,PRESERVE,REPLACE
       dq HW_X86_64,MODE_CALLABLE,MODE_REGISTER,MODE_INTERRUPT_NONE
       dq KERNEL_LINUX,QUALIFIED,0,55
operation dq 0
state_introduced dq 0
type_introduced dq 0
semantic_mutation dq 0

section .text
qualify_report:
    cmp qword [report+0],SCHEMA
    jne .reject
    cmp qword [report+8],REL_EXCLUSIVE
    jne .reject
    cmp qword [report+16],WIDTH64
    jne .reject
    cmp qword [report+40],PRESERVE
    jne .reject
    cmp qword [report+48],REPLACE
    jne .reject

    ; Unknown hardware or external-kernel projection is unresolved, not invented.
    cmp qword [report+56],HW_X86_64
    jne .suspend
    cmp qword [report+88],KERNEL_LINUX
    jne .suspend
    cmp qword [report+96],QUALIFIED
    jne .suspend
    cmp qword [report+104],0
    jne .suspend

    ; Realization dimensions must match the bounded report.
    cmp qword [report+64],MODE_CALLABLE
    jne .reject
    cmp qword [report+72],MODE_REGISTER
    jne .reject
    cmp qword [report+80],MODE_INTERRUPT_NONE
    jne .reject

    ; Semantic minimization / authority guards.
    cmp qword [state_introduced],0
    jne .reject
    cmp qword [type_introduced],0
    jne .reject
    cmp qword [semantic_mutation],0
    jne .reject

    mov qword [operation],REALIZE
    mov eax,REALIZE
    ret
.suspend:
    mov qword [operation],SUSPEND
    mov eax,SUSPEND
    ret
.reject:
    mov qword [operation],REJECT
    mov eax,REJECT
    ret

_start:
    call qualify_report
    cmp eax,REALIZE
    jne .fail
    mov eax,SYS_EXIT
    xor edi,edi
    syscall
.fail:
    mov eax,SYS_EXIT
    mov edi,1
    syscall
