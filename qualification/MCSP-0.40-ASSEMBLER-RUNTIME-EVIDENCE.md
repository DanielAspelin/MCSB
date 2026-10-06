# MCSP 0.40 Assembler Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL BOUNDED MCSP ASSEMBLER PASS

Tested checkpoint:

    19166c7069b7c16c297d221c76804c6b3bc23bff

Artifacts:

    model/ASSEMBLER-SEED-0.40.mcsp
    assembly/x86_64/nasm/mcsp_assembler_seed.asm
    qualification/MCSP-0.40-ASSEMBLER-SEED-PLAN.md

## Structural input

The runtime assembler accepts the bounded tuple:

    relation=0x01
    width=64
    destination-register-token=0
    source-register-token=3
    operand-form=register/register

A width=32 mutation is deliberately unsupported and is rejected.

## Runtime assembly

Observed output:

    MCSP assembler seed 0.40: CONDITIONAL PASS

Exit:

    0

Object SHA-256:

    dd2dfbf7ea6bc765a152ef2cef8357db43b121830a1511927bdad3b06dcf8f66

Emitter executable SHA-256:

    4c57f56e994356ed4ee238c525b59cce6f6243341b07d6ffcca27b5f51ddd728

The assembler logic emitted the target operation bytes at runtime:

    48 31 d8

The harness appended:

    c3

as a return boundary so the emitted operation could be executed safely as a callable fragment.

Raw emitted fragment SHA-256:

    1d49f7ebabb6fe43f009accf0b4a873671d9513f7b9e50e0ead4da1173e8402f

## Independent disassembly observation

GNU objdump over the raw emitted fragment observed:

    48 31 d8    xor %rbx,%rax
    c3          ret

The mnemonic is realization evidence, not semantic authority.

## Behavioral projection

The emitted target operation executed over the inherited 0.39 fixture:

    A = 0x55aa55aa55aa55aa
    B = 0x0f0ff0f00f0ff0f0

and satisfied the pre-settled destination:

    0x5aa5a55a5aa5a55a

The source-preservation obligation also passed.

## Bootstrap boundary

NASM assembled the emitter program.

NASM did NOT assemble the target operation from a target mnemonic. The target bytes were selected and written at runtime by the bounded MCSP assembler mechanism from the admitted structural tuple.

Therefore this is evidence for a bounded MCSP assembler decision, while the emitter implementation remains externally bootstrapped.

## Qualification

Bounded structural tuple -> x86-64 encoding: VERIFIED within 0.40 fixture scope.
Unsupported tuple rejection: VERIFIED within fixture scope.
Runtime target-byte emission: VERIFIED.
Emitted target execution: VERIFIED.
Behavioral preservation from 0.39: VERIFIED.
Independent raw-byte disassembly: VERIFIED.

General x86-64 assembler: UNVERIFIED.
Multiple operation selection: UNVERIFIED.
Operand encoding generalization: UNVERIFIED.
MCSP-native emitter implementation without external assembler bootstrap: UNVERIFIED.
Cross-ISA MCSP assembler: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

C was not used.
Kernel remains DETERMINATE CONDITION.
