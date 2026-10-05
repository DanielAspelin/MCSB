# MCSP TRANSFER Witness Contracts 0.21

Status: Constructive test design
Qualification: Unverified execution specification
Parent: Hardware Independence Matrix 0.20

## Purpose

Define comparable realization contracts before executing hardware witnesses.

The test SHALL compare projected semantic behavior, not source spelling, instruction count, opcode, or encoding identity.

## Candidate semantic contract

TRANSFER is provisionally qualified over a declared applicability boundary by:

    SOURCE
    DESTINATION
    MATERIAL DISTINCTIONS
    EXTENT
    ORDER REQUIREMENTS
    COMPLETION REQUIREMENTS
    FAILURE REQUIREMENTS
    FORBIDDEN OBSERVABLE EFFECTS

A witness passes only the contract it declares.

## Common test vector

Use an implementation-independent byte sequence as a realization test payload.

The byte representation is test data, not the definition of TRANSFER.

Required observation:

    destination projection preserves the declared payload distinctions
    after the declared completion condition.

Source preservation is NOT assumed unless the specific contract requires it.

## W1 x86-64 NASM

Realize a bounded memory-to-memory semantic transfer through an x86-64 instruction sequence represented in NASM.

Record:
- input bytes;
- source/destination extents;
- generated machine code;
- completion point;
- destination bytes;
- observable failure.

Do not require instruction-count equality with another witness.

## W2 x86-64 GAS

Independently realize the same bounded semantic contract using GNU assembler representation.

Compare projected result with W1 through the MCSP contract, not assembler text.

NASM and GAS remain separate witnesses.

## W3 AArch64 GAS

Realize the same bounded contract through AArch64 semantics represented by GAS.

Register names, instruction widths, addressing forms, and machine encoding may differ.

## W4 RISC-V GAS

Realize the same bounded contract through a selected RISC-V base/profile and GAS.

Required ISA/profile capability SHALL be recorded.

Unsupported capability is a valid explicit outcome and not semantic redefinition.

## W5 DMA

Realize the bounded transfer using an available DMA mechanism or faithful qualified emulator/model.

Record descriptor/queue setup, source/destination visibility, completion mechanism, and relevant ordering/coherency requirements.

CPU instructions used to configure DMA are not the transfer realization itself.

## W6 Network

Realize only a deliberately bounded shared invariant.

The network witness SHALL declare transport/protocol, framing effects, ordering guarantee, loss/failure behavior, and completion interpretation.

It SHALL NOT be called equivalent to local memory transfer outside the shared declared invariant.

## Projection record

Each witness emits or records a normalized observation:

    witness
    realization
    applicability
    source_extent
    destination_extent
    input_digest
    output_digest
    completion
    failure
    forbidden_effect_observed
    canonical_result

This record is qualification data, not MCSP ontology.

## Pass rule

A witness conditionally passes when:
- the material input distinctions are reproduced at the destination as declared;
- extent requirements hold;
- required ordering holds;
- required completion holds;
- failure behavior remains within the contract;
- no forbidden observable effect occurs.

## Cross-witness rule

Hardware-independence evidence strengthens when materially different witnesses pass the same semantic invariant without importing witness-specific constructs into that invariant.

Textual or binary equality between implementations is neither required nor expected.

## Reduction warning

TRANSFER remains a candidate canonical.

The tests SHALL also record whether TRANSFER decomposes completely into more fundamental MCSP relations.

If it does, TRANSFER may remain a useful canonical while being non-primitive.

Canonical does not mean primitive.

## Qualification boundary

This file defines tests only.

No W1-W6 runtime PASS is asserted until actual execution evidence exists.

No Permanent Seal is asserted.
