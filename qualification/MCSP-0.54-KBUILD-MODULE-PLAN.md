# MCSP 0.54 Kbuild Module Integration Qualification Plan

Build only. Do not load the module.

Required evidence:
1. matching Linux Kbuild tree exists;
2. Kbuild compiles the minimal Linux adapter;
3. Kbuild invokes NASM for the MCSP object;
4. modpost completes;
5. mcsp_probe.ko is produced;
6. .ko is ELF64 x86-64;
7. mcsp_exclusive_u64 is linked into the module;
8. module metadata is inspectable;
9. no _start symbol exists;
10. no insmod/modprobe is executed.

Static audit:
- inspect file/readelf/nm/modinfo;
- inspect relocations and disassembly around MCSP symbol;
- record artifact digest.

This does not qualify runtime module loading or kernel execution.
