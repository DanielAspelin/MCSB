; MCSP 0.58 QEMU EDU read-only MMIO observation predicate
; Input: RDI = zero-extended 32-bit BAR0 identification register.
; Output: RAX = 1 when the stable QEMU EDU suffix is 0x00ed, otherwise 0.
; Version fields RR/rr are deliberately not pre-settled by MCSP.

bits 64
default rel

section .text
global mcsp_edu_observation_match

mcsp_edu_observation_match:
    mov eax, edi
    and eax, 0x0000ffff
    cmp eax, 0x000000ed
    sete al
    movzx eax, al
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
