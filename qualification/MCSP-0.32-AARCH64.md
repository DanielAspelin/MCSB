# MCSP AArch64 Lineage Qualification 0.32

Status: Experimental cross-ISA realization
Qualification: Unverified

Primary artifact:

    assembly/aarch64/gas/mcsp_lineage.s

Semantic contract:

    model/LINEAGE-NORMAL-FORM-0.31.mcsp

The AArch64 witness was authored against the same normalized lineage obligations as the verified x86-64 NASM/GAS witnesses.

It targets the same bootstrap structural fingerprint:

    0x0f646d0bb5be8531

AArch64 registers, instructions, GAS syntax, ELF representation, and Linux syscall ABI are realization details and do not define MCSP meaning.

## Current environment boundary

Checked host: espoo02

The following were not present at qualification preparation time:

    aarch64-linux-gnu-as
    aarch64-linux-gnu-ld
    qemu-aarch64

No packages were installed and no system configuration was changed.

Therefore:
- source realization: PRESENT;
- assembly/link: UNVERIFIED;
- execution: UNVERIFIED;
- projection agreement with x86-64: UNVERIFIED;
- cross-ISA preservation: UNVERIFIED.

## Qualification path

Runtime qualification requires either:
1. a native AArch64 environment with suitable assembler/linker, or
2. an explicitly authorized cross-toolchain and AArch64 execution environment.

Only after successful assembly, link, execution, and projection comparison may this witness contribute cross-ISA preservation evidence.

C is not required.

Kernel remains DETERMINATE CONDITION.
