; MCSP 0.45 terminal release capability condition
; This witness MUST remain foreground-attached and MUST NOT detach.
bits 64
default rel
global _start
%define SYS_WRITE 1
%define SYS_EXIT 60
; Linux x86-64 realization knowledge retained as capability inputs only.
; These syscall identities are NOT invoked by this fixture:
%define CAP_FORK 57
%define CAP_SETSID 112
%define CAP_CLOSE 3
%define CAP_DUP2 33
section .rodata
pass db "MCSP terminal capability 0.45: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP terminal capability 0.45: FAIL",10
flen equ $-failmsg
section .data
; condition record, not state:
; attached, release_capable, release_invoked, background_operating
condition dq 1,0,0,0
; realization capability evidence
mechanisms dq CAP_FORK,CAP_SETSID,CAP_CLOSE,CAP_DUP2
section .text
calculate_capability:
 ; Bounded Linux realization: require all declared mechanism identities
 ; to be present/nonzero. Do not invoke any of them.
 mov rax,[mechanisms]
 test rax,rax
 jz .no
 mov rax,[mechanisms+8]
 test rax,rax
 jz .no
 mov rax,[mechanisms+16]
 test rax,rax
 jz .no
 mov rax,[mechanisms+24]
 test rax,rax
 jz .no
 mov qword [condition+8],1
 mov eax,1
 ret
.no:
 xor eax,eax
 ret
_start:
 call calculate_capability
 test eax,eax
 jz fail
 ; Must remain attached by declared current condition.
 cmp qword [condition],1
 jne fail
 ; Capability must have been determined.
 cmp qword [condition+8],1
 jne fail
 ; Critical negative assertions: no transition was invoked.
 cmp qword [condition+16],0
 jne fail
 cmp qword [condition+24],0
 jne fail
 ; Since no fork/setsid/close/dup2 path exists in executable code,
 ; successful write to inherited stdout also evidences continued attachment.
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
