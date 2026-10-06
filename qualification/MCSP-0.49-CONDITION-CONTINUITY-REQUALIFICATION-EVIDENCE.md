# MCSP 0.49 Condition Continuity Requalification Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS after reconciliation
Qualification class: Constructive continuity checkpoint

Reconciled tested checkpoint:

    fd84d73d56482a96bc88c42f26c708e8f614feca

## Preserved failure lineage

Earlier 0.49 attempts failed because manually entered expected terminal lineage constants
were incorrect. Those failures are preserved and are not treated as passing evidence.

The reconciled witness removes the manually supplied final lineage constant from the
PASS criterion.

## Reconciled method

For each accepted observation:

- predecessor condition must equal the last accepted current condition;
- sequence must advance exactly by one;
- primary lineage uses multiply-by-5 arithmetic;
- an independent accumulator reconstructs the same recurrence using LEA-based x5;
- the two results are compared after every accepted observation.

Sequence:

    NONE -> IDLE / FOREGROUND
    IDLE -> PROCESSING / FOREGROUND
    PROCESSING -> PROCESSING / BACKGROUND
    PROCESSING -> IDLE / FOREGROUND

The equal PROCESSING -> PROCESSING pair demonstrates that continuity is not defined
as a state change.

Runtime:

    MCSP condition continuity 0.49: CONDITIONAL PASS
    exit 0

Object SHA-256:

    cf145c98894c22b71f29d855d5e72b6322776a908b5e0ab1a658f94533dc0400

Executable SHA-256:

    e4b03a6255182cd26b0b935497d18f61d80f511e632f507573ac2e564c3c093c

## Adversarial evidence

Broken predecessor: REJECTED.
Skipped sequence: REJECTED.
Corrupted independent lineage accumulator: REJECTED.
Forced STATE introduction: REJECTED.
Forced TYPE introduction: REJECTED.
Forced release invocation: REJECTED.

64 additional executions: PASS.
Executable detachment-reference audit: ABSENT.

## Qualification

Condition continuity across four observations: VERIFIED within fixture.
Equal consecutive conditions as distinct calculations: VERIFIED.
Predecessor agreement: VERIFIED.
Exact sequence progression: VERIFIED.
Independent lineage reconstruction agreement: VERIFIED.
Manual terminal lineage constant as authority: REMOVED.
STATE promotion absence: VERIFIED within fixture.
TYPE promotion absence: VERIFIED within fixture.
Terminal release absence: VERIFIED.

General continuity algebra: UNVERIFIED.
Universal lineage formula: NOT CLAIMED.
Actual background execution: UNVERIFIED and intentionally absent.
Actual terminal release: UNVERIFIED and intentionally absent.
Cross-host behavior: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

Kernel remains DETERMINATE CONDITION.
STATE and TYPE remain derived and optional.
MODE remains derived.
C was not used.
