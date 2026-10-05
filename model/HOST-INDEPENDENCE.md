# MCSP Host-Independence Contract

MCSP semantics are independent of concrete hosts.

A host realization maps an MCSP construct to one or more mechanisms of an ISA, device, bus, firmware environment, protocol, operating environment or emulator.

## Invariants

- Host encoding does not define MCSP meaning.
- A host may realize one MCSP operation with zero, one or many native operations.
- Unsupported host capability is an explicit realization result.
- Architecture-specific registers, opcodes, descriptors and protocol fields remain realization data unless independently proven universal.
- Changing host must not change the semantic definition of a fundamental MCSP construct.

## Preservation requirement — 0.7

A realization is qualified only within a declared observation scope and constraints.

For every admitted mapped pre-state:
- normal completion must satisfy the MCSP post-state relations;
- forbidden observable side effects must not be introduced;
- required ordering and atomicity must be preserved;
- failures/exceptions must map to allowed MCSP outcomes;
- control/continuation requirements must be preserved;
- implementation-specific behavior must remain explicit.

Physical identity and instruction-count equality are not required.

A host may realize an MCSP construct using a single instruction, an instruction sequence, firmware/software assistance, emulation, or an explicit unsupported result.

## Initial realization witnesses

- x86-64
- AArch64
- RISC-V

Cross-domain witnesses include memory, NVMe/storage, PCIe/I/O, NIC/network, GPU/display and firmware/platform mechanisms.

## Qualification boundary

Host independence is not considered verified until representative mappings pass the PRESERVE test defined by the active MCSP foundation specification.
