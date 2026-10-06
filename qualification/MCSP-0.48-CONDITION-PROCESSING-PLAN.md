# MCSP 0.48 Condition Processing Assurance Qualification Plan

Required baseline sequence:

1. work=0 calculates CONDITION=IDLE;
2. work=1 calculates CONDITION=PROCESSING;
3. MODE changes FOREGROUND -> BACKGROUND -> FOREGROUND;
4. work=0 recalculates CONDITION=IDLE;
5. processing count equals 3;
6. STATE remains absent;
7. TYPE remains absent;
8. release invocation remains absent.

Attacks:

- unsupported work input must be rejected;
- forced STATE introduction must be rejected;
- forced TYPE introduction must be rejected;
- forced release invocation must be rejected;
- unsupported MODE must be rejected.

Repeat the executable to establish that repeated fresh processing does not add an
automatic promotion or release path.

BACKGROUND in this fixture is a semantic MODE only and is not authorization or
execution of terminal detachment.
