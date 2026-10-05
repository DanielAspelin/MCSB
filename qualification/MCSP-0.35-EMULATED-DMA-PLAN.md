# MCSP 0.35 Emulated DMA Qualification Plan

Status: Pre-runtime qualification plan
Qualification: Unverified

Environment discovery on espoo02 established:

- qemu-system-x86_64 10.0.13 is present;
- QEMU exposes the PCI EDU device;
- the EDU device exposes a configurable DMA mask;
- no host physical-device passthrough is required for the planned experiment.

Selected boundary:

    freestanding guest -> PCI EDU MMIO/DMA engine -> guest memory -> observed completion/projection

No guest OS or C runtime is required by the architecture.

Before PASS may be recorded, the implementation must demonstrate that destination memory changed through the EDU DMA operation rather than a CPU copy and that the observed projection satisfies the inherited 0.34 transfer pre-settlement.

Physical DMA remains outside this checkpoint.
