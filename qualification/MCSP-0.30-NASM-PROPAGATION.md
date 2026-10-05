# MCSP NASM Propagation Qualification 0.30

Status: Experimental implementation
Qualification: Under Conditional Experiment
Primary artifact: `assembly/x86_64/nasm/mcsp_propagation.asm`

0.30 separates a semantic scaffold from the event that changes its settlement/applicability status.

A descendant cannot obtain PRESET merely by changing its status field. OPEN -> PRESET requires an explicit settlement event whose parent lineage, child lineage, applicability, and non-failed qualification agree with the participating scaffolds.

Likewise, applicability narrowing requires a separate narrowing event.

Implemented source-level cases:
- P1 compatible inheritance;
- P2 qualification refinement;
- P3 explicit applicability narrowing;
- P4 contradiction rejection;
- P5 OPEN preservation;
- P6 realization-defined branch divergence;
- P7 inherited canonical invariant retention;
- P8 unresolved residue cannot silently disappear;
- P9 failed qualification cannot propagate as PASS;
- P10 lineage fields are explicit and reconstructible in the bootstrap representation.

P10 deterministic serialization is not yet implemented and remains a qualification residue.

The numeric record layout, qword width, Linux syscall ABI, event constants, and lineage tokens are bootstrap realization details, not MCSP semantics.

No C or libc is required.

No runtime assembly/link/execution evidence is asserted by this checkpoint.

Next:
1. implement deterministic lineage serialization/normal form;
2. build an independent x86-64 GAS witness from the same semantic obligations rather than transliterating NASM syntax mechanically;
3. compare projected results;
4. only then consider same-ISA/different-assembler evidence.

Kernel remains DETERMINATE CONDITION.
Host independence UNVERIFIED.
Hardware independence UNVERIFIED.
