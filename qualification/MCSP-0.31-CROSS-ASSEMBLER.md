# MCSP Cross-Assembler Lineage Qualification 0.31

Status: Constructive cross-assembler checkpoint
Qualification: Under Conditional Experiment

Contract: `model/LINEAGE-NORMAL-FORM-0.31.mcsp`
Witnesses:
- `assembly/x86_64/nasm/mcsp_lineage.asm`
- `assembly/x86_64/gas/mcsp_lineage.s`

Both witnesses independently implement the same projected lineage tuple contract.

The reproducibly derived bootstrap structural fingerprint for the declared fixtures is:

    0x0f646d0bb5be8531

The fingerprint is a deterministic representation check only. It is not cryptographic, semantic identity, or proof of equivalence.

## Qualification

Source/design:
- deterministic tuple field order: ESTABLISHED;
- deterministic edge order by child lineage: ESTABLISHED;
- documentary names excluded: ESTABLISHED;
- NASM witness present: ESTABLISHED;
- GAS witness present: ESTABLISHED;
- same expected projection fingerprint: ESTABLISHED.

Runtime:
- NASM assembly/link/execute: UNVERIFIED;
- GAS assembly/link/execute: UNVERIFIED;
- runtime fingerprint equality: UNVERIFIED;
- binary/encoding equality: NOT REQUIRED.

The two assembly sources are not required to use identical syntax, registers, instruction sequences, encodings, or object layout beyond the declared bootstrap projection contract.

## Meaning

If both witnesses execute successfully, that will provide bounded evidence that the 0.31 lineage projection survives two assembler representations on x86-64.

It will not establish cross-ISA hardware independence.

Next qualification step:
- execute NASM witness;
- execute GAS witness;
- record toolchain/environment evidence;
- compare exit status and projected fingerprint;
- then begin AArch64 realization without changing the semantic contract.

Kernel remains DETERMINATE CONDITION.
C remains temporary testing-only and is not required here.
