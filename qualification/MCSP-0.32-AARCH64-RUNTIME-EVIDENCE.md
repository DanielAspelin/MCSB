# MCSP 0.32 AArch64 Runtime Qualification Evidence

Qualification date: 2026-10-05
Checkpoint: 0.32
Result: BOUNDED CROSS-ISA RUNTIME PASS

## Source checkpoint

Repository main HEAD tested:

    376cf08e71e808bb50a0b3ed6a085c90f53d336c

Source:

    assembly/aarch64/gas/mcsp_lineage.s

Semantic contract:

    model/LINEAGE-NORMAL-FORM-0.31.mcsp

Expected normalized bootstrap fingerprint:

    0x0f646d0bb5be8531

## Environment

Host: espoo02
Host ISA: x86_64
AArch64 assembler: GNU assembler (GNU Binutils for Debian) 2.44
AArch64 linker: GNU ld (GNU Binutils for Debian) 2.44
Execution environment: qemu-aarch64 10.0.13 (Debian 1:10.0.13+ds-0+deb13u1)

The user explicitly installed the required qualification toolchain before this test.

Build products were created in a temporary directory and removed after qualification.

## Observed artifact

The linked witness was identified as:

    ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, not stripped

Observed output:

    MCSP AArch64 lineage 0.32: CONDITIONAL PASS

Exit status:

    0

Object SHA-256:

    680d886d2ac5c0563ec8c87779b8340cb97d2b2a6431b51a7ab28d2ebe1016c6

Executable SHA-256:

    ade5107f9fa789db1ab59f3f9d06976544a96dfd6c177d66b614a9f8e4fc0321

## Cross-ISA comparison

Previously verified x86-64 witnesses:
- x86-64 / NASM;
- x86-64 / GAS.

Current AArch64 / GAS witness independently realizes the same normalized lineage contract and successfully validates the same bootstrap fingerprint.

Concrete object/executable identity is not required.

This supplies bounded preservation evidence across:
- different assembler representations on x86-64; and
- different ISAs: x86-64 and AArch64.

## Qualification state

0.31 normalized lineage contract: VERIFIED within fixture scope.
x86-64/NASM runtime: VERIFIED within tested environment.
x86-64/GAS runtime: VERIFIED within tested environment.
AArch64/GAS runtime under QEMU: VERIFIED within tested environment.
Same-ISA/different-assembler preservation: VERIFIED within fixture scope.
Cross-ISA x86-64/AArch64 preservation: VERIFIED within fixture scope.

Native AArch64 hardware execution: UNVERIFIED.
RISC-V realization: NOT YET IMPLEMENTED/RUN.
General host independence: UNVERIFIED.
General hardware independence: UNVERIFIED.

The QEMU result is execution evidence for the AArch64 ISA realization but is not represented as native AArch64 hardware evidence.

C was not used.

Kernel remains DETERMINATE CONDITION.
