# MCSP 0.51 Hardware Boundary Reconciliation Qualification Plan

Purpose: exercise REALIZE at a hardware boundary and reconcile 0.18-0.21 with 0.50.

Baseline:
- semantic relation EXCLUSIVE;
- semantic width 64;
- x86-64 -> REALIZE;
- AArch64 -> REALIZE;
- RISC-V64 -> REALIZE;
- unknown hardware -> SUSPEND;
- semantic relation and width remain unchanged.

Attacks:
1. mutate relation to an incompatible relation -> REJECT;
2. mutate semantic width -> REJECT;
3. force semantic-mutation sentinel -> REJECT;
4. force STATE -> REJECT;
5. force TYPE -> REJECT;
6. force release -> REJECT;
7. unknown hardware must never be silently REALIZEd.

Qualification boundary:
This verifies a bounded reconciliation mechanism using existing qualified witness
classes. It does not assert universal hardware support.
