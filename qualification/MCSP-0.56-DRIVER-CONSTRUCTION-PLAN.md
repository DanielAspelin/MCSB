# MCSP 0.56 Driver Construction Fixture Qualification Plan

Build-only fixture. Do not load or bind the module.

Required:
- MCSP report-derived assembly predicate recognizes only QEMU EDU 1234:11e8;
- Linux PCI adapter declares the same identity;
- Kbuild invokes NASM for the MCSP component;
- MODPOST and final .ko link complete;
- .ko contains mcsp_edu_identity_match;
- .modinfo contains PCI alias for 1234:11e8;
- disassembly preserves the two identity comparisons;
- no MCSP/userspace _start;
- static audit finds no MMIO/DMA/IRQ setup calls in the adapter;
- no insmod/modprobe or device binding occurs.

Negative construction checks:
- mismatched vendor/device predicate inputs reject;
- source/report identity mismatch is a qualification failure;
- semantic mutation, forced STATE/TYPE remain forbidden by parent report contract.

Runtime PCI probing, DMA and hardware mutation remain outside 0.56.
