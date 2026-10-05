# MCSP Machine Corpus — Constructive Specification 0.2

**Project:** Machine Construct Set Positional (MCSP)  
**Repository lineage:** MCSB  
**Status:** Constructive development  
**Qualification:** Pre-informative / Unverified  
**Origin:** Successor to the initial README specification; the originating README remains unchanged.

## Objective

Develop MCSP from real machine specifications, beginning with assembly-visible computation and progressively decomposing the hardware mechanisms around it. MCSP does not assume that every hardware operation is a CPU opcode. It models instructions together with registers, memory, addresses, queues, descriptors, MMIO/port I/O, DMA, interrupts, firmware interfaces, protocols and device state.

The working question is:

> What is the smallest machine construct vocabulary capable of describing computation across different processors and hardware domains while preserving host-specific behavior?

## Initial architecture set

- x86-64 / Intel 64 and AMD64
- AArch64 / A64
- RISC-V

Additional architectures are admitted only through explicit mappings rather than by silently generalizing one ISA.

## Hardware domains

### Processor
Instructions; operands; general, vector, control and system registers; execution state; privilege; exceptions; interrupts; atomics; synchronization; timers; virtualization; encoding.

### Memory
Physical and virtual addresses; regions; blocks; pages; loads; stores; allocation; release; translation; protection; attributes; ordering; barriers; caches; coherency; atomics; DMA-visible memory.

### Storage
Blocks; namespaces; queues; command descriptors; read/write; flush; completion; persistence; DMA; controller registers; interrupts. Initial concrete model: NVMe/NVM command set.

### Graphics and display
GPU-visible memory; command buffers/queues; synchronization; compute/graphics execution; framebuffer/image state; scanout/display controller; display links and device commands. GPU execution and physical display output remain distinct domains.

### Network
NIC registers; MMIO; DMA; TX/RX descriptor rings; queues; interrupts/MSI-X; link frames; MAC addressing; IPv4/IPv6; ICMP; UDP; TCP; address resolution; routing; configuration; and higher protocol projections where needed.

Conceptual transmit path:

    CPU instruction
      -> memory
      -> descriptor
      -> allocation
      -> queue/schedule
      -> DMA
      -> NIC
      -> frame
      -> packet
      -> transport
      -> remote machine

Receive is the corresponding inbound state-transfer path.

### Bus and I/O
PCI Express; MMIO; port I/O where applicable; DMA; enumeration; configuration space; interrupts; device registers; queue/doorbell mechanisms.

### Firmware and platform
Reset; boot; firmware interfaces; hardware discovery; power state; platform configuration; UEFI; ACPI; timers.

### Peripheral domains
USB; serial/UART; SPI; I2C/I3C; GPIO; audio; input; camera; sensors; Bluetooth; Wi-Fi; cellular; GNSS; accelerators. These are staged corpus targets and are not yet claimed as decomposed.

## Candidate primitive vocabulary

The following are candidates, not yet a closed universal set:

- construct
- identity
- position
- address
- width
- value
- block
- page
- region
- register
- instruction
- operand
- encoding
- state
- transition
- read
- write
- allocate
- release
- map
- translate
- queue
- descriptor
- schedule
- execute
- wait
- signal
- synchronize
- interrupt
- exception
- transfer
- route
- frame
- packet
- command
- completion
- device
- host

## Fundamental separation

MCSP currently distinguishes:

    syntax       = representation
    semantics    = meaning/state transition
    encoding     = binary or machine realization
    allocation   = placement/resource assignment
    scheduling   = temporal/order assignment
    execution    = performance of an operation
    transfer     = movement of state/data
    host         = concrete realization environment

Allocation does not imply execution. Scheduling does not imply authority or placement. A write is an operation; the resulting mutation is a state transition.

## Cross-domain hypothesis

A provisional recurring pattern is:

    identify
      -> position/address
      -> allocate/map
      -> read/write/transfer
      -> queue/schedule
      -> execute
      -> signal/complete
      -> observe state
      -> release/reuse

This is a hypothesis to test against each architecture and hardware domain, not a universal claim.

## Specification corpus — initial authoritative sources

### Processor / ISA
- Intel 64 and IA-32 Software Developer Manuals: https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
- Arm A-profile architecture material: https://www.arm.com/architecture/learn-the-architecture/a-profile
- RISC-V ratified specifications: https://docs.riscv.org/

### Storage
- NVM Express specifications: https://nvmexpress.org/specifications/
- NVMe Base Specification: https://nvmexpress.org/specification/nvm-express-base-specification/
- NVM Command Set: https://nvmexpress.org/specification/nvm-command-set-specification/
- NVMe over PCIe: https://nvmexpress.org/specification/nvme-over-pcie-transport-specification/
- NVMe over TCP: https://nvmexpress.org/specification/tcp-transport-specification/

### Bus / I/O
- PCI Express Base specification index: https://pcisig.com/specification-overview/pci-express-base

### Networking
- IPv6, RFC 8200: https://www.rfc-editor.org/rfc/rfc8200.html
- TCP, RFC 9293: https://www.rfc-editor.org/rfc/rfc9293.html
- UDP, RFC 768: https://www.rfc-editor.org/rfc/rfc768.html

The corpus will expand with authoritative specifications for Ethernet, IPv4, ICMP, ARP/NDP, DHCP, DNS, USB, graphics/display, firmware/platform and peripheral domains.

## Decomposition method

For every architecture/domain entry record:

1. construct identity;
2. specification provenance and version;
3. architectural layer;
4. inputs/operands;
5. outputs/results;
6. addressing/position;
7. binary/register/descriptor representation;
8. state before and after;
9. ordering/scheduling constraints;
10. memory effects;
11. synchronization/completion;
12. exception/error behavior;
13. host-specific constraints;
14. mapping to candidate MCSP primitives.

Specification text is referenced and modeled, not indiscriminately copied. Licensing and access restrictions remain attached to source provenance.

## First implementation sequence

1. Processor: x86-64, AArch64, RISC-V.
2. Memory semantics and addressing across all three.
3. Interrupts, exceptions, atomics and ordering.
4. PCIe/MMIO/DMA.
5. NVMe block read/write path.
6. NIC transmit/receive path and Ethernet/IP/UDP/TCP decomposition.
7. GPU/display path.
8. Firmware/boot/platform.
9. Peripheral families.
10. Compare all decompositions and reduce the primitive vocabulary.

## Qualification boundary

This document establishes the development topology only. It does not yet establish semantic equivalence among ISAs, universal primitives, complete hardware coverage, or production qualification. Each such conclusion requires evidence and architecture-specific testing.
