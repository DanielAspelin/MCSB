; MCSP 0.36 self-scaffolding witness
; Structural roles are data. Documentary labels are not hashed or compared.
bits 64
default rel
global _start

%define ROLE_INVARIANT 1
%define ROLE_APPLICABILITY 2
%define ROLE_DIMENSION 3
%define ROLE_QUALIFICATION 4
%define ROLE_RESIDUE 5
%define ROLE_PARENT 6
%define ROLE_CHILD 7
%define ROLE_EVENT 8
%define OPEN 1
%define PRESET 2
%define Q_FAILED 0
%define Q_CONDITIONAL 1
%define EVENT_NONE 0
%define EVENT_SETTLE 1
%define EVENT_NARROW 2
%define PAIRS 8

section .rodata
; Each record is eight role/value pairs.
parent:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0, ROLE_CHILD,0x100, ROLE_EVENT,EVENT_NONE

child_ok:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x101, ROLE_EVENT,EVENT_NONE
child_bad_invariant:
 dq ROLE_INVARIANT,0xBAD, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x102, ROLE_EVENT,EVENT_NONE
child_lost_residue:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,0, ROLE_PARENT,0x100, ROLE_CHILD,0x103, ROLE_EVENT,EVENT_NONE
child_narrow_bad:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0x30
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x104, ROLE_EVENT,EVENT_NONE
child_narrow_ok:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0x30
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x105, ROLE_EVENT,EVENT_NARROW
child_settle_bad:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,PRESET, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x106, ROLE_EVENT,EVENT_NONE
child_settle_ok:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,PRESET, ROLE_QUALIFICATION,Q_CONDITIONAL
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x107, ROLE_EVENT,EVENT_SETTLE
child_failed:
 dq ROLE_INVARIANT,0xA11, ROLE_APPLICABILITY,0xF0
 dq ROLE_DIMENSION,OPEN, ROLE_QUALIFICATION,Q_FAILED
 dq ROLE_RESIDUE,1, ROLE_PARENT,0x100, ROLE_CHILD,0x108, ROLE_EVENT,EVENT_NONE

msg_pass db "MCSP self-scaffold 0.36: CONDITIONAL PASS",10
msg_pass_len equ $-msg_pass
msg_fail db "MCSP self-scaffold 0.36: FAIL",10
msg_fail_len equ $-msg_fail

section .text
; get(role=rsi, record=rdi) => rax=value, CF=0; CF=1 absent
get:
 xor ecx,ecx
 mov r8,rdi
.g:
 cmp ecx,PAIRS
 je .missing
 mov rax,[r8]
 cmp rax,rsi
 je .found
 add r8,16
 inc ecx
 jmp .g
.found:
 mov rax,[r8+8]
 clc
 ret
.missing:
 stc
 ret

; valid(parent=rdi, child=rdx) => eax 1/0
valid:
 push rbx
 push r12
 mov r12,rdi
 mov rbx,rdx
 ; invariant equal
 mov rsi,ROLE_INVARIANT
 call get
 jc .no
 push rax
 mov rdi,rbx
 call get
 pop rcx
 jc .no
 cmp rax,rcx
 jne .no
 ; qualification not failed
 mov rsi,ROLE_QUALIFICATION
 mov rdi,rbx
 call get
 jc .no
 test rax,rax
 jz .no
 ; residue cannot be lost
 mov rsi,ROLE_RESIDUE
 mov rdi,r12
 call get
 push rax
 mov rdi,rbx
 call get
 pop rcx
 jc .no
 test rcx,rcx
 jz .resok
 test rax,rax
 jz .no
.resok:
 ; child parent must equal parent's child lineage
 mov rsi,ROLE_CHILD
 mov rdi,r12
 call get
 push rax
 mov rsi,ROLE_PARENT
 mov rdi,rbx
 call get
 pop rcx
 jc .no
 cmp rax,rcx
 jne .no
 ; applicability change requires narrow event
 mov rsi,ROLE_APPLICABILITY
 mov rdi,r12
 call get
 push rax
 mov rdi,rbx
 call get
 pop rcx
 jc .no
 cmp rax,rcx
 je .dim
 mov rsi,ROLE_EVENT
 mov rdi,rbx
 call get
 cmp rax,EVENT_NARROW
 jne .no
.dim:
 ; OPEN->PRESET requires settlement event
 mov rsi,ROLE_DIMENSION
 mov rdi,r12
 call get
 cmp rax,OPEN
 jne .yes
 mov rdi,rbx
 call get
 cmp rax,PRESET
 jne .yes
 mov rsi,ROLE_EVENT
 mov rdi,rbx
 call get
 cmp rax,EVENT_SETTLE
 jne .no
.yes:
 mov eax,1
 pop r12
 pop rbx
 ret
.no:
 xor eax,eax
 pop r12
 pop rbx
 ret

_start:
 ; expected pass
 lea rdi,[parent]
 lea rdx,[child_ok]
 call valid
 test eax,eax
 jz fail
 ; expected failures
 lea rdi,[parent]
 lea rdx,[child_bad_invariant]
 call valid
 test eax,eax
 jnz fail
 lea rdi,[parent]
 lea rdx,[child_lost_residue]
 call valid
 test eax,eax
 jnz fail
 lea rdi,[parent]
 lea rdx,[child_narrow_bad]
 call valid
 test eax,eax
 jnz fail
 ; narrowing with event passes
 lea rdi,[parent]
 lea rdx,[child_narrow_ok]
 call valid
 test eax,eax
 jz fail
 ; settlement without event fails
 lea rdi,[parent]
 lea rdx,[child_settle_bad]
 call valid
 test eax,eax
 jnz fail
 ; settlement with event passes
 lea rdi,[parent]
 lea rdx,[child_settle_ok]
 call valid
 test eax,eax
 jz fail
 ; failed qualification cannot propagate
 lea rdi,[parent]
 lea rdx,[child_failed]
 call valid
 test eax,eax
 jnz fail

 mov eax,1
 mov edi,1
 lea rsi,[msg_pass]
 mov edx,msg_pass_len
 syscall
 xor edi,edi
 mov eax,60
 syscall
fail:
 mov eax,1
 mov edi,2
 lea rsi,[msg_fail]
 mov edx,msg_fail_len
 syscall
 mov edi,1
 mov eax,60
 syscall
