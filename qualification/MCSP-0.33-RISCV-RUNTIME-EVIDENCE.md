# MCSP 0.33 RISC-V Runtime Qualification Evidence

Qualification date: 2026-10-05
Checkpoint: 0.33
Result: BOUNDED THREE-ISA RUNTIME PASS

## Source checkpoint

Repository main HEAD tested:

    acdd2e8acdb7eaf8c636376ad2499670d8df2116

Source:

    assembly/riscv64/gas/mcsp_lineage.s

Semantic contract:

    model/LINEAGE-NORMAL-FORM-0.31.mcsp

Normalized bootstrap fingerprint:

    0x0f646d0bb5be8531

## Environment

Host: espoo02
Host ISA: x86_64
RISC-V assembler: GNU assembler (GNU Binutils for Debian) 2.44
RISC-V linker: GNU ld (GNU Binutils for Debian) 2.44
Execution: qemu-riscv64 10.0.13 (Debian 1:10.0.13+ds-0+deb13u1)

The user explicitly installed the required RISC-V cross-binutils before this test.

Build products were isolated in a temporary directory and removed afterward.

## Build / execution

Assembler configuration:

    -march=rv64im -mabi=lp64

Linked artifact:

    ELF 64-bit LSB executable, UCB RISC-V, soft-float ABI, version 1 (SYSV), statically linked, not stripped

Observed output:

    MCSP RISC-V lineage 0.33: CONDITIONAL PASS

Exit status:

    0

Object SHA-256:

    c83df430baab3f9579b62b289616df9fed724720d304ee38729058ee56811619

Executable SHA-256:

    2a9b016efecf27e5ac4a0111c85210be6b1e7631a94e04bdb3b73a998d756165

## Three-ISA comparison

Qualified realization witnesses now include:
- x86-64 / NASM, native execution;
- x86-64 / GAS, native execution;
- AArch64 / GAS, QEMU execution;
- RISC-V RV64IM / GAS, QEMU execution.

All validate the same declared normalized lineage projection fingerprint while concrete assembly, ISA, object files, and executables differ.

This is bounded evidence that the declared MCSP lineage semantic projection is preserved across x86-64, AArch64, and RISC-V RV64IM realization paths.

It is not proof of universal hardware independence.

## Qualification state

Three-ISA projection preservation: VERIFIED within 0.31-0.33 fixture scope.
Native x86-64 evidence: VERIFIED.
AArch64 ISA/QEMU evidence: VERIFIED.
RISC-V ISA/QEMU evidence: VERIFIED.
Native AArch64 hardware: UNVERIFIED.
Native RISC-V hardware: UNVERIFIED.
Non-CPU realization: UNVERIFIED.
General host independence: UNVERIFIED.
General hardware independence: UNVERIFIED.

C was not used.

Kernel remains DETERMINATE CONDITION.
