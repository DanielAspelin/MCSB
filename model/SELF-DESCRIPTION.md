# MCSP Self-Description Contract

MCSP reaches self-description closure only when its formal definitions can be represented by MCSP itself.

## Required representable entities

MCSP must represent:
- construct definitions;
- identities and positions;
- relations;
- values, widths and states;
- inputs and outputs;
- pre-state, transition and post-state;
- ordering and scheduling constraints;
- allocation and release;
- reads, writes and transfers;
- encodings/representations;
- realization mappings and capabilities;
- errors/exceptions and outcomes;
- the definition schema itself.

## Closure invariant

No undefined external semantic language may be required for the formal definition of MCSP. Natural language may document the system but is not the formal semantic authority.

## Recursive test

A construct definition is admitted provisionally only if its defining components can themselves be represented as constructs. Recursion must converge to a finite primitive closure. Failure to converge is recorded as unresolved residue rather than concealed by implementation terminology.

## MCSP 0.5 checkpoint

The 0.5 semantic model establishes a provisional structural recursion:

    DEFINE -> CONSTRUCT
    field -> RELATION
    precondition -> CONSTRAINT
    transition -> TRANSITION
    result -> OUTCOME
    identity -> IDENTITY
    realization -> REALIZATION

This is a constructive PASS for structural self-description only.

It is not semantic closure. Current unresolved residue includes representation, observation, unit, extent, scope, coordinates, mapping, ordering, requirement, event, rule, cause, logical observation position and availability.

Qualification remains **Under Conditional Experiment** until those terms are decomposed and the recursive graph demonstrably converges rather than cycling through synonyms.
