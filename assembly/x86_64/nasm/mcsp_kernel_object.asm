; MCSP 0.54-compatible Linux kernel object projection
bits 64
default rel

section .text
global mcsp_exclusive_u64:function
mcsp_exclusive_u64:
    mov rax,rdi
    xor rax,rsi
    ; Linux x86-64 RETHUNK-compatible return projection.
    jmp __x86_return_thunk
mcsp_exclusive_u64.end:
size mcsp_exclusive_u64 mcsp_exclusive_u64.end-mcsp_exclusive_u64

extern __x86_return_thunk

section .note.GNU-stack noalloc noexec nowrite progbits
