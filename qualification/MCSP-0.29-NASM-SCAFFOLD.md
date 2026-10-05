# MCSP NASM Scaffold Qualification 0.29

Status: Experimental implementation
Qualification: Under Conditional Experiment
Primary artifact: `assembly/x86_64/nasm/mcsp_scaffold.asm`

## Added structural tests

The NASM witness now implements:

- N1 documentary renaming independence through label-free structural records;
- N2 non-material graph-edge enumeration invariance;
- N3 material sequence-order sensitivity;
- N4 OPEN/PRESET sensitivity in normalized records;
- N5 qualification sensitivity;
- N6 unresolved-residue sensitivity.

## Added propagation tests

Current bootstrap propagation exercises:

- P1 compatible invariant inheritance;
- P2 same-invariant qualification refinement;
- P4 contradiction blocks propagation;
- P5 OPEN remains OPEN in an inherited branch;
- explicit OPEN-to-PRESET settlement is admitted as a distinct fixture case.

## Important limitation

The current propagation record does not yet carry a separate settlement-event record.

Therefore OPEN-to-PRESET acceptance demonstrates only the intended transition rule; it does not yet prove that an implementation can distinguish an authorized/qualified settlement from accidental status mutation.

That distinction is mandatory in the next representation.

## Assembly dominance

This implementation is x86-64 NASM and uses no C or libc.

Linux syscall ABI, qword widths, numeric fixture tokens, memory layout, and NASM syntax are realization details only.

## Runtime status

Source-level implementation exists.

No assembly, link, or execution evidence is recorded by this checkpoint.

Therefore no runtime PASS is asserted.

## Remaining propagation work

- P3 explicit applicability narrowing record;
- P6 divergent realization-defined branches;
- P7 canonical invariant across compatible branches;
- P8 visible unresolved residue propagation;
- P9 failed qualification cannot propagate as PASS;
- P10 deterministic lineage reconstruction;
- explicit settlement-event/provenance record;
- independent x86-64 GAS realization.

Host independence: UNVERIFIED.
Hardware independence: UNVERIFIED.
Kernel: DETERMINATE CONDITION.
