; MCSP 0.54-compatible Linux kernel object projection
bits 64
default rel

section .text
extern __x86_return_thunk

global mcsp_exclusive_u64:function
mcsp_exclusive_u64:
    mov rax,rdi
    xor rax,rsi
    jmp __x86_return_thunk
mcsp_exclusive_u64.end:

; NASM ELF symbol declaration with calculated function size.
global mcsp_exclusive_u64:function (mcsp_exclusive_u64.end-mcsp_exclusive_u64)

section .note.GNU-stack noalloc noexec nowrite progbits
