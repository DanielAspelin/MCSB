; MCSP 0.56 QEMU EDU report-derived identity predicate
bits 64
default rel
section .text
extern __x86_return_thunk

mcsp_edu_identity_match:
    xor eax,eax
    cmp edi,0x1234
    jne .done
    cmp esi,0x11e8
    jne .done
    mov eax,1
.done:
    jmp __x86_return_thunk
.end:
global mcsp_edu_identity_match:function (.end-mcsp_edu_identity_match)

section .note.GNU-stack noalloc noexec nowrite progbits
