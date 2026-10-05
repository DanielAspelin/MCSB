; MCSP x86-64 / NASM structural scaffold witness 0.29
; Assembly-dominant experimental implementation. No C/libc dependency.
bits 64
default rel
global _start

%define STATUS_OPEN 1
%define STATUS_PRESET 2
%define QUAL_CONDITIONAL 1
%define QUAL_VERIFIED 2
%define REC_QWORDS 5

section .rodata
record_a: dq 0x101,0x202,STATUS_OPEN,QUAL_CONDITIONAL,1
record_b: dq 0x101,0x202,STATUS_OPEN,QUAL_CONDITIONAL,1
record_material_change: dq 0x101,0x202,STATUS_PRESET,QUAL_CONDITIONAL,1
record_qualification_change: dq 0x101,0x202,STATUS_OPEN,QUAL_VERIFIED,1
record_residue_change: dq 0x101,0x202,STATUS_OPEN,QUAL_CONDITIONAL,2

; Bootstrap graph edges are pairs of structural tokens.
; Unordered graphs may enumerate edges differently.
graph_u1: dq 10,20, 30,40, 50,60
graph_u2: dq 50,60, 10,20, 30,40
; Material sequences use the same elements but order itself is semantic.
seq_m1: dq 10,20,30
seq_m2: dq 20,10,30

; Propagation fixtures: inherited invariant, dimension status, qualification.
parent:       dq 0xA11, STATUS_OPEN, QUAL_CONDITIONAL
child_ok:     dq 0xA11, STATUS_OPEN, QUAL_CONDITIONAL
child_refine: dq 0xA11, STATUS_OPEN, QUAL_VERIFIED
child_settle: dq 0xA11, STATUS_PRESET, QUAL_CONDITIONAL
child_bad:    dq 0xBAD, STATUS_OPEN, QUAL_CONDITIONAL

msg_pass: db "MCSP NASM scaffold 0.29: CONDITIONAL PASS",10
msg_pass_len equ $-msg_pass
msg_fail: db "MCSP NASM scaffold 0.29: FAIL",10
msg_fail_len equ $-msg_fail

section .text

; equal_qwords(rdi,rsi,rdx=count) -> rax 1/0
equal_qwords:
    xor rcx,rcx
.eq_loop:
    cmp rcx,rdx
    je .yes
    mov r8,[rdi+rcx*8]
    cmp r8,[rsi+rcx*8]
    jne .no
    inc rcx
    jmp .eq_loop
.yes: mov eax,1
    ret
.no: xor eax,eax
    ret

; edge_present(rdi=edge, rsi=graph, rdx=edge_count) -> rax 1/0
edge_present:
    xor rcx,rcx
.ep_loop:
    cmp rcx,rdx
    je .ep_no
    mov r8,[rdi]
    mov r9,[rdi+8]
    cmp r8,[rsi+rcx*16]
    jne .ep_next
    cmp r9,[rsi+rcx*16+8]
    je .ep_yes
.ep_next:
    inc rcx
    jmp .ep_loop
.ep_yes: mov eax,1
    ret
.ep_no: xor eax,eax
    ret

; unordered_graph_equal(rdi=g1,rsi=g2,rdx=edge_count)
unordered_graph_equal:
    push rbx
    push r12
    push r13
    mov rbx,rdi
    mov r12,rsi
    mov r13,rdx
    xor r10,r10
.ug_loop:
    cmp r10,r13
    je .ug_yes
    push r10
    lea rdi,[rbx+r10*8]
    ; each edge is 16 bytes, so double index
    lea rdi,[rbx+r10*8]
    add rdi,r10
    add rdi,r10
    add rdi,r10
    add rdi,r10
    add rdi,r10
    add rdi,r10
    add rdi,r10
    add rdi,r10
    ; correction: rdi = base + index*16
    mov rax,r10
    shl rax,4
    lea rdi,[rbx+rax]
    mov rsi,r12
    mov rdx,r13
    call edge_present
    pop r10
    test rax,rax
    jz .ug_no
    inc r10
    jmp .ug_loop
.ug_yes:
    mov eax,1
    pop r13
    pop r12
    pop rbx
    ret
.ug_no:
    xor eax,eax
    pop r13
    pop r12
    pop rbx
    ret

; propagate_ok(parent,child): invariant must survive; OPEN may remain OPEN
; or be explicitly settled; qualification may strengthen but not manufacture
; semantic invariant equality.
propagate_ok:
    mov rax,[rdi]
    cmp rax,[rsi]
    jne .p_no
    mov rax,[rdi+8]
    cmp rax,STATUS_OPEN
    jne .p_same_status
    mov rax,[rsi+8]
    cmp rax,STATUS_OPEN
    je .p_yes
    cmp rax,STATUS_PRESET
    je .p_yes
    jmp .p_no
.p_same_status:
    cmp rax,[rsi+8]
    jne .p_no
.p_yes: mov eax,1
    ret
.p_no: xor eax,eax
    ret

_start:
    lea rdi,[record_a]
    lea rsi,[record_b]
    mov edx,REC_QWORDS
    call equal_qwords
    test rax,rax
    jz .fail

    lea rdi,[record_a]
    lea rsi,[record_material_change]
    mov edx,REC_QWORDS
    call equal_qwords
    test rax,rax
    jnz .fail

    lea rdi,[record_a]
    lea rsi,[record_qualification_change]
    mov edx,REC_QWORDS
    call equal_qwords
    test rax,rax
    jnz .fail

    lea rdi,[record_a]
    lea rsi,[record_residue_change]
    mov edx,REC_QWORDS
    call equal_qwords
    test rax,rax
    jnz .fail

    ; N2: irrelevant edge enumeration order normalizes away.
    lea rdi,[graph_u1]
    lea rsi,[graph_u2]
    mov edx,3
    call unordered_graph_equal
    test rax,rax
    jz .fail

    ; N3: material sequence order remains significant.
    lea rdi,[seq_m1]
    lea rsi,[seq_m2]
    mov edx,3
    call equal_qwords
    test rax,rax
    jnz .fail

    ; P1/P5 compatible inheritance retains OPEN.
    lea rdi,[parent]
    lea rsi,[child_ok]
    call propagate_ok
    test rax,rax
    jz .fail

    ; P2 qualification refinement may propagate same invariant.
    lea rdi,[parent]
    lea rsi,[child_refine]
    call propagate_ok
    test rax,rax
    jz .fail

    ; Explicit settlement of an OPEN dimension is represented, not accidental.
    lea rdi,[parent]
    lea rsi,[child_settle]
    call propagate_ok
    test rax,rax
    jz .fail

    ; P4 contradiction blocks propagation.
    lea rdi,[parent]
    lea rsi,[child_bad]
    call propagate_ok
    test rax,rax
    jnz .fail

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
