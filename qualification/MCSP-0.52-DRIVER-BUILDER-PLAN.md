# MCSP 0.52 Driver Builder Interface Qualification Plan

Baseline path:

report -> MCSP Assembler -> encoding -> MCSP Disassembler -> tuple ->
MCSP Decompiler -> semantic comparison -> REALIZE

Required baseline:
- bounded x86-64 report assembles to 48 31 D8;
- disassembly reconstructs the five-field structural tuple;
- decompilation reconstructs the exclusive semantic obligation;
- report and reconstruction agree before REALIZE;
- STATE and TYPE remain absent.

Attacks:
1. unsupported hardware target -> SUSPEND;
2. unqualified report -> SUSPEND;
3. unresolved residue -> SUSPEND;
4. incompatible relation -> REJECT;
5. corrupted encoding -> REJECT;
6. corrupted reconstructed tuple -> REJECT;
7. corrupted semantic reconstruction -> REJECT;
8. forced STATE -> REJECT;
9. forced TYPE -> REJECT.

No production driver is generated or installed by this qualification.
