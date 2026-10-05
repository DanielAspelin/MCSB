# MCSP Self-Description Contract

MCSP reaches self-description closure only when its formal definitions can be represented by MCSP itself.

## Required representable entities

MCSP must represent:
- construct definitions;
- identities and positions;
- relations;
- inputs and outputs;
- pre-state, transition and post-state;
- ordering and scheduling constraints;
- encodings/representations;
- realization mappings;
- capability/unsupported conditions;
- errors/exceptions;
- the definition schema itself.

## Closure invariant

No undefined external semantic language may be required for the formal definition of MCSP. Natural language may document the system but is not the formal semantic authority.

## Recursive test

A construct definition is admitted provisionally only if its defining components can themselves be represented as constructs. Recursion must converge to a finite primitive closure. Failure to converge is recorded as unresolved residue rather than concealed by implementation terminology.
