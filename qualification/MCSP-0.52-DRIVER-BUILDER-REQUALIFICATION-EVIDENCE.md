# MCSP 0.52 Driver Builder Interface Requalification Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS
Qualification class: Constructive driver-builder interface checkpoint

## Lineage

Initial qualification-plan checkpoint:

    256b9db1ee6125dff41f502304772a383f503852

Initial runtime result:

    FAIL, exit 1

Cause:
The witness verifier used incorrect qword offsets for the truth-table portion of
the semantic reconstruction. The semantic array contains three header qwords before
the four truth triples. The failure checkpoint is preserved and is not qualified.

Corrected witness:

    3becd6d23c919ddf3e5f2482e786d6c0ba1b3555

The correction changed verification offsets only; it did not change the semantic
obligation, report contract, or intended construction path.

## Requalification

Baseline:

    MCSP driver builder interface 0.52: CONDITIONAL PASS
    exit 0

Object SHA-256:

    1794635fdf2b5f0b973fed1432e1565e462100acecf004b39e8762860f88f516

Executable SHA-256:

    2d20ffb363d349e69d485de2fcc30ca62fa30f90710bbb9911eb1c46c7dca778

Verified bounded path:

    driver-builder report
      -> MCSP Assembler
      -> 48 31 D8
      -> MCSP Disassembler
      -> structural tuple
      -> MCSP Decompiler
      -> semantic obligation
      -> report comparison
      -> REALIZE

## Adversarial evidence

Unsupported hardware target: contained; baseline executable fails accepted path.
Unqualified report: contained.
Unresolved residue: contained.
Incompatible relation: rejected.
Corrupted encoding: rejected.
Corrupted reconstructed tuple: rejected.
Corrupted semantic reconstruction: rejected.
Forced STATE: rejected.
Forced TYPE: rejected.

64 repeated corrected baseline executions: PASS.

## Qualification

Report -> bounded MCSP Assembler: VERIFIED fixture.
Assembler encoding -> bounded MCSP Disassembler: VERIFIED fixture.
Disassembled tuple -> bounded MCSP Decompiler: VERIFIED fixture.
Reconstructed semantics -> report comparison: VERIFIED fixture.
REALIZE only after agreement: VERIFIED fixture.
Unsupported/unresolved construction containment: VERIFIED fixture.
STATE/TYPE promotion absence: VERIFIED fixture.

Production driver generation: UNVERIFIED and not claimed.
Arbitrary ISA assembly: UNVERIFIED.
Operating-system driver integration: UNVERIFIED.
Driver installation/signing/deployment: UNVERIFIED.
Universal hardware support: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

The driver builder retains implementation authority. MCSP provides reusable
construction and verification machinery under the report obligation.

Kernel remains DETERMINATE CONDITION.
C was not used.
