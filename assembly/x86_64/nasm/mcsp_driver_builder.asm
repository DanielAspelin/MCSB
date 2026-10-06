; MCSP 0.52 driver builder interface witness
bits 64
default rel
global _start

%define SYS_WRITE 1
%define SYS_EXIT 60

%define REL_EXCLUSIVE 1
%define WIDTH64 64
%define DST0 0
%define SRC3 3
%define FORM1 1
%define HW_X86_64 1
%define QUALIFIED 1
%define OP_REALIZE 5
%define OP_SUSPEND 6
%define OP_REJECT 7

section .rodata
pass db "MCSP driver builder interface 0.52: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP driver builder interface 0.52: FAIL",10
flen equ $-failmsg

section .data
; report: relation,width,dst,src,form,hardware,qualification,residue
report dq REL_EXCLUSIVE,WIDTH64,DST0,SRC3,FORM1,HW_X86_64,QUALIFIED,0
encoded db 0,0,0
decoded dq 0,0,0,0,0
; semantic reconstruction: width, source-preserved, destination-replaced,
; then truth triples 000,011,101,110
semantic dq 0,0,0, 0,0,0, 0,1,1, 1,0,1, 1,1,0
operation dq 0
state_introduced dq 0
type_introduced dq 0

section .text
assemble_report:
    cmp qword [report+0],REL_EXCLUSIVE
    jne .reject
    cmp qword [report+8],WIDTH64
    jne .reject
    cmp qword [report+16],DST0
    jne .reject
    cmp qword [report+24],SRC3
    jne .reject
    cmp qword [report+32],FORM1
    jne .reject
    cmp qword [report+40],HW_X86_64
    jne .suspend
    cmp qword [report+48],QUALIFIED
    jne .suspend
    cmp qword [report+56],0
    jne .suspend
    mov byte [encoded],0x48
    mov byte [encoded+1],0x31
    mov byte [encoded+2],0xd8
    mov eax,1
    ret
.suspend:
    mov qword [operation],OP_SUSPEND
    mov eax,2
    ret
.reject:
    mov qword [operation],OP_REJECT
    xor eax,eax
    ret

disassemble_encoding:
    cmp byte [encoded],0x48
    jne .reject
    cmp byte [encoded+1],0x31
    jne .reject
    cmp byte [encoded+2],0xd8
    jne .reject
    mov qword [decoded+0],REL_EXCLUSIVE
    mov qword [decoded+8],WIDTH64
    mov qword [decoded+16],DST0
    mov qword [decoded+24],SRC3
    mov qword [decoded+32],FORM1
    mov eax,1
    ret
.reject:
    mov qword [operation],OP_REJECT
    xor eax,eax
    ret

decompile_tuple:
    cmp qword [decoded+0],REL_EXCLUSIVE
    jne .reject
    cmp qword [decoded+8],WIDTH64
    jne .reject
    mov qword [semantic+0],WIDTH64
    mov qword [semantic+8],1
    mov qword [semantic+16],1
    mov eax,1
    ret
.reject:
    mov qword [operation],OP_REJECT
    xor eax,eax
    ret

verify_report:
    ; structural round-trip
    mov rsi,report
    mov rdi,decoded
    mov ecx,5
.loop:
    mov rax,[rsi]
    cmp rax,[rdi]
    jne .reject
    add rsi,8
    add rdi,8
    loop .loop

    ; semantic obligation
    cmp qword [semantic+0],WIDTH64
    jne .reject
    cmp qword [semantic+8],1
    jne .reject
    cmp qword [semantic+16],1
    jne .reject
    ; truth triples: 000,011,101,110 already represented in data
    cmp qword [semantic+40],0
    jne .reject
    cmp qword [semantic+48],0
    jne .reject
    cmp qword [semantic+56],0
    jne .reject
    cmp qword [semantic+64],0
    jne .reject
    cmp qword [semantic+72],1
    jne .reject
    cmp qword [semantic+80],1
    jne .reject
    cmp qword [semantic+88],1
    jne .reject
    cmp qword [semantic+96],0
    jne .reject
    cmp qword [semantic+104],1
    jne .reject
    cmp qword [semantic+112],1
    jne .reject
    cmp qword [semantic+120],1
    jne .reject
    cmp qword [semantic+128],0
    jne .reject

    cmp qword [state_introduced],0
    jne .reject
    cmp qword [type_introduced],0
    jne .reject
    mov qword [operation],OP_REALIZE
    mov eax,1
    ret
.reject:
    mov qword [operation],OP_REJECT
    xor eax,eax
    ret

_start:
    call assemble_report
    cmp eax,1
    jne fail
    call disassemble_encoding
    cmp eax,1
    jne fail
    call decompile_tuple
    cmp eax,1
    jne fail
    call verify_report
    cmp eax,1
    jne fail
    cmp qword [operation],OP_REALIZE
    jne fail

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
