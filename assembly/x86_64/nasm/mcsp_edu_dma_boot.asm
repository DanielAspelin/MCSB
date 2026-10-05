; MCSP 0.35 freestanding QEMU EDU DMA witness
; Boot sector -> protected mode -> PCI config -> EDU DMA round trip.
bits 16
org 0x7c00
start:
    cli
    xor ax,ax
    mov ds,ax
    mov ss,ax
    mov sp,0x7c00
    lgdt [gdt_desc]
    mov eax,cr0
    or eax,1
    mov cr0,eax
    jmp 0x08:pm

bits 32
pm:
    mov ax,0x10
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov esp,0x90000

    ; COM1 initialization.
    mov dx,0x3f9
    xor al,al
    out dx,al
    mov dx,0x3fb
    mov al,0x80
    out dx,al
    mov dx,0x3f8
    mov al,1
    out dx,al
    mov dx,0x3f9
    xor al,al
    out dx,al
    mov dx,0x3fb
    mov al,3
    out dx,al

    ; PCI 00:04.0 vendor/device must be 1234:11e8.
    mov dx,0xcf8
    mov eax,0x80002000
    out dx,eax
    mov dx,0xcfc
    in eax,dx
    cmp eax,0x11e81234
    jne fail

    ; BAR0 = 0xe0000000.
    mov dx,0xcf8
    mov eax,0x80002010
    out dx,eax
    mov dx,0xcfc
    mov eax,0xe0000000
    out dx,eax

    ; PCI command: memory space + bus master.
    mov dx,0xcf8
    mov eax,0x80002004
    out dx,eax
    mov dx,0xcfc
    mov eax,0x00000006
    out dx,eax

    ; Known source, zero destination.
    mov edi,0x10000
    mov eax,0x5043534d        ; "MCSP" little endian
    mov [edi],eax
    mov dword [edi+4],0x35334d44 ; "DM35"
    mov dword [0x11000],0
    mov dword [0x11004],0

    ; RAM -> EDU internal buffer 0x40000.
    mov dword [0xe0000080],0x10000
    mov dword [0xe0000084],0
    mov dword [0xe0000088],0x40000
    mov dword [0xe000008c],0
    mov dword [0xe0000090],8
    mov dword [0xe0000098],1
.wait1:
    test dword [0xe0000098],1
    jnz .wait1

    ; EDU internal buffer -> distinct RAM destination.
    mov dword [0xe0000080],0x40000
    mov dword [0xe0000084],0
    mov dword [0xe0000088],0x11000
    mov dword [0xe000008c],0
    mov dword [0xe0000090],8
    mov dword [0xe0000098],3
.wait2:
    test dword [0xe0000098],1
    jnz .wait2

    mov eax,[0x10000]
    cmp eax,[0x11000]
    jne fail
    mov eax,[0x10004]
    cmp eax,[0x11004]
    jne fail
    mov esi,msg_pass
    call puts
    jmp quit_ok

fail:
    mov esi,msg_fail
    call puts
    jmp quit_bad

puts:
    lodsb
    test al,al
    jz .done
    mov dx,0x3f8
    out dx,al
    jmp puts
.done:
    ret

; isa-debug-exit at 0xf4: QEMU exits with (value<<1)|1.
quit_ok:
    mov dx,0xf4
    mov eax,0x10
    out dx,eax
    hlt
quit_bad:
    mov dx,0xf4
    mov eax,0x11
    out dx,eax
    hlt

msg_pass db "MCSP EDU DMA 0.35: CONDITIONAL PASS",13,10,0
msg_fail db "MCSP EDU DMA 0.35: FAIL",13,10,0

align 8
gdt:
    dq 0
    dq 0x00cf9a000000ffff
    dq 0x00cf92000000ffff
gdt_end:
gdt_desc:
    dw gdt_end-gdt-1
    dd gdt

times 510-($-$$) db 0
dw 0xaa55
