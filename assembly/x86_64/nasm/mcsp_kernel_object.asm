; MCSP 0.53 Linux kernel object projection
bits 64
default rel

section .text
global mcsp_exclusive_u64:function

; Bounded MCSP exclusive-relation projection.
; Input projection: RDI=A, RSI=B
; Output projection: RAX=A exclusive B
mcsp_exclusive_u64:
    mov rax,rdi
    xor rax,rsi
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
