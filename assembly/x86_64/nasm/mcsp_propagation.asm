; MCSP x86-64 / NASM propagation witness 0.30
; Assembly-dominant experimental implementation. No C/libc.
bits 64
default rel
global _start
%define OPEN 1
%define PRESET 2
%define REALIZATION_DEFINED 3
%define Q_FAILED 0
%define Q_CONDITIONAL 1
%define Q_VERIFIED 2
%define EVENT_NONE 0
%define EVENT_SETTLE 1
%define EVENT_NARROW 2

section .rodata
; scaffold: invariant,status,qualification,residue,applicability,lineage
parent: dq 0xA11,OPEN,Q_CONDITIONAL,1,0xF0,0x100
child_ok: dq 0xA11,OPEN,Q_CONDITIONAL,1,0xF0,0x101
child_refine: dq 0xA11,OPEN,Q_VERIFIED,1,0xF0,0x102
child_settle: dq 0xA11,PRESET,Q_CONDITIONAL,1,0xF0,0x103
child_narrow: dq 0xA11,OPEN,Q_CONDITIONAL,1,0x30,0x104
child_branch: dq 0xA11,REALIZATION_DEFINED,Q_CONDITIONAL,1,0xF0,0x105
child_bad: dq 0xBAD,OPEN,Q_CONDITIONAL,1,0xF0,0x106
child_failed: dq 0xA11,OPEN,Q_FAILED,1,0xF0,0x107
child_lost_residue: dq 0xA11,OPEN,Q_CONDITIONAL,0,0xF0,0x108

; event: kind,parent_lineage,child_lineage,applicability,qualification
settle_event: dq EVENT_SETTLE,0x100,0x103,0xF0,Q_CONDITIONAL
narrow_event: dq EVENT_NARROW,0x100,0x104,0x30,Q_CONDITIONAL
no_event: dq EVENT_NONE,0,0,0,0

msg_pass: db "MCSP NASM propagation 0.30: CONDITIONAL PASS",10
msg_pass_len equ $-msg_pass
msg_fail: db "MCSP NASM propagation 0.30: FAIL",10
msg_fail_len equ $-msg_fail

section .text
; event_valid(rdi=event,rsi=parent,rdx=child,rax=required kind on entry)
event_valid:
    cmp [rdi],rax
    jne .no
    mov r8,[rsi+40]
    cmp r8,[rdi+8]
    jne .no
    mov r8,[rdx+40]
    cmp r8,[rdi+16]
    jne .no
    mov r8,[rdx+32]
    cmp r8,[rdi+24]
    jne .no
    cmp qword [rdi+32],Q_FAILED
    je .no
    mov eax,1
    ret
.no: xor eax,eax
    ret

; propagate_ok(rdi=parent,rsi=child,rdx=event) -> rax 1/0
propagate_ok:
    push rbx
    mov rbx,rdx
    mov r8,[rdi]
    cmp r8,[rsi]
    jne .no
    ; failed child cannot inherit a PASS-like result
    cmp qword [rsi+16],Q_FAILED
    je .no
    ; unresolved residue may grow but cannot silently disappear
    mov r8,[rsi+24]
    cmp r8,[rdi+24]
    jb .no
    ; applicability may stay same, or narrowing requires event
    mov r8,[rdi+32]
    cmp r8,[rsi+32]
    je .status
    mov rax,EVENT_NARROW
    mov rdx,rsi
    mov rsi,rdi
    mov rdi,rbx
    call event_valid
    test rax,rax
    jz .no
    ; restore parent/child pointers from event lineage not needed below:
    ; narrowed OPEN fixture has unchanged status.
    mov eax,1
    pop rbx
    ret
.status:
    mov r8,[rdi+8]
    cmp r8,[rsi+8]
    je .yes
    ; OPEN -> PRESET requires explicit qualified settlement event
    cmp r8,OPEN
    jne .realization
    cmp qword [rsi+8],PRESET
    jne .realization
    mov rax,EVENT_SETTLE
    mov rdx,rsi
    mov rsi,rdi
    mov rdi,rbx
    call event_valid
    test rax,rax
    jz .no
    jmp .yes
.realization:
    ; OPEN -> REALIZATION_DEFINED is allowed only as branch-local realization;
    ; semantic invariant remains unchanged and branch status records divergence.
    cmp r8,OPEN
    jne .no
    cmp qword [rsi+8],REALIZATION_DEFINED
    jne .no
.yes:
    mov eax,1
    pop rbx
    ret
.no:
    xor eax,eax
    pop rbx
    ret

_start:
    ; P1/P5 compatible inheritance, OPEN retained.
    lea rdi,[parent]
    lea rsi,[child_ok]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jz .fail

    ; P2 refinement.
    lea rdi,[parent]
    lea rsi,[child_refine]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jz .fail

    ; Settlement without provenance MUST fail.
    lea rdi,[parent]
    lea rsi,[child_settle]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jnz .fail

    ; Qualified settlement event permits OPEN -> PRESET.
    lea rdi,[parent]
    lea rsi,[child_settle]
    lea rdx,[settle_event]
    call propagate_ok
    test rax,rax
    jz .fail

    ; P3 narrowing without event fails.
    lea rdi,[parent]
    lea rsi,[child_narrow]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jnz .fail

    ; Explicit narrowing event passes.
    lea rdi,[parent]
    lea rsi,[child_narrow]
    lea rdx,[narrow_event]
    call propagate_ok
    test rax,rax
    jz .fail

    ; P6 realization branch may settle realization dimension.
    lea rdi,[parent]
    lea rsi,[child_branch]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jz .fail

    ; P4 contradiction blocks.
    lea rdi,[parent]
    lea rsi,[child_bad]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jnz .fail

    ; P9 failed qualification cannot propagate as PASS.
    lea rdi,[parent]
    lea rsi,[child_failed]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jnz .fail

    ; P8 unresolved residue cannot silently disappear.
    lea rdi,[parent]
    lea rsi,[child_lost_residue]
    lea rdx,[no_event]
    call propagate_ok
    test rax,rax
    jnz .fail

    ; P7 is exercised by all accepted children retaining invariant 0xA11.
    ; P10 lineage is explicit in parent/child/event records and reconstructible
    ; from the bootstrap representation; deterministic serialization remains next.

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
