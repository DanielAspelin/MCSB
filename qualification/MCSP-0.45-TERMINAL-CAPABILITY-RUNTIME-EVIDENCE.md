# MCSP 0.45 Terminal Release Capability Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL CAPABILITY PASS

Tested checkpoint:

    4b7de2e04527588b357e25b6db862639c124b225

## Condition result

The foreground assembly witness calculated:

    TERMINAL_ATTACHED = 1
    TERMINAL_RELEASE_CAPABLE = 1
    TERMINAL_RELEASE_INVOKED = 0
    BACKGROUND_OPERATING = 0

These are condition determinations, not foundational states.

Runtime:

    MCSP terminal capability 0.45: CONDITIONAL PASS
    exit 0

Object SHA-256:

    835a951e5a8ef0c3af70aa352f2ed3d3c96392e91f95b3fe97d0f6711a832140

Executable SHA-256:

    7cd6663526a1686e25ad48dcb8b0aa95668afad2434ca39064b561dbb5036a48

## Capability calculation

Within the bounded Linux x86-64 realization, the fixture retains realization knowledge for process/session and descriptor mechanisms sufficient to construct a later terminal-release procedure.

The mechanism identities are treated as capability inputs only.

No release transition is performed.

## Non-invocation audit

Executable disassembly contains four syscall instructions because success and failure paths each contain write and exit.

The selected syscall paths are only:

    write = 1
    exit = 60

No fork, setsid, close or dup2 detachment path is selected or invoked.

The witness successfully writes its PASS result through inherited stdout before normal exit.

Therefore the test remains terminal-attached through completion.

## Qualification

Foreground terminal attachment: VERIFIED within fixture.
Terminal-release capability determination: VERIFIED within bounded Linux x86-64 model.
Release non-invocation: VERIFIED by runtime condition and executable audit.
Background operation non-invocation: VERIFIED.
Capability/action separation: VERIFIED within fixture.
Condition/state separation: ESTABLISHED architecturally; no STATE primitive introduced.

Actual terminal detachment: UNVERIFIED and intentionally not invoked.
Background continuation: UNVERIFIED and intentionally not invoked.
Recovery/control protocol for a detached task: UNVERIFIED.
Cross-host release capability: UNVERIFIED.
MCSP semantic/self-description closure: UNVERIFIED.

This is a Constructive qualified checkpoint, not authorization for automatic detachment.

C was not used.
Kernel remains DETERMINATE CONDITION.
STATE remains derived and optional.
