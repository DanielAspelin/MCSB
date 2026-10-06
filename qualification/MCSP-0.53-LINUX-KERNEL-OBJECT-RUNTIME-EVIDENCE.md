# MCSP 0.53 Linux Kernel Object Projection Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS
Qualification class: Constructive Linux kernel-object checkpoint

Tested source checkpoint:

    c53323465e3bca86bb4ad286f4c73a3795f6331f

## Direct object build

Source:

    assembly/x86_64/nasm/mcsp_kernel_object.asm

NASM emitted:

    ELF 64-bit LSB relocatable, x86-64
    Type: REL
    Machine: Advanced Micro Devices X86-64

Exported callable symbol:

    mcsp_exclusive_u64

Disassembly:

    mov %rdi,%rax
    xor %rsi,%rax
    ret

Userspace _start symbol: ABSENT.
Undefined runtime symbols: ABSENT.
syscall/sysenter/int 0x80 path: ABSENT.
.note.GNU-stack: PRESENT and non-executable.
Relocatable ld -r consumption: PASS.

Object SHA-256:

    7dbadeb77187c06bc4c870957d68745ca46842a866cbf574d5059c6ca9059a5e

Relocatable-link output SHA-256:

    6402bdf35f8398c4db5136060efcee9ccc117e72febf00234fb08b9dd00888f8

## Linux Kbuild boundary

Running kernel:

    6.12.111+deb13-amd64

Matching Kbuild/header directory:

    /lib/modules/6.12.111+deb13-amd64/build

Kbuild Makefile: PRESENT.

A temporary out-of-tree Kbuild rule invoked NASM through the kernel build tree to
construct mcsp_kernel_object.o.

Kbuild object build exit: 0.
Result remained ELF64 x86-64 REL.
Symbol mcsp_exclusive_u64 remained present.

KBUILD_OBJECT_CONSUMPTION=PASS.

## Qualification

MCSP assembly -> ELF64 relocatable object: VERIFIED fixture.
Callable non-userspace entry symbol: VERIFIED.
No userspace entry/runtime dependency: VERIFIED.
No direct userspace syscall path: VERIFIED.
Non-executable stack declaration: VERIFIED.
Ordinary relocatable linker consumption: VERIFIED.
Matching Linux Kbuild tree consumption of MCSP NASM source: VERIFIED on espoo02.

Loadable .ko construction: UNVERIFIED.
Module metadata/modpost compatibility: UNVERIFIED.
Kernel insertion/loading: NOT ATTEMPTED and requires a separate privileged boundary.
In-kernel execution: UNVERIFIED.
Kernel-version portability: UNVERIFIED.
Other architectures: UNVERIFIED.
Production driver integration: UNVERIFIED.

The Linux kernel is a realization/build boundary and does not become MCSP semantic
authority.

Kernel remains DETERMINATE CONDITION.
C was not used.
