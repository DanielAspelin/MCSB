; MCSP 0.46 terminal release transition contract
; Condition-only witness. No STATE. No RELEASE_READY. No detachment.
bits 64
default rel
global _start

%define SYS_WRITE 1
%define SYS_EXIT 60

section .rodata
pass db "MCSP terminal release contract 0.46: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP terminal release contract 0.46: FAIL",10
flen equ $-failmsg

section .data
; CONDITION RECORD ONLY:
; attached, release_capable, release_determined, release_invoked,
; background_operating, state_introduced
condition dq 1,1,0,0,0,0

section .text
qualify_contract:
    ; Attachment and capability are permitted determinations.
    cmp qword [condition+0],1
    jne .fail
    cmp qword [condition+8],1
    jne .fail

    ; Capability MUST NOT progress automatically.
    cmp qword [condition+16],0
    jne .fail
    cmp qword [condition+24],0
    jne .fail
    cmp qword [condition+32],0
    jne .fail

    ; Explicit negative ontology assertion for this bounded witness.
    cmp qword [condition+40],0
    jne .fail

    mov eax,1
    ret
.fail:
    xor eax,eax
    ret

_start:
    call qualify_contract
    test eax,eax
    jz fail

    ; Successful inherited-terminal output demonstrates occupation is retained.
    mov eax,SYS_WRITE
    mov edi,1
    lea rsi,[pass]
    mov edx,plen
    syscall

    xor edi,edi
    mov eax,SYS_EXIT
    syscall

fail:
    mov eax,SYS_WRITE
    mov edi,2
    lea rsi,[failmsg]
    mov edx,flen
    syscall

    mov edi,1
    mov eax,SYS_EXIT
    syscall
