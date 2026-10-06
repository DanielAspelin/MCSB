# MCSP 0.42 Decompiler Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL BOUNDED MCSP DECOMPILER PASS

Tested checkpoint:

    b92190609c08e4f8e0e35aa5f65c54d5fb201faf

## Input boundary

The decompiler consumes the structural tuple produced by the 0.41 boundary:

    relation-token=1
    width=64
    destination-role-token=0
    source-role-token=3
    operand-form=1

Mnemonic text is not an input.

## Reconstructed semantic structure

The runtime reconstructor produced:

    width=64
    source-preserved=1
    destination-replaced=1

Per-position relation:

    0 0 -> 0
    0 1 -> 1
    1 0 -> 1
    1 1 -> 0

Compact evidence:

    000 011 101 110

This equals the material relation pre-settled in 0.39.

Runtime:

    MCSP decompiler 0.42: CONDITIONAL PASS
    exit 0

Object SHA-256:

    3e2573bb1729094d9e9a0c5a6dda474899e4ab2be0325319d19b50c12c2dabeb

Executable SHA-256:

    93256528f7adb615d681f3a6d5eec1ee391589afff4f7176764e978879eb76f5

## Incompatible interpretation

The incompatible OR structure is:

    000 011 101 111

It differs in the material 1,1 input case and is rejected as equivalent reconstruction.

## Unsupported inputs

Unknown relation token: rejected.
Incompatible width 32: rejected.

## Qualification

0.41 tuple -> semantic relation reconstruction: VERIFIED within 0.42 fixture scope.
Width obligation reconstruction: VERIFIED.
Source-preservation obligation reconstruction: VERIFIED.
Destination-replacement obligation reconstruction: VERIFIED.
Four-row semantic relation preservation from 0.39: VERIFIED.
Incompatible OR structure exclusion: VERIFIED.
Unknown relation rejection: VERIFIED.
Incompatible width rejection: VERIFIED.
Mnemonic-independent input boundary: VERIFIED by implementation structure.

General decompiler: UNVERIFIED.
General source recovery: UNVERIFIED and not claimed.
MCSP-native implementation without NASM bootstrap: UNVERIFIED.
Cross-ISA MCSP decompilation: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

The bounded chain is now individually evidenced:

    0.39 semantic machine description
    -> 0.40 MCSP assembler
    -> machine bytes
    -> 0.41 MCSP disassembler
    -> decoded structural tuple
    -> 0.42 MCSP decompiler
    -> reconstructed 0.39 semantic structure

A composed closed-round-trip test remains the next qualification target.

C was not used.
Kernel remains DETERMINATE CONDITION.
