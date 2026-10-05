# MCSP Closure Ledger

**Version:** 0.5  
**Purpose:** Prevent unresolved semantics from being mistaken for primitive closure.

| Term | 0.5 status | Depends on / next test |
| --- | --- | --- |
| CONSTRUCT | candidate foundation | identity, relation, state |
| DEFINE | structurally recursive | CONSTRUCT + RELATION |
| IDENTITY | candidate | scope |
| RELATION | candidate foundation | source, target, relation-kind |
| POSITION | decomposed provisionally | space, coordinates |
| VALUE | decomposed provisionally | representation, width |
| WIDTH | decomposed provisionally | unit, extent |
| STATE | decomposed provisionally | observation |
| TRANSITION | decomposed provisionally | operation, constraints, outcome |
| CONDITION | decomposed provisionally | relation, observation |
| ATTRIBUTE | decomposed provisionally | relation + value |
| CONSTRAINT | decomposed provisionally | requirement |
| SPACE | decomposed provisionally | identity + relations |
| OPERATION | decomposed provisionally | transition rule |
| OUTCOME | decomposed provisionally | classification/state |
| EXCEPTION | decomposed provisionally | cause |
| CONVENTION | decomposed provisionally | rules |
| REALIZATION | decomposed provisionally | host, capability, mapping |
| CAPABILITY | decomposed provisionally | availability |
| representation | OPEN | encode distinguishable state |
| observation | OPEN | relation between state and observer/position |
| unit | OPEN | measurement/partition relation |
| extent | OPEN | bounded relation over space |
| scope | OPEN | identity domain |
| coordinates | OPEN | positional representation |
| mapping | OPEN | relation-preserving correspondence |
| ordering | OPEN | relation among transitions/positions |
| requirement | OPEN | admissibility relation |
| event | OPEN | observable transition/state |
| rule | OPEN | relation governing admissible transition |
| cause | OPEN | explanatory/precedence relation |
| logical observation position | OPEN | state + ordering model |
| availability | OPEN | capability/resource state |

## Qualification rule

A term moves from OPEN only when its definition reduces semantic residue rather than merely renaming it. Cycles are permitted only when their semantics are fully expressed by a finite closed relation graph.
