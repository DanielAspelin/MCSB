# MCSP 0.35 Emulated DMA Runtime Evidence

Qualification date: 2026-10-05
Result: BOUNDED EMULATED DMA PASS

## Tested checkpoint

    d773659f1638a0e1c44aff83e86bbadc90b4885d

Witness:

    assembly/x86_64/nasm/mcsp_edu_dma_boot.asm

Mechanism:

    freestanding BIOS boot sector
    -> x86 protected mode
    -> PCI configuration
    -> QEMU EDU MMIO DMA engine
    -> EDU internal buffer
    -> DMA write to distinct guest RAM destination
    -> CPU post-completion comparison only

No guest OS, C runtime, disk filesystem, network, or host physical-device passthrough was used.

## Device interface basis

The installed QEMU EDU specification documents:
- PCI ID 1234:11e8;
- BAR0 MMIO region;
- DMA source at 0x80;
- DMA destination at 0x88;
- DMA count at 0x90;
- DMA command at 0x98;
- command bit 0 starts transfer;
- command bit 1 selects EDU-to-RAM direction;
- a 4096-byte EDU buffer exists at device offset 0x40000.

## Experiment

The guest:
1. initialized source RAM at 0x10000 with a known 8-byte payload;
2. initialized destination RAM at 0x11000 to zero;
3. configured EDU at PCI 00:04.0 with BAR0 0xe0000000 and enabled memory/bus-master operation;
4. commanded DMA from guest RAM 0x10000 to EDU buffer 0x40000;
5. waited for device completion;
6. commanded DMA from EDU buffer 0x40000 to guest RAM 0x11000;
7. waited for device completion;
8. compared source and destination only after both DMA operations;
9. emitted PASS only on equality.

CPU code did not copy the source payload into destination RAM.

## Observed result

Boot image SHA-256:

    cb982961653d1cce5d1a480f67d4b7345879ac9096441d479b8266cb83102d2e

Serial output:

    MCSP EDU DMA 0.35: CONDITIONAL PASS

QEMU debug-exit status:

    33

For isa-debug-exit with guest value 0x10, status 33 is the expected successful harness termination.

Final harness result:

    EMULATED_DMA_EXECUTION=PASS

## Failed preliminary harness attempt

Checkpoint cc18877754d4ac500fe747ed97f1b77f01c437ca produced the semantic PASS message but the initial debug-exit port 0xf4 did not terminate QEMU; the wrapper timed out with status 124.

That run was not promoted to qualification PASS.

Successor d773659f1638a0e1c44aff83e86bbadc90b4885d moved only the harness debug-exit port to 0x501 and requalified the complete run.

## Qualification

DMA semantic projection: VERIFIED within fixture scope.
QEMU EDU emulated DMA realization: VERIFIED within 0.35 fixture scope.
Observed device-mediated destination mutation: VERIFIED within experiment.
Harness termination: VERIFIED.
Physical DMA hardware: UNVERIFIED.
Native IOMMU/cache-coherency behavior: UNVERIFIED.
Universal non-CPU hardware independence: UNVERIFIED.

This is stronger than the 0.34 CPU validator because the destination data was produced through the emulated PCI device's DMA mechanism.

C was not used.
Kernel remains DETERMINATE CONDITION.
