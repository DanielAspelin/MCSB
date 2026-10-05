# MCSP 0.39 Native Machine Description Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL NATIVE MACHINE DESCRIPTION PASS

Tested checkpoint:

    43083cb56d613f52eb642a735a09890ad5fd5dc0

## Structural pre-settlement

The operation is defined by:
- 64 corresponding binary positions;
- destination-before and source input roles;
- destination-after output role;
- per-position relation 00->0, 01->1, 10->1, 11->0;
- source preservation;
- destination replacement.

The mnemonic is not the semantic definition.

## Machine realization

Input A:

    0x55aa55aa55aa55aa

Input B:

    0x0f0ff0f00f0ff0f0

Structurally predicted destination:

    0x5aa5a55a5aa5a55a

Observed runtime:

    MCSP native machine description 0.39: CONDITIONAL PASS

Machine encoding observed for the selected transition:

    48 31 d8

Disassembler renders that realization as:

    xor %rbx,%rax

Object SHA-256:

    2ec12b4039483ed292b333b18802fa82f6db26f63d65384a72d7af9b163bcb1c

Executable SHA-256:

    1c62ce44f103dc39c89272d2962f0e60a2aef42cc981a94d11b53100c6514d34

## Reconstruction attack

Structural reconstruction produced:

    0x5aa5a55a5aa5a55a

Incompatible OR interpretation produced:

    0x5faff5fa5faff5fa

OR is excluded by both the concrete fixture and the declared four-row per-position relation.

## Preserved harness failure

A prior run reached machine PASS and printed all positive/negative semantic results, but the external Node qualification wrapper terminated with a ReferenceError after those observations.

That run was not promoted.

The identical committed source checkpoint was rerun with only the wrapper corrected and passed completely.

## Qualification

Structural machine-transition description: VERIFIED within 0.39 fixture scope.
Prediction of machine result: VERIFIED.
Source-preservation obligation: VERIFIED by runtime witness.
Assembly realization: VERIFIED.
Machine encoding observation: VERIFIED.
Disassembly reconstruction support: VERIFIED.
Incompatible OR interpretation exclusion: VERIFIED.

General machine-description language: UNVERIFIED.
MCSP-native assembler: UNVERIFIED.
MCSP-native disassembler: UNVERIFIED.
MCSP-native decompiler: UNVERIFIED.
Cross-ISA description preservation: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

0.39 establishes a native machine-description seed, not a complete instruction ontology.

C was not used.
Kernel remains DETERMINATE CONDITION.
