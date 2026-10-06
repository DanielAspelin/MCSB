# MCSP 0.47 Semantic Dimensional Minimization Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS
Qualification class: Constructive semantic-safety checkpoint

Tested checkpoint:

    ee408342167114d1f84f1e7259ec7bc58461752e

## Baseline

    CONDITION = PROCESSING
    MODE = FOREGROUND
    CONDITION_SUFFICIENT = 1
    MODE_SUFFICIENT = 1
    STATE_INTRODUCED = 0
    TYPE_INTRODUCED = 0

Runtime:

    MCSP dimensional minimization 0.47: CONDITIONAL PASS
    exit 0

Object SHA-256:

    7edeb5f68ada9628c029a988e500b9993f1a3e09fd56732a04d617c971a431e5

Executable SHA-256:

    61340df9158468a7902a411e493f677cbf950f790962c823394c558193f9af50

## Coverage

Foreground mode with PROCESSING condition: PASS.

The same PROCESSING condition with MODE changed to BACKGROUND: PASS.
No TYPE was required by the bounded witness.

Forced STATE introduction while CONDITION remained sufficient: REJECTED, exit 1.

Forced TYPE introduction while MODE remained sufficient: REJECTED, exit 1.

The baseline executable was run 64 additional times. Repeated processing remained
successful and did not create an automatic promotion path.

Executable audit found no fork, setsid, dup2, daemon or equivalent terminal
detachment reference.

## Qualification

CONDITION-before-STATE minimization: VERIFIED within fixture.
MODE-before-TYPE minimization: VERIFIED within fixture.
FOREGROUND/BACKGROUND distinction without TYPE: VERIFIED within fixture.
Forced STATE promotion rejection: VERIFIED.
Forced TYPE promotion rejection: VERIFIED.
Repeated processing without promotion: VERIFIED for 64 repeated executions.
Terminal detachment absence: VERIFIED in executable audit.

Universal dispensability of STATE: NOT CLAIMED.
Universal dispensability of TYPE: NOT CLAIMED.
General mode taxonomy: UNVERIFIED.
Cross-host realization: UNVERIFIED.
Semantic/self-description closure: UNVERIFIED.

The stronger dimensions remain available only as future candidates if explicit
qualified evidence demonstrates that the weaker dimension cannot preserve a
material distinction.

Kernel remains DETERMINATE CONDITION.
STATE remains derived and optional.
TYPE remains derived and optional.
MODE is derived above the kernel.
C was not used.
