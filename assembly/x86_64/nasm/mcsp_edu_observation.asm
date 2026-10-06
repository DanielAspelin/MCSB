; MCSP 0.59 QEMU EDU observation predicate — Linux x86-64 ABI projection
; Semantic obligation is unchanged from 0.58.
bits 64
default rel
section .text
extern __x86_return_thunk

mcsp_edu_observation_match:
    mov eax, edi
    and eax, 0x0000ffff
    cmp eax, 0x000000ed
    sete al
    movzx eax, al
    jmp __x86_return_thunk
.end:
global mcsp_edu_observation_match:function (.end-mcsp_edu_observation_match)

section .note.GNU-stack noalloc noexec nowrite progbits
