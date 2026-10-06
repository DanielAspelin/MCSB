# MCSP 0.58 Controlled Device Interaction Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS WITH RESIDUE
Qualification class: Constructive isolated read-only device interaction

Source checkpoint:

    9129174152cca2dac83604356175a191855b4a14

## Authority and isolation

0.58 was executed only inside the disposable QEMU/KVM guest lineage established
by 0.57.

Host before run:

    mcsp_edu_058 loaded count = 0

Host after run:

    mcsp_edu_058 loaded count = 0

No host-kernel module insertion occurred.

## Device contract

Installed QEMU 10.0.13 EDU documentation defines:
- PCI identity 1234:11e8;
- BAR0 MMIO;
- offset 0x00 as read-only identification;
- value form 0xRRrr00edu.

MCSP pre-settled only the stable low-16-bit suffix 0x00ed. Version fields RR/rr
remained realization-defined observations.

## Static audit

Required external kernel mechanisms observed:

    ioread32
    pci_enable_device
    pci_iomap
    pci_iounmap
    pci_disable_device

Forbidden source/symbol audit found none of:
- iowrite/writeb/writew/writel;
- pci_set_master;
- request_irq / PCI IRQ allocation;
- dma_*.

Final module SHA-256:

    e33ec11467e2ce8a0f47f160f30407fca5b79f09a53a2bb3ee8c066d65d1218d

## Runtime evidence

Guest PCI enumeration:

    pci 0000:00:01.0: [1234:11e8]

MCSP assembly identity predicate:

    MCSP58_IDENTITY vendor=1234 device=11e8 predicate=1

Read-only BAR0 observation:

    MCSP58_OBSERVE bar=0 offset=0000 width=32 value=010000ed predicate=1

Module insertion:

    MCSP58_INSMOD_EXIT=0

The observed value 0x010000ed satisfies the bounded MCSP condition:

    observed_value & 0xffff == 0x00ed

QEMU exited normally after the bounded test. No kernel BUG/Oops/general-protection
or invalid-opcode evidence was observed in the captured filtered runtime log.

## Qualification residue

Kbuild/objtool emitted warnings for the hand-written assembly object:

    'naked' return found in MITIGATION_RETHUNK build
    missing int3 after ret

The bounded QEMU execution nevertheless completed correctly, but these warnings
remain an explicit compatibility/hardening residue. They prevent treating the
current assembly-to-kernel ABI form as production-naturalized.

Unsigned/out-of-tree module taint was also observed and retained as expected
experimental evidence.

## Qualification

QEMU EDU enumeration: VERIFIED.
MCSP assembly identity predicate in Linux probe: VERIFIED.
PCI function enable for bounded read: VERIFIED by successful path.
BAR0 mapping: VERIFIED by successful observation.
One 32-bit BAR0+0x00 read: VERIFIED.
Observed value 0x010000ed: VERIFIED.
MCSP assembly observation predicate: VERIFIED (1).
Stable 0x00ed suffix condition: VERIFIED.
Mapping release/device disable path: EXECUTED after accepted observation.
Host isolation: VERIFIED before/after.
Guest termination: VERIFIED.
No MMIO write/DMA/IRQ/bus-master mechanisms in adapter: VERIFIED static audit.

Assembly return-thunk/objtool compatibility: UNRESOLVED RESIDUE.
Signed module path: UNVERIFIED.
Arbitrary MMIO: UNVERIFIED.
DMA in Linux driver path: NOT PERFORMED.
IRQ operation: NOT PERFORMED.
Physical hardware: UNVERIFIED.
Production safety: UNVERIFIED.

MCSP remains its own kernel:

    MCSP KERNEL = DETERMINATE CONDITION

Linux remains the external realization kernel. The observed device register is
evidence consumed by an MCSP condition; it does not become semantic authority,
STATE, or TYPE.
