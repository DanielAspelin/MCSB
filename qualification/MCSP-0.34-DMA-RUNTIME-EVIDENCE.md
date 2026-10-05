# MCSP 0.34 DMA Projection Runtime Evidence

Qualification date: 2026-10-05
Checkpoint: 0.34
Result: BOUNDED DMA SEMANTIC-PROJECTION PASS

Source checkpoint tested:

    d07f5b045ed8e3c4a5cc5b4c2b6e61220189d994

Contract:

    model/DMA-TRANSFER-PROJECTION-0.34.mcsp

Validator:

    assembly/x86_64/nasm/mcsp_dma_projection.asm

Observed output:

    MCSP DMA projection 0.34: CONDITIONAL PASS

Exit status:

    0

Object SHA-256:

    45e591fe2e52e1c73637a7b9bfc9005e110c18b80ef1acc812c1bb1983995b55

Executable SHA-256:

    636206eeffe636555e03fd5a8576d1c9d3403993a33486dd2762f6c1ae69e2cb

## Tested material failures

The validator rejects:
- wrong material provenance despite identical payload;
- wrong extent;
- declared failure;
- forbidden effect.

The valid fixture preserves source role, destination role, extent, payload distinction, material provenance, completion, failure state, and forbidden-effect condition.

## Qualification boundary

DMA semantic projection contract: VERIFIED within fixture scope.
Assembly validator runtime: VERIFIED on tested x86-64 environment.
Physical DMA transfer: UNVERIFIED.
DMA controller descriptor compatibility: UNVERIFIED.
Bus/IOMMU/cache-coherency behavior: UNVERIFIED.
General non-CPU hardware independence: UNVERIFIED.

This checkpoint deliberately does not represent CPU execution of the validator as physical DMA evidence.

The result strengthens the semantic architecture by demonstrating that the preservation contract can be expressed without making a CPU instruction sequence part of the transfer invariant.

Next evidence should bind the projection to an actual or emulated DMA mechanism with explicit descriptor, completion, and failure observations.

C was not used.
Kernel remains DETERMINATE CONDITION.
