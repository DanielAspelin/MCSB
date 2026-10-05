# MCSP Closure Ledger

**Version:** 0.6  
**Qualification:** Under Conditional Experiment

## Reduced terms

| Term | 0.6 reduction |
| --- | --- |
| representation | REPRESENT relation |
| observation | OBSERVE relation over STATE at ORDER position |
| unit | UNIT partition reference |
| extent | bounded POSITION relation under UNIT |
| scope | relation domain for identity distinction |
| coordinates | representation of POSITION relative to reference |
| mapping | MAP correspondence relation |
| ordering | ORDER relation |
| requirement | REQUIRE / CONSTRAINT relation |
| event | observed TRANSITION construct |
| rule | admissible transition RELATION |
| cause | antecedent/consequent relation under RULE |
| logical observation position | POSITION within ORDER space |
| availability | STATE over resource/capability under constraints |

## Candidate foundational graph

- CONSTRUCT
- RELATION
- IDENTITY
- SCOPE
- STATE
- POSITION
- ORDER
- TRANSITION
- OPERATION
- CONSTRAINT
- OUTCOME

Derived machinery includes REPRESENT, UNIT, EXTENT, COORDINATE, MAP, OBSERVE, REQUIRE, EVENT, RULE, CAUSE, AVAILABLE, REALIZATION, CAPABILITY, ADDRESS, WIDTH, VALUE, READ, WRITE, COPY, COMPUTE, SCHEDULE, ALLOCATE, RELEASE, TRANSFER, SIGNAL and control-transition constructs.

## Open foundational residue

| Residue | Why still open |
| --- | --- |
| distinguishability | needed to explain identity/value/state without circular synonym substitution |
| configuration | needed for STATE |
| collection / cardinality | needed for relation sets and repeated structures |
| partition | needed for UNIT and bounded representation |
| correspondence | needed for MAP/REPRESENT |
| admissibility | needed for CONSTRAINT/RULE |
| occurrence | needed to distinguish a transition definition from a transition instance |
| semantic preservation/equivalence | needed to qualify host realizations |
| termination criterion | needed to prove finite closure rather than merely observe a finite document |

## Cycle audit

- CONSTRUCT <-> RELATION: mutual recursion; provisionally acceptable as graph structure, semantically unqualified.
- IDENTITY <-> SCOPE: mutual dependence; requires domain/distinction formalization.
- STATE <-> OBSERVE: previous definitional cycle reduced; STATE no longer depends on OBSERVE for its definition.
- OPERATION -> RULE -> RELATION: structurally finite, semantics depend on admissibility.
- REALIZATION -> MAP -> correspondence: open until preservation/equivalence is formalized.

## Qualification gate for 0.7

Do not declare self-description closure unless:
1. foundational residue is represented without introducing equal or greater unexplained residue;
2. recursive definition graph has an explicit finite termination criterion;
3. host realization equivalence can be stated and tested;
4. at least x86-64, AArch64 and RISC-V mappings pass representative semantic tests.
