# MCSP Host-Independence Contract

MCSP semantics are independent of concrete hosts.

A host realization maps an MCSP construct to one or more mechanisms of an ISA, device, bus, firmware environment, protocol, operating environment or emulator.

## Invariants

- Host encoding does not define MCSP meaning.
- A host may realize one MCSP operation with zero, one or many native operations.
- Unsupported host capability is an explicit realization result.
- Architecture-specific registers, opcodes, descriptors and protocol fields remain realization data unless independently proven universal.
- Changing host must not change the semantic definition of a fundamental MCSP construct.

## Initial realization witnesses

- x86-64
- AArch64
- RISC-V

Cross-domain witnesses include memory, NVMe/storage, PCIe/I/O, NIC/network, GPU/display and firmware/platform mechanisms.
