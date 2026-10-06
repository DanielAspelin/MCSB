# MCSP 0.43 Closed Round-Trip Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL CLOSED ROUND-TRIP PASS

Tested checkpoint:

    2f2c9209082cbe7e5cfccbee680442d0a953281a

## Integrated path

One executable fixture performed:

    original semantic structure
    -> structural tuple
    -> MCSP assembler
    -> runtime-emitted machine bytes
    -> machine execution
    -> MCSP disassembler over the same emitted bytes
    -> reconstructed structural tuple
    -> MCSP decompiler
    -> reconstructed semantic structure

The fixture did not rely on the historical component PASS results to establish the integrated result.

## Runtime

    MCSP closed round-trip 0.43: CONDITIONAL PASS

Exit:

    0

Object SHA-256:

    1a64d7e7cfa7eb65084cb8c8eae03bfc0e17a3a33b3e513d82cd015674a06fcc

Executable SHA-256:

    9319553a73fa7570ce44e3a0d74d0fea0ff18cd756c8eee0816450a5a09a8f53

Emitted target fragment including harness RET:

    48 31 d8 c3

SHA-256:

    1d49f7ebabb6fe43f009accf0b4a873671d9513f7b9e50e0ead4da1173e8402f

## Semantic preservation

Original and reconstructed semantic structures were compared field-for-field across 15 qwords:

    width=64
    source-preserved=1
    destination-replaced=1
    00->0
    01->1
    10->1
    11->0

All material fields matched.

The decoded five-field structural tuple was also compared field-for-field to the assembler input:

    relation=1
    width=64
    destination=0
    source=3
    form=1

All fields matched.

## Machine behavior

The runtime-emitted operation was executed over:

    A=0x55aa55aa55aa55aa
    B=0x0f0ff0f00f0ff0f0

Observed destination satisfied:

    0x5aa5a55a5aa5a55a

Source preservation passed.

## Adversarial attacks

Machine-byte opcode mutation:

    48 09 d8

was rejected by the MCSP disassembler.

Unsupported structural relation token 2 was rejected by the MCSP assembler.

Incompatible reconstructed OR relation:

    00->0
    01->1
    10->1
    11->1

was distinguished from the reconstructed qualified relation and rejected as equivalent semantics.

## External audit boundary

GNU objdump independently observed:

    48 31 d8    xor %rbx,%rax
    c3          ret

This was external audit evidence only. Its output did not participate in the internal assembler, disassembler, decompiler or semantic comparison.

## Qualification

Composed 0.39 -> 0.40 -> 0.41 -> 0.42 path: VERIFIED within bounded x86-64 fixture scope.
Same-byte execution and disassembly continuity: VERIFIED.
Structural tuple round trip: VERIFIED.
Semantic 15-field round trip: VERIFIED.
Machine behavior preservation: VERIFIED.
Byte mutation rejection: VERIFIED.
Unsupported structural mutation rejection: VERIFIED.
Incompatible semantic reconstruction exclusion: VERIFIED.

General x86-64 assembly/disassembly/decompilation: UNVERIFIED.
Multiple-operation closed round trip: UNVERIFIED.
Cross-ISA closed round trip: UNVERIFIED.
MCSP-native bootstrap independent of NASM/ld: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

This result is a Constructive qualified checkpoint, not a Permanent Seal.

C was not used.
Kernel remains DETERMINATE CONDITION.
