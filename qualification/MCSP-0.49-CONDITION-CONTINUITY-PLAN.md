# MCSP 0.49 Condition Continuity Qualification Plan — Reconciled

0.49 previously failed because manually entered expected lineage constants were incorrect.
Those failed checkpoints remain part of lineage and are not qualification evidence.

Reconciled target:

1. predecessor condition must equal the previously accepted current condition;
2. sequence must advance exactly by one;
3. primary lineage calculation and independent reconstruction must agree after every accepted observation;
4. no manually entered final lineage constant determines PASS;
5. equal consecutive PROCESSING conditions must remain distinguishable by sequence/continuity evidence;
6. STATE remains absent;
7. TYPE remains absent;
8. terminal release remains absent.

Attacks:
- broken predecessor;
- skipped sequence;
- unsupported current condition;
- unsupported mode;
- forced STATE;
- forced TYPE;
- forced release;
- corrupted independent lineage accumulator.

A PASS requalifies only the reconciled 0.49 scope.
