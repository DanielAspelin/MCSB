# MCSP Closure Ledger

**Version:** 0.7  
**Qualification:** Under Conditional Experiment

## 0.6 residue disposition

| 0.6 residue | 0.7 candidate reduction | Status |
| --- | --- | --- |
| distinguishability | DISTINGUISH | candidate |
| configuration | CONFIGURATION | candidate |
| collection/cardinality | COLLECTION + COUNT | candidate |
| partition | PARTITION | candidate |
| correspondence | CORRESPOND | candidate |
| admissibility | ADMIT | candidate |
| occurrence | OCCURRENCE | candidate |
| semantic preservation/equivalence | PRESERVE + EQUIVALENT | candidate |
| primitive graph termination criterion | finite closure criterion + graph traversal | specified |

## Candidate foundation

CONSTRUCT, RELATION, DISTINGUISH, IDENTITY, SCOPE, COLLECTION, ORDER, POSITION, CONFIGURATION, STATE, TRANSITION, OPERATION, RULE, CONSTRAINT, CONDITION, OUTCOME, OCCURRENCE.

Everything else should be tested for derivability from this set before being promoted to foundational status.

## Structural closure gates

- finite admitted foundation;
- finite definition graph;
- no external undefined dependency;
- explicit cycles;
- interpretable cycles;
- closure graph representable as MCSP state.

## Semantic closure gates

- DEFINE represented in MCSP;
- foundation definitions represented in MCSP;
- closure rules represented in MCSP;
- relation evaluation requires no unrepresented semantic category;
- host realization preservation test executable.

## Host witness gates

Representative semantic mappings must be tested on:
- x86-64;
- AArch64;
- RISC-V.

Initial witness classes:
- COPY;
- VALUE;
- READ;
- WRITE;
- COMPUTE/ADD;
- COMPARE/condition;
- BRANCH;
- INVOKE/RETURN;
- ordering/barrier;
- atomic read-modify-write.

## Current result

0.7 closes the named 0.6 residue at the specification level, but does **not** yet prove semantic self-description.

Next evidence must be executable/machine-readable:
1. encode foundation graph;
2. traverse graph and verify finite dependency closure;
3. encode representative host mappings;
4. evaluate PRESERVE conditions.
