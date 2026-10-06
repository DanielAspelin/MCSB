# MCSP 0.41 Disassembler Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL BOUNDED MCSP DISASSEMBLER PASS

Qualified checkpoint:

    ecaf40cd2f40d0fb9f4e76fad2401974782b2fc8

## Input

Raw target bytes:

    48 31 d8

Raw-byte SHA-256:

    25d80184e98fef40d6120f45f89334cf6c477e7ed842fe5e810281268fa72783

## MCSP reconstruction

The internal decoder reconstructed:

    relation=1
    width=64
    destination-register-token=0
    source-register-token=3
    operand-form=1

This equals the material structural tuple admitted by 0.40.

Runtime:

    MCSP disassembler 0.41: CONDITIONAL PASS
    exit 0

Object SHA-256:

    039f83c65d2ea0683b2f73c7288c4ddf15ff08d3ee3d595939d34ccd04b2b05c

Executable SHA-256:

    bc8b3df392dd212fe193d3bb03a8224880ce8ff18ec07857c2757a8478a7041e

## Negative cases

The decoder rejected:
- opcode mutation 48 09 d8;
- incompatible/missing 64-bit prefix sequence 31 d8 90.

Unsupported encodings were not guessed.

## Independent audit

GNU objdump independently rendered the qualified raw bytes as:

    48 31 d8    xor %rbx,%rax

This external text was not input to the MCSP decoder.

## Round trip

Within fixture scope:

    S = {relation=1,width=64,dst=0,src=3,form=1}
    ASSEMBLE_0.40(S) = 48 31 d8
    DISASSEMBLE_0.41(48 31 d8) = S

Therefore bounded structural round-trip preservation is VERIFIED.

## Preserved failed checkpoint

Initial source checkpoint afb730a93e198ee342ced71f28518fe91a79ee4b failed NASM assembly because the label 'out' collided with the x86 OUT instruction keyword.

Successor ecaf40cd2f40d0fb9f4e76fad2401974782b2fc8 renamed only the bootstrap buffer label and passed.

This was an implementation/source-symbol defect, not a semantic decoding counterexample.

## Qualification

Bounded raw-byte -> structural tuple decoding: VERIFIED.
0.40 -> 0.41 structural round trip: VERIFIED within fixture scope.
Mutation rejection: VERIFIED.
External-disassembler independence of decoding decision: VERIFIED by implementation boundary.

General x86-64 disassembler: UNVERIFIED.
Variable register decoding: UNVERIFIED.
Variable opcode/operand decoding: UNVERIFIED.
MCSP-native implementation without NASM bootstrap: UNVERIFIED.
Cross-ISA MCSP disassembler: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

C was not used.
Kernel remains DETERMINATE CONDITION.
