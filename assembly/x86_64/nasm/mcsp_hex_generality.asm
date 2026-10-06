; MCSP 0.44 hex possibility + two-operation generality witness
bits 64
default rel
global _start
%define SYS_MMAP 9
%define SYS_WRITE 1
%define SYS_EXIT 60
%define PROT_RWX 7
%define MAP_PRIVATE_ANON 0x22
section .rodata
spec_x dq 1,64,0,3,1
spec_o dq 2,64,0,3,1
sem_x dq 64,1,1, 0,0,0, 0,1,1, 1,0,1, 1,1,0
sem_o dq 64,1,1, 0,0,0, 0,1,1, 1,0,1, 1,1,1
pass db "MCSP hex/generalization 0.44: CONDITIONAL PASS",10
plen equ $-pass
failmsg db "MCSP hex/generalization 0.44: FAIL",10
flen equ $-failmsg
section .bss
decoded resq 5
recon resq 15
hexview resb 6
section .text
; compose one byte from high/low nibbles: al=high, dl=low -> al byte, CF reject
compose:
 cmp al,15
 ja .bad
 cmp dl,15
 ja .bad
 shl al,4
 or al,dl
 clc
 ret
.bad: stc
 ret
; split byte al -> ah=high nibble, al=low nibble
split:
 mov ah,al
 shr ah,4
 and al,0x0f
 ret
; assemble tuple to bytes using nibble composition
assemble:
 ; common tuple checks
 cmp qword [rdi+8],64
 jne .no
 cmp qword [rdi+16],0
 jne .no
 cmp qword [rdi+24],3
 jne .no
 cmp qword [rdi+32],1
 jne .no
 mov r8,[rdi]
 ; 0x48
 mov al,4
 mov dl,8
 call compose
 jc .no
 mov [rsi],al
 ; operation byte: relation 1 -> 0x31, relation 2 -> 0x09
 cmp r8,1
 je .rel1
 cmp r8,2
 je .rel2
 jmp .no
.rel1:
 mov al,3
 mov dl,1
 jmp .op
.rel2:
 xor eax,eax
 mov dl,9
.op:
 call compose
 jc .no
 mov [rsi+1],al
 ; 0xd8
 mov al,13
 mov dl,8
 call compose
 jc .no
 mov [rsi+2],al
 mov eax,3
 ret
.no: xor eax,eax
 ret
; disassemble bytes -> tuple and six raw nibbles
; rdi bytes, rsi tuple, rdx hexview
disassemble:
 mov al,[rdi]
 call split
 mov [rdx],ah
 mov [rdx+1],al
 cmp byte [rdx],4
 jne .no
 cmp byte [rdx+1],8
 jne .no
 mov al,[rdi+1]
 call split
 mov [rdx+2],ah
 mov [rdx+3],al
 mov al,[rdi+2]
 call split
 mov [rdx+4],ah
 mov [rdx+5],al
 cmp byte [rdx+4],13
 jne .no
 cmp byte [rdx+5],8
 jne .no
 mov qword [rsi+8],64
 mov qword [rsi+16],0
 mov qword [rsi+24],3
 mov qword [rsi+32],1
 cmp byte [rdx+2],3
 jne .try2
 cmp byte [rdx+3],1
 jne .no
 mov qword [rsi],1
 mov eax,3
 ret
.try2:
 cmp byte [rdx+2],0
 jne .no
 cmp byte [rdx+3],9
 jne .no
 mov qword [rsi],2
 mov eax,3
 ret
.no: xor eax,eax
 ret
decompile:
 cmp qword [rdi+8],64
 jne .no
 cmp qword [rdi+16],0
 jne .no
 cmp qword [rdi+24],3
 jne .no
 cmp qword [rdi+32],1
 jne .no
 mov qword [rsi],64
 mov qword [rsi+8],1
 mov qword [rsi+16],1
 mov qword [rsi+24],0
 mov qword [rsi+32],0
 mov qword [rsi+40],0
 mov qword [rsi+48],0
 mov qword [rsi+56],1
 mov qword [rsi+64],1
 mov qword [rsi+72],1
 mov qword [rsi+80],0
 mov qword [rsi+88],1
 mov qword [rsi+96],1
 mov qword [rsi+104],1
 mov qword [rsi+112],0
 cmp qword [rdi],1
 je .yes
 cmp qword [rdi],2
 jne .no
 mov qword [rsi+112],1
.yes:
 mov eax,15
 ret
.no: xor eax,eax
 ret
; run one tuple/semantic pair: rdi spec, rsi semantic, rdx buffer
run_case:
 push rbx
 push r12
 push r13
 push r14
 mov r12,rdi
 mov r13,rsi
 mov r14,rdx
 mov rdi,r12
 mov rsi,r14
 call assemble
 cmp eax,3
 jne .bad
 mov byte [r14+3],0xc3
 ; execute with discriminating all-ones input: XOR->0, OR->all ones
 mov rax,-1
 mov rbx,-1
 call r14
 cmp qword [r12],1
 jne .orcheck
 test rax,rax
 jne .bad
 jmp .decode
.orcheck:
 cmp rax,-1
 jne .bad
.decode:
 mov rdi,r14
 lea rsi,[decoded]
 lea rdx,[hexview]
 call disassemble
 cmp eax,3
 jne .bad
 ; tuple equality
 lea rdi,[decoded]
 mov rsi,r12
 mov ecx,5
.tc:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne .bad
 add rdi,8
 add rsi,8
 dec ecx
 jnz .tc
 ; decompile and semantic equality
 lea rdi,[decoded]
 lea rsi,[recon]
 call decompile
 cmp eax,15
 jne .bad
 lea rdi,[recon]
 mov rsi,r13
 mov ecx,15
.sc:
 mov rax,[rdi]
 cmp rax,[rsi]
 jne .bad
 add rdi,8
 add rsi,8
 dec ecx
 jnz .sc
 mov eax,1
 jmp .done
.bad: xor eax,eax
.done:
 pop r14
 pop r13
 pop r12
 pop rbx
 ret
_start:
 ; exhaustive single-nibble compose/split identity 0..15
 xor r8d,r8d
.hexloop:
 mov al,r8b
 xor edx,edx
 call compose
 jc fail
 call split
 cmp ah,r8b
 jne fail
 test al,al
 jne fail
 inc r8d
 cmp r8d,16
 jne .hexloop
 ; executable page
 xor edi,edi
 mov esi,4096
 mov edx,PROT_RWX
 mov r10d,MAP_PRIVATE_ANON
 mov r8,-1
 xor r9d,r9d
 mov eax,SYS_MMAP
 syscall
 test rax,rax
 js fail
 mov r15,rax
 lea rdi,[spec_x]
 lea rsi,[sem_x]
 mov rdx,r15
 call run_case
 test eax,eax
 jz fail
 lea rdi,[spec_o]
 lea rsi,[sem_o]
 lea rdx,[r15+16]
 call run_case
 test eax,eax
 jz fail
 ; semantic cross-identification must fail: relations differ at final row
 mov rax,[sem_x+112]
 cmp rax,[sem_o+112]
 je fail
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
