# MCSP 0.53 Linux Kernel Object Projection Qualification Plan

Build-only qualification. Do not load code into the running kernel.

Required:
- NASM emits ELF64 relocatable .o;
- ELF machine is x86-64;
- object type is REL;
- global callable symbol mcsp_exclusive_u64 exists;
- no _start symbol;
- no undefined userspace runtime symbols;
- no syscall instruction;
- no executable stack requirement;
- disassembly matches bounded exclusive relation;
- object can be consumed by an ordinary relocatable link step;
- inspect installed Linux kernel/Kbuild environment without modifying it.

Negative/audit checks:
- reject userspace entry assumptions;
- reject direct syscall presence;
- reject unexpected undefined symbols;
- preserve semantic boundary: ABI/register selection is realization-specific.

Loading/inserting a module is explicitly outside 0.53.
