# MCSP NASM Structural Bootstrap 0.28

Status: Experimental implementation
Qualification: Under Conditional Experiment

Primary artifact: `assembly/x86_64/nasm/mcsp_scaffold.asm`

This is the first assembly-dominant executable witness for structural scaffold comparison.

It intentionally proves only a narrow bootstrap property:
- documentary names do not participate in structural comparison;
- OPEN versus PRESET is material;
- qualification changes are material;
- unresolved residue changes are material.

The qword record layout is a temporary x86-64 bootstrap representation. Its integers, widths, memory layout, Linux syscall ABI, and NASM syntax do not define MCSP semantics.

Build target:

    nasm -f elf64 assembly/x86_64/nasm/mcsp_scaffold.asm -o mcsp_scaffold.o
    ld -o mcsp_scaffold mcsp_scaffold.o
    ./mcsp_scaffold

Expected successful output:

    MCSP NASM bootstrap: CONDITIONAL PASS

A successful execution is runtime evidence for these fixture tests only. It does not prove semantic closure, host independence, or hardware independence.

Remaining normalization work:
- N2 irrelevant ordering invariance;
- N3 material ordering sensitivity;
- structural graph normalization rather than flat-record equality;
- propagation P1-P10;
- independent GAS witness;
- cross-ISA witnesses.

C is not required by this implementation.
