# MCSP 0.57 Controlled Kernel Execution Runtime Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS
Qualification class: Constructive isolated in-kernel execution checkpoint

Final runtime instrumentation checkpoint:

    50147f724418c62830f55d4d4356a285ccd24541

## Preserved experimental lineage

Initial disposable QEMU boots successfully enumerated QEMU EDU as 1234:11e8 but
Debian initramfs did not dispatch the first local-bottom/local-premount test hooks
before root discovery. Those attempts are unqualified harness experiments.

No host module was loaded during those attempts.

The final fixture replaced only the disposable guest /init with a minimal
qualification harness, eliminating initramfs-framework ambiguity.

## Isolation

Host before final run:

    mcsp_edu_057 loaded count = 0

Runtime:
- QEMU 10.0.13;
- KVM acceleration;
- q35 machine;
- Debian Linux 6.12.111+deb13-amd64;
- disposable reconstructed initramfs;
- QEMU EDU device;
- no persistent guest disk.

Host after final run:

    mcsp_edu_057 loaded count = 0

Therefore module insertion occurred only in the disposable guest.

## Guest evidence

PCI enumeration:

    pci 0000:00:01.0: [1234:11e8]

Guest module insertion:

    MCSP57_INSMOD_EXIT=0

Explicit probe trace:

    MCSP57_PROBE vendor=1234 device=11e8 predicate=1

This trace demonstrates that the Linux PCI probe invoked the assembly-owned
mcsp_edu_identity_match predicate and that the predicate accepted the report-derived
QEMU EDU identity.

The guest also reported:

    loading out-of-tree module taints kernel
    module verification failed: signature and/or required key missing - tainting kernel

This is expected evidence for the unsigned experimental module. It is not hidden
or treated as production qualification.

Guest terminated after the bounded test.

Final module SHA-256:

    a60260c418c73d696d51e6f97173725e8a079813c17374434b9293a5e1c3ac4c

## Qualification

Disposable guest kernel boot: VERIFIED.
QEMU EDU PCI enumeration 1234:11e8: VERIFIED.
Module insertion inside guest: VERIFIED.
Linux PCI probe execution: VERIFIED.
MCSP assembly predicate participation: VERIFIED.
Predicate result for bounded EDU identity: VERIFIED (1).
Host kernel isolation: VERIFIED before/after.
Guest termination after test: VERIFIED.
Unsigned/out-of-tree taint observation: VERIFIED and retained.

MMIO access: NOT PERFORMED.
DMA operation: NOT PERFORMED.
IRQ registration/handling: NOT PERFORMED.
Device mutation: NOT PERFORMED.
Host kernel insertion: NOT PERFORMED.
Signed-module production path: UNVERIFIED.
Unload/rebind/recovery behavior: UNVERIFIED.
Production safety: UNVERIFIED.

MCSP remains its own kernel:

    MCSP KERNEL = DETERMINATE CONDITION

Linux is the external realization kernel used by this bounded execution fixture.
