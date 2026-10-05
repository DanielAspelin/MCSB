# MCSP 0.38 Decompilation Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL BOUNDED DECOMPILATION PASS

Architecture:

    model/ASSEMBLY-DISASSEMBLY-DECOMPILATION-0.38.mcsp

Tested checkpoint:

    91b1c101f38da8d6350818e874acb9b4b6f9d0db

Fixture:

    assembly/x86_64/nasm/mcsp_decompilation_fixture.asm

## Artifact evidence

Runtime:

    MCSP decompilation 0.38 fixture: PASS
    exit 0

Executable SHA-256:

    165b427aff40b5fb677e8e203e06de32761592802a5870b85e1ce1238bb22bac

Disassembly SHA-256:

    2fe48eeec3a57ee2a2bce94e533482872a4111f888bf5fb640c6a55a766b3537

## Machine-observed reconstruction

The decoded artifact sufficiently determines this bounded operation graph:

1. load address of sequential data;
2. initialize 64-bit accumulator to 0x14650fb0739d0383;
3. initialize repeated multiplier to 0x100000001b3;
4. initialize iteration count to 16;
5. XOR next 64-bit field into accumulator;
6. multiply accumulator by multiplier;
7. advance data position by 8 bytes;
8. decrement iteration count and repeat;
9. compare result against stored 64-bit expected value;
10. select success/failure control path.

The machine data exposes the sixteen 64-bit fields used by the operation.

Reconstruction result:

    0x8c8892de1e018683

Stored expected result:

    0x8c8892de1e018683

Supported reconstruction:

    PASS

## Incompatible interpretation attack

An otherwise identical reconstruction replacing XOR with addition produced:

    0xb7751479fd339a5b

This does not equal the machine-observed expected result.

Incompatible interpretation rejected:

    PASS

This supplies a bounded example of determination excluding an incompatible higher-level reconstruction.

## Non-authority boundary

The machine evidence alone does not establish:
- original source labels;
- comments;
- original variable/type declarations;
- documentary term FNV/FNV-1a;
- semantic term role/value;
- author's original purpose.

Those claims require separate provenance/evidence.

## Qualification

DECOMPILATION as official MCSP discipline: ESTABLISHED by 0.38 architecture.
Bounded machine-to-structural reconstruction: VERIFIED within fixture scope.
Positive reconstruction reproduction: VERIFIED.
One incompatible reconstruction excluded: VERIFIED.
Observation/inference separation: VERIFIED in qualification procedure.

General-purpose decompiler: UNVERIFIED.
MCSP-native decompiler: UNVERIFIED.
Cross-ISA decompilation preservation: UNVERIFIED.
Recovery of erased source information: NOT CLAIMED.
Semantic closure: UNVERIFIED.

Official machine-level triad is now:

    ASSEMBLY -> machine realization -> DISASSEMBLY -> DECOMPILATION -> qualified MCSP projection

C was not used.
Kernel remains DETERMINATE CONDITION.
