# MCSP 0.31 Runtime Qualification Evidence

Qualification date: 2026-10-05
Checkpoint: 0.31
Qualification result: BOUNDED RUNTIME PASS

## Scope

This evidence qualifies only the declared 0.31 deterministic lineage projection on one x86-64 host using two assembler realizations.

It does not establish general host independence or hardware independence.

## Source checkpoint

Repository main HEAD tested:

    7aa931580e0988b33ddfa667cc0ad85ed7bd1ab4

## Environment

Host: espoo02
Architecture: x86_64
Kernel: Linux 6.12.111+deb13-amd64
NASM: 2.16.03
GNU assembler: GNU Binutils for Debian 2.44
GNU ld: GNU Binutils for Debian 2.44

No package installation or system configuration change was required.

Build products were created in a temporary directory and removed after qualification.

## NASM witness

Source:

    assembly/x86_64/nasm/mcsp_lineage.asm

Observed output:

    MCSP NASM lineage 0.31: CONDITIONAL PASS

Exit status:

    0

Object SHA-256:

    047936152eb900608bb24b3406a4e76224e7c67e1ee7a35cc3077c26cfa0adb3

Executable SHA-256:

    479d3d63763165bad3add06f7d2c44426ec92b7b3d157de2625a67ace916265d

## GAS witness

Source:

    assembly/x86_64/gas/mcsp_lineage.s

Observed output:

    MCSP GAS lineage 0.31: CONDITIONAL PASS

Exit status:

    0

Object SHA-256:

    902b7fd615a8ec4e9b34610c449460c7c0731c0e757e453b334bf9e131e7e5b2

Executable SHA-256:

    1911e1b7fd0ea7fef14a8b6995644404060a51bbbadbccee7b13852132cf39f9

## Projection result

Both implementations target and internally validate the 0.31 normalized bootstrap fingerprint:

    0x0f646d0bb5be8531

Both returned success.

Their object and executable SHA-256 values differ. Binary equality is not required by the semantic contract.

This supplies bounded evidence that different assembler representations on the same ISA can realize the same declared MCSP lineage projection while their concrete artifacts differ.

## Qualification state

Deterministic lineage contract: VERIFIED within 0.31 fixture scope.
x86-64 NASM witness runtime: VERIFIED within tested environment.
x86-64 GAS witness runtime: VERIFIED within tested environment.
Same-ISA / different-assembler projection agreement: VERIFIED within 0.31 fixture scope.

General host independence: UNVERIFIED.
Cross-ISA hardware independence: UNVERIFIED.
AArch64 witness: NOT YET IMPLEMENTED/RUN.
RISC-V witness: NOT YET IMPLEMENTED/RUN.

Kernel remains DETERMINATE CONDITION.

C was not used in this runtime qualification.
