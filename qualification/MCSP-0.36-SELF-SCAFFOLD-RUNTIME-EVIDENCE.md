# MCSP 0.36 Self-Scaffolding Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL SELF-SCAFFOLD PASS

Qualified checkpoint:

    4fd258f29465cf58a3dc39e1fcc23733d4e6eb39

Artifacts:

    model/SELF-SCAFFOLDING-0.36.mcsp
    assembly/x86_64/nasm/mcsp_self_scaffold.asm

Observed output:

    MCSP self-scaffold 0.36: CONDITIONAL PASS

Exit:

    0

Object SHA-256:

    f2414fc75093a591c6592794c30209d973fe8e769cdc28c8ddb792a1bb6d7549

Executable SHA-256:

    79c1d068fbdbba4a48a55d9d8cc09d60eede8cf9367021a12f4898c3649e125d

## Qualified behavior

The assembly evaluator discovers structural values by role/value pairs carried in scaffold data. Documentary field names are not evaluator inputs.

Runtime adversarial suite establishes within fixture scope:
- compatible successor accepted;
- material invariant mutation rejected;
- unresolved residue loss rejected;
- applicability narrowing without event rejected;
- applicability narrowing with explicit event accepted;
- OPEN->PRESET without settlement event rejected;
- OPEN->PRESET with settlement event accepted;
- failed qualification rejected.

## Preserved failed evidence

Initial checkpoint a406ec284fda42f765aab9b595010b39967f2b8b failed assembly because x86 effective-address scales do not support rcx*16.

Successor f36ddc3992c51bd44c0370936e086dfced68a4fc corrected pair traversal and built, but runtime suite failed because the test harness did not restore the parent pointer for each independent adversarial case.

Successor 4fd258f29465cf58a3dc39e1fcc23733d4e6eb39 corrected test inputs and passed.

The two failures are classified as witness implementation defects, not semantic counterexamples.

## Qualification boundary

Structural role-carrying self-scaffold: VERIFIED within 0.36 fixture scope.
Self-propagation adversarial rules: VERIFIED within fixture scope.
Documentary labels excluded from evaluator inputs: VERIFIED by implementation structure.
Full deterministic normalization/fingerprint for 0.36: NOT YET IMPLEMENTED.
Independent second-assembler self-scaffold witness: UNVERIFIED.
MCSP-native evaluator: UNVERIFIED.
Semantic closure: UNVERIFIED.
Self-description closure: UNVERIFIED.

Therefore 0.36 is a constructive self-scaffolding checkpoint, not a closure claim.

C was not used.
Kernel remains DETERMINATE CONDITION.
