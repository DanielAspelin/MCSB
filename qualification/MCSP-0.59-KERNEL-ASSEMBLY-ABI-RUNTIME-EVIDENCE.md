# MCSP 0.59 Kernel Assembly ABI Reconciliation Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS
Qualification class: Constructive Linux x86-64 kernel-ABI reconciliation

ABI correction commit:

    6f0aaf91a6d4ad94bcea13a0ef37a83ae8624ce4

## Build evidence

Linux kernel:

    6.12.111+deb13-amd64

Kbuild completed through CC, NASM, LD, MODPOST, final .ko and BTF.

Warning audit:

    WARNING_AUDIT=PASS

No objtool or compiler warning was emitted.

Both assembly-owned MCSP predicates are sized ELF FUNC symbols:
- mcsp_edu_identity_match size 28;
- mcsp_edu_observation_match size 23.

Both disassemblies terminate with a relocation to:

    __x86_return_thunk

Final module SHA-256:

    b4e9ffad4620ab2cbb4af1b131c8564ef69629dd72fcd9950d745d3c7f888d9d

## Isolated runtime regression

QEMU EDU enumeration:

    pci 0000:00:01.0: [1234:11e8]

Identity predicate:

    MCSP58_IDENTITY vendor=1234 device=11e8 predicate=1

Read-only observation:

    MCSP58_OBSERVE bar=0 offset=0000 width=32 value=010000ed predicate=1

Module insertion:

    MCSP59_INSMOD_EXIT=0

QEMU exit:

    0

Host after run:

    mcsp_edu_059 loaded count = 0

No BUG, Oops, general-protection, or invalid-opcode evidence appeared in the
captured filtered runtime evidence.

The unsigned/out-of-tree module taint remains expected experimental residue and
is separate from the resolved assembly return-thunk issue.

## Qualification

0.58 objtool/MITIGATION_RETHUNK residue: RESOLVED for tested configuration.
Warning-free Kbuild: VERIFIED.
Sized kernel-facing MCSP assembly symbols: VERIFIED.
Linux return-thunk projection: VERIFIED.
0.58 semantic observation preserved: VERIFIED.
Isolated runtime behavior preserved: VERIFIED.
Host isolation: VERIFIED.

Cross-kernel/configuration ABI portability: UNVERIFIED.
Signed-module production path: UNVERIFIED.
Physical hardware: UNVERIFIED.
Production naturalization: UNVERIFIED.

The ABI mechanism is not semantic authority. The MCSP kernel remains
DETERMINATE CONDITION.
