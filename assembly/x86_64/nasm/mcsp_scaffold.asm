; MCSP x86-64 / NASM structural bootstrap witness 0.28
; Assembly-dominant primary implementation artifact.
; Linux x86-64 syscall ABI is a realization constraint, not MCSP semantics.
;
; This witness tests structural comparison independent of documentary names.
; It intentionally avoids libc and C.

bits 64
default rel
global _start

%define STATUS_OPEN       1
%define STATUS_PRESET     2
%define QUAL_CONDITIONAL  1
%define QUAL_VERIFIED     2

; Bootstrap record layout (representation only):
; qword material_a
; qword material_b
; qword dimension_status
; qword qualification
; qword unresolved_count
%define REC_QWORDS 5
%define REC_BYTES  40

section .rodata
; A and B carry different documentary names but identical structural records.
name_a: db "alpha-scaffold",0
name_b: db "renamed-scaffold",0

record_a:
    dq 0x101, 0x202, STATUS_OPEN, QUAL_CONDITIONAL, 1
record_b:
    dq 0x101, 0x202, STATUS_OPEN, QUAL_CONDITIONAL, 1

; Material change: PRESET rather than OPEN. Must not compare equivalent.
record_material_change:
    dq 0x101, 0x202, STATUS_PRESET, QUAL_CONDITIONAL, 1

; Qualification change. Must not compare equivalent.
record_qualification_change:
    dq 0x101, 0x202, STATUS_OPEN, QUAL_VERIFIED, 1

; Residue change. Must not compare equivalent.
record_residue_change:
    dq 0x101, 0x202, STATUS_OPEN, QUAL_CONDITIONAL, 2

msg_pass: db "MCSP NASM bootstrap: CONDITIONAL PASS",10
msg_pass_len equ $-msg_pass
msg_fail: db "MCSP NASM bootstrap: FAIL",10
msg_fail_len equ $-msg_fail

section .text

; equal_record(rdi, rsi) -> rax=1 equal, 0 different
; Documentary names are deliberately absent from the record.
equal_record:
    xor rcx, rcx
.compare:
    cmp rcx, REC_QWORDS
    je .equal
    mov r8, [rdi + rcx*8]
    cmp r8, [rsi + rcx*8]
    jne .different
    inc rcx
    jmp .compare
.equal:
    mov eax, 1
    ret
.different:
    xor eax, eax
    ret

_start:
    ; N1: renaming invariance represented by equal structures whose labels differ.
    lea rdi, [record_a]
    lea rsi, [record_b]
    call equal_record
    test rax, rax
    jz .fail

    ; N4: OPEN vs PRESET is material.
    lea rdi, [record_a]
    lea rsi, [record_material_change]
    call equal_record
    test rax, rax
    jnz .fail

    ; N5: qualification is material.
    lea rdi, [record_a]
    lea rsi, [record_qualification_change]
    call equal_record
    test rax, rax
    jnz .fail

    ; N6: unresolved residue remains visible/material.
    lea rdi, [record_a]
    lea rsi, [record_residue_change]
    call equal_record
    test rax, rax
    jnz .fail

.pass:
    mov eax, 1
    mov edi, 1
    lea rsi, [msg_pass]
    mov edx, msg_pass_len
    syscall
    xor edi, edi
    mov eax, 60
    syscall

.fail:
    mov eax, 1
    mov edi, 2
    lea rsi, [msg_fail]
    mov edx, msg_fail_len
    syscall
    mov edi, 1
    mov eax, 60
    syscall
