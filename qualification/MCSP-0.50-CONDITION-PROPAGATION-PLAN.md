# MCSP 0.50 Condition Propagation Qualification Plan

Purpose: reconcile PROPAGATION-0.26 with CONDITION-CONTINUITY-0.49.

Accepted baseline:

    PROCESSING / FOREGROUND / GENERAL
      -> INHERIT
      -> REFINE
      -> NARROW applicability to TERMINAL
      -> PROJECT mode to BACKGROUND

Required final properties:

- CONDITION remains PROCESSING;
- MODE becomes BACKGROUND only at PROJECT;
- applicability becomes TERMINAL only at NARROW;
- qualification remains present;
- lineage advances deterministically;
- STATE remains absent;
- TYPE remains absent;
- terminal release remains absent.

Adversarial tests:

1. incompatible inherited condition must fail accepted propagation;
2. forced STATE introduction must fail;
3. forced TYPE introduction must fail;
4. forced terminal release must fail;
5. invalid qualification must fail;
6. PROJECT before NARROW must fail applicability guard;
7. corrupted applicability must fail;
8. contradiction must be representable as containment by SUSPEND/REJECT rather
   than semantic promotion.

Qualification does not claim REALIZE coverage, universal propagation closure,
actual background execution, or terminal release.
