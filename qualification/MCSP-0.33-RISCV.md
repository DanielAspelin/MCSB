# MCSP RISC-V Lineage Qualification 0.33

Status: Experimental cross-ISA realization
Qualification: Under Conditional Experiment pending runtime

Primary artifact:

    assembly/riscv64/gas/mcsp_lineage.s

Semantic contract:

    model/LINEAGE-NORMAL-FORM-0.31.mcsp

The RV64 witness is independently authored against the normalized lineage obligations and targets:

    0x0f646d0bb5be8531

RISC-V registers, instructions, assembler syntax, ELF details and Linux syscall ABI are realization details, not MCSP semantic authority.

Runtime qualification requires assembly, link, RV64 execution and successful projection validation.

C is not required.
Kernel remains DETERMINATE CONDITION.
