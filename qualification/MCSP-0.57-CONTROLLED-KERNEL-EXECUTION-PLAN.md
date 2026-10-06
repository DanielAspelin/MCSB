# MCSP 0.57 Controlled Kernel Execution Qualification Plan

Isolation first.

- Build 0.56 module for the selected guest kernel.
- Construct a disposable initramfs with the module and minimal insertion helper.
- Boot QEMU with -device edu and serial console.
- Insert module inside guest only.
- Capture PCI enumeration and module/probe evidence.
- Terminate the guest after the test.
- Verify host lsmod/proc/modules never contains the fixture.

PASS requires isolated guest execution evidence and an unchanged host module state.
No MMIO, DMA, IRQ setup or hardware mutation is authorized by this checkpoint.
