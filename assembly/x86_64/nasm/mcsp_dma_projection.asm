; MCSP x86-64 / NASM DMA-style projection validator 0.34
; Validates a non-CPU transfer contract; does not claim physical DMA execution.
bits 64
default rel
global _start
%define COMPLETE 1
%define NO_FAILURE 0
%define NO_FORBIDDEN 0
%define FIELDS 8

section .rodata
; source,destination,extent,payload,provenance,completion,failure,forbidden
preset: dq 0x501,0x601,64,0xA55A,0x701,COMPLETE,NO_FAILURE,NO_FORBIDDEN
dma_ok: dq 0x501,0x601,64,0xA55A,0x701,COMPLETE,NO_FAILURE,NO_FORBIDDEN
dma_wrong_provenance: dq 0x501,0x601,64,0xA55A,0xBAD,COMPLETE,NO_FAILURE,NO_FORBIDDEN
dma_wrong_extent: dq 0x501,0x601,32,0xA55A,0x701,COMPLETE,NO_FAILURE,NO_FORBIDDEN
dma_failure: dq 0x501,0x601,64,0xA55A,0x701,COMPLETE,1,NO_FORBIDDEN
dma_forbidden: dq 0x501,0x601,64,0xA55A,0x701,COMPLETE,NO_FAILURE,1
msg_pass: db "MCSP DMA projection 0.34: CONDITIONAL PASS",10
msg_pass_len equ $-msg_pass
msg_fail: db "MCSP DMA projection 0.34: FAIL",10
msg_fail_len equ $-msg_fail

section .text
; preserve(rdi=preset,rsi=projection) -> 1/0
preserve:
    xor rcx,rcx
.loop:
    cmp rcx,FIELDS
    je .yes
    mov rax,[rdi+rcx*8]
    cmp rax,[rsi+rcx*8]
    jne .no
    inc rcx
    jmp .loop
.yes:
    mov eax,1
    ret
.no:
    xor eax,eax
    ret

_start:
    lea rdi,[preset]
    lea rsi,[dma_ok]
    call preserve
    test rax,rax
    jz .fail

    ; Same payload but wrong material provenance must fail.
    lea rdi,[preset]
    lea rsi,[dma_wrong_provenance]
    call preserve
    test rax,rax
    jnz .fail

    lea rdi,[preset]
    lea rsi,[dma_wrong_extent]
    call preserve
    test rax,rax
    jnz .fail

    lea rdi,[preset]
    lea rsi,[dma_failure]
    call preserve
    test rax,rax
    jnz .fail

    lea rdi,[preset]
    lea rsi,[dma_forbidden]
    call preserve
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
