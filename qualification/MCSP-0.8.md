# MCSP 0.8 Qualification

**State:** Under Conditional Experiment

## Implemented evidence

MCSP 0.8 introduces:
- `model/foundation-0.8.json`: machine-readable bootstrap graph;
- `tools/mcsp-closure.js`: deterministic Node.js closure evaluator.

The JSON format is explicitly a **bootstrap carrier**. It is not claimed to be the eventual MCSP-native encoding.

## Evaluator gates

The evaluator fails when:
- a foundation node lacks a definition;
- a dependency is not present in the admitted graph;
- dependency data is malformed;
- a required foundation node cannot be traversed.

Explicit cycles are recorded rather than treated automatically as failure because MCSP permits mutually recursive graph definitions when their interpretation is itself closed.

## Repository-level static qualification

The committed 0.8 graph contains:
- 17 foundation nodes;
- 17 foundation definitions;
- 26 derived definitions;
- 0 unresolved external dependency names.

This is a static graph-integrity PASS.

## Runtime qualification

A runtime execution of:

    node tools/mcsp-closure.js model/foundation-0.8.json

must return exit status 0 and a report with `"result": "PASS"` before runtime structural closure is qualified.

Runtime execution has not been asserted merely from repository construction.

## Future systemd-container qualification

A later, separately authorized qualification stage should execute the same evaluator inside one of the user's systemd containers.

That future test should preserve:
- repository commit/SHA under test;
- Node.js/runtime version;
- container OS/image identity;
- exact command and exit status;
- stdout report;
- dependency/runtime failures;
- host architecture;
- reconstruction instructions.

Container success will be evidence of reproducible realization, not by itself proof of semantic self-description.

## Next

After runtime structural closure passes, add host realization records and exercise PRESERVE for representative COPY, READ, WRITE, ADD and BRANCH mappings across x86-64, AArch64 and RISC-V.
