# MCSP Canonical / Orthogonal / Topological / Taxonomic Contract

**Version:** 0.10  
**Qualification:** Under Conditional Experiment

## Separation

MCSP maintains five independent descriptive systems:

| System | Question |
| --- | --- |
| Semantics | What relation must hold? |
| Canonical | What stable MCSP identity denotes it? |
| Orthogonal | Which dimensions may vary independently? |
| Topology | What is adjacent/reachable/contained/connected? |
| Taxonomy | How is the construct classified? |

No column is permitted to define another merely by naming it.

## Canonical rule

A host spelling never becomes canonical solely by prevalence.

Canonical identity is assigned to an admitted semantic relation within an MCSP scope. Synonyms, aliases, assembler forms and encodings map to that identity.

## Orthogonal rule

Candidate dimensions remain separate until dependency is demonstrated:

identity, value, position, extent, state, transition, order, scope, constraint, outcome, representation, realization.

Host-specific coupling becomes a realization constraint.

## Topological rule

Topology is expressed through relations among positions/states/transitions. Initial relations are ADJACENT, CONNECTED, REACHABLE, BOUNDED, CONTAINED, DISJOINT, OVERLAP, PATH, REGION and INTERFACE.

These names remain candidate derived relations until reduced against the foundation graph.

## Taxonomic rule

Taxonomy is derived classification metadata unless evidence shows that a class distinction is semantically required.

Taxonomy must not become an inheritance system that changes semantic meaning.

## Machine-space rule

A concrete ISA defines an interpretation over machine state and encodings. An assembler defines a notation/tool mapping into that ISA realization.

Therefore ISA, NASM, GNU assembler and machine encoding remain distinct layers.

## Projection invariant

For semantic construct S, host H and constraints C:

    PROJECT(REALIZE(S,H,C), observation_scope)
        EQUIVALENT S

A realization is qualified only if PRESERVE establishes this relation.

## Qualification boundary

0.10 establishes the separation contract. It does not yet prove that every proposed orthogonal or topology relation is minimal or foundational.
