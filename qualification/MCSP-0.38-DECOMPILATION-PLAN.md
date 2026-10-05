# MCSP 0.38 Decompilation Qualification Plan

Status: Pre-runtime constructive plan

## Fixture

A small assembly artifact implements the already-qualified 0.37 structural fingerprint procedure.

The decompilation test SHALL begin from the built machine artifact and its disassembly evidence, not by treating source labels/comments as recovered information.

## Required reconstruction

From machine evidence, reconstruct only what is sufficiently determined:

1. an accumulator is initialized to a 64-bit constant;
2. a second constant acts as a repeated multiplier;
3. sixteen 64-bit fields are consumed sequentially;
4. each field is combined with the accumulator by XOR;
5. multiplication follows each combination;
6. the resulting 64-bit value is compared with a stored expected value;
7. success/failure control depends on that comparison.

## Forbidden claims

The reconstruction SHALL NOT claim that machine evidence alone proves:
- the documentary name FNV/FNV-1a;
- the original variable names;
- that the fields are semantically called role/value pairs;
- the author's original source syntax;
- the higher-level purpose of the constants.

Those may be correlated with retained project provenance separately.

## Qualification

Pass requires the reconstructed operation graph to reproduce the observed fingerprint from the machine-observed constants and field data.

A second negative reconstruction that changes XOR to addition SHALL fail to reproduce the fingerprint.

This tests both reconstruction support and exclusion of one incompatible interpretation.

Full general-purpose decompilation is outside 0.38.
