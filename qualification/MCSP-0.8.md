# MCSP 0.9 C Bootstrap Qualification

**State:** Under Conditional Experiment

## Transversion

MCSP 0.8 used `tools/mcsp-closure.js` as an experimental JavaScript/Node.js closure evaluator.

MCSP 0.9 establishes `tools/mcsp-closure.c` as the canonical bootstrap evaluator.

The 0.8 JavaScript implementation remains recoverable through Git history but is removed from the active source tree. JavaScript/Node.js is no longer an MCSP bootstrap dependency.

## Boundaries

C is an implementation carrier only. C syntax, types, memory model and compiler behavior do not define MCSP semantics.

Assembly realization boundaries are explicitly separate:

- ISA semantics;
- Netwide Assembler (NASM) realization where applicable;
- GNU assembler (GAS) realization where applicable;
- concrete machine encoding.

NASM and GAS are not treated as interchangeable semantic authorities.

## C evaluator behavior

The C evaluator:
- contains the admitted bootstrap dependency graph explicitly;
- verifies every foundation node has a definition;
- rejects unresolved dependency names;
- traverses recursive dependencies;
- records explicit cycles;
- verifies every foundation node is reached;
- emits deterministic PASS/FAIL JSON-like output;
- exits 0 on structural bootstrap PASS and nonzero on failure.

It requires only a conforming C implementation plus the standard headers used by the source. No Node.js or external JSON library is required.

## Build qualification command

A later runtime environment should build with strict diagnostics, for example:

    cc -std=c11 -Wall -Wextra -Wpedantic -Werror -O2 \
      -o mcsp-closure tools/mcsp-closure.c

Then execute:

    ./mcsp-closure

Expected qualification:
- compiler exit 0;
- evaluator exit 0;
- `"result": "PASS"`;
- no unresolved dependency diagnostics.

## Current qualification

Repository transversion: PASS.

C source construction: complete.

Runtime C compilation/execution: not yet asserted in this repository-only operation.

Systemd-container qualification: intentionally deferred until separately requested.

## Recovery

The JavaScript 0.8 implementation is retained in Git history. Reversion is possible through repository lineage without retaining JavaScript in the current working tree.
