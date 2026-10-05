# MCSP Machine Corpus — Constructive Specification 0.3

**Project:** Machine Construct Set Positional (MCSP)  
**Repository lineage:** MCSB  
**Status:** Constructive development  
**Qualification:** Pre-informative / Unverified  
**Origin:** Successor to the initial README specification; the originating README remains unchanged.

## Governing requirements

MCSP has two governing requirements:

1. **Host independence** — fundamental MCSP meaning must not depend on x86-64, AArch64, RISC-V, a particular operating system, firmware, bus, device, protocol, or vendor.
2. **Self-description closure** — MCSP must be able to formally describe its own constructs, definitions, relationships, semantics, encodings, execution rules, and host-realization rules using MCSP constructs.

External specifications are evidence and realization inputs. They do not define MCSP's universal semantics.

A proposed primitive is not accepted as host-independent merely because it appears on several hosts. A host mapping must preserve the primitive's meaning without changing that meaning.

Self-description has not closed while an undefined external language is required to explain the formal meaning of MCSP itself.

## Objective

Develop MCSP from real machine specifications, beginning with assembly-visible computation and progressively decomposing all relevant hardware mechanisms. MCSP does not assume every hardware operation is a CPU opcode. It models instructions together with registers, memory, addresses, queues, descriptors, MMIO/port I/O, DMA, interrupts, firmware interfaces, protocols, devices, links and state.

The working question is:

> What is the smallest host-independent machine construct vocabulary capable of describing computation, its own definition, and its realization on different processors and hardware domains?

## Architectural layers

    MCSP self-description
        -> host-independent construct semantics
            -> realization mapping
                -> ISA / bus / device / protocol / firmware
                    -> concrete machine

Human syntax and binary encoding are projections/realizations and are not the semantic foundation.

## Initial architecture set

- x86-64 / Intel 64 and AMD64
- AArch64 / A64
- RISC-V

Additional architectures are admitted through explicit mappings rather than by silently generalizing one ISA.

## Hardware domains

### Processor
Instructions; operands; general, vector, control and system registers; execution state; privilege; exceptions; interrupts; atomics; synchronization; timers; virtualization; encoding.

### Memory
Physical and virtual addresses; regions; blocks; pages; loads; stores; allocation; release; translation; protection; attributes; ordering; barriers; caches; coherency; atomics; DMA-visible memory; persistent/nonvolatile memory where applicable.

### Storage
Blocks; sectors/logical blocks; namespaces; queues; command descriptors; read/write; flush; completion; persistence; DMA; controller registers; interrupts; removable and embedded storage. Initial concrete model: NVMe/NVM command set, with ATA/SATA, SCSI and SD-family mappings staged.

### Graphics / compute acceleration
GPU-visible memory; command buffers; command queues; shaders/kernels; synchronization; compute and graphics execution; images/textures/buffers; accelerator-local state. GPU computation remains distinct from physical display output.

### Display
Framebuffer/scanout state; display controller; timing; pixel formats; connectors/links; display identification; device commands; brightness/power/control. Display output is modeled independently of GPU execution.

### Network
NIC registers; MMIO; DMA; TX/RX descriptors and rings; queues; interrupts/MSI-X; link frames; MAC addressing; Ethernet; IPv4/IPv6; ARP/NDP; ICMP; UDP; TCP; DHCP; DNS; routing; multicast; configuration; sockets/API projections; wireless and cellular link realization where applicable.

Conceptual transmit path:

    instruction
      -> memory
      -> descriptor
      -> allocate/map
      -> queue/schedule
      -> DMA/transfer
      -> NIC
      -> frame
      -> packet
      -> transport
      -> link
      -> remote host

Receive is the corresponding inbound state-transfer path.

### Bus / interconnect / I/O
PCI Express; MMIO; port I/O where applicable; DMA; enumeration; configuration space; interrupts; MSI/MSI-X; device registers; queue/doorbell mechanisms; USB; serial buses; on-board interconnects.

### Firmware / platform / boot
Reset; initialization; boot; firmware interfaces; hardware discovery; power states; platform configuration; UEFI; ACPI; device trees where applicable; timers; clocks; watchdogs; secure/verified boot mechanisms as realization features.

### Input
Keyboard; pointer; touch; HID; game/input controllers; buttons; digitizers and other human-interface sources.

### Audio
PCM/sample representation; buffers; streams; clocks; codecs; capture; playback; DMA; device control; digital audio links.

### Camera / imaging
Sensors; pixel formats; buffers; capture queues; control; timing; DMA; image-processing accelerators.

### Sensors / positioning
Accelerometer; gyroscope; magnetometer; environmental sensors; GNSS; timing and location measurements; sensor buses.

### Wireless / radio
Wi-Fi; Bluetooth; cellular; NFC/RFID where machine-accessible; radio control/data paths. Protocol layers remain distinguishable from physical-radio realization.

### Power / thermal / clock
Power states; voltage/frequency control; thermal state; sleep/wake; clocks; timers; counters; energy/resource constraints.

### Security hardware
Privilege mechanisms; memory protection; IOMMU; trusted/secure execution features; cryptographic accelerators; entropy/random-number hardware; device isolation. Host-specific trust models are mappings, not universal MCSP assumptions.

### Virtualization
CPU virtualization; virtual memory; virtual devices; emulation; paravirtual interfaces; IOMMU/device assignment; nested machine realization.

### Peripheral / embedded I/O
UART; SPI; I2C/I3C; GPIO; PWM; CAN and other machine-facing peripheral mechanisms as evidence becomes available.

## Candidate primitive vocabulary

Candidates, not yet a closed universal set:

- construct
- definition
- identity
- relation
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
- unmap
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
- interface
- link
- host
- realization

## Fundamental separation

    syntax       = representation for humans/tools
    semantics    = host-independent meaning/state transition
    encoding     = concrete representation
    position     = relationship/location within a construct space
    allocation   = placement/resource assignment
    scheduling   = temporal/order assignment
    execution    = performance of an operation
    transfer     = movement of state/data
    realization  = mapping semantics to concrete machinery
    host         = concrete realization environment

Allocation does not imply execution. Scheduling does not imply placement. Encoding does not define semantics. A write is an operation; the resulting mutation is a state transition. A protocol is not automatically a primitive merely because a host uses it.

## Self-description model

Every MCSP construct must ultimately be expressible as MCSP data/constructs with at least:

    construct
      identity
      definition
      relations
      operands/inputs
      results/outputs
      pre-state
      transition
      post-state
      ordering
      representation
      realization constraints

MCSP must be able to represent this schema using the same construct system it defines.

### Closure test

For each candidate primitive:

1. Define it using current MCSP constructs.
2. Represent that definition in MCSP.
3. Represent its relationships and execution/state rules in MCSP.
4. Represent host mappings in MCSP.
5. Determine whether an undefined external semantic primitive remains.
6. If one remains, expose it as a candidate primitive or revise the model.
7. Repeat until finite closure or a demonstrated obstruction is reached.

Natural-language documentation may explain MCSP, but must not be the sole carrier of formal semantics.

## Host-independence test

For every fundamental construct:

1. map it to x86-64 where applicable;
2. map it to AArch64 where applicable;
3. map it to RISC-V where applicable;
4. map it to relevant device/protocol realizations;
5. identify architecture-specific residue;
6. move residue into the realization layer;
7. reject or refine any alleged universal whose semantics change between mappings.

Absence of a native host operation is permitted: a realization may require multiple instructions, firmware, software, emulation, or may report unsupported capability. The MCSP meaning itself remains stable.

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

This is evidence to test, not yet a universal law.

## Specification corpus — authoritative-source families

The corpus records source, version, licensing/access conditions, extracted machine concepts and MCSP mappings. Specification text is referenced and modeled rather than copied wholesale.

### Processor / ISA
- Intel 64 and IA-32 Software Developer Manuals: https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
- AMD64 architecture documentation: https://www.amd.com/en/search/documentation/hub.html
- Arm A-profile architecture: https://www.arm.com/architecture/learn-the-architecture/a-profile
- RISC-V specifications: https://docs.riscv.org/

### Storage
- NVM Express specifications: https://nvmexpress.org/specifications/
- NVMe Base Specification: https://nvmexpress.org/specification/nvm-express-base-specification/
- NVM Command Set: https://nvmexpress.org/specification/nvm-command-set-specification/
- NVMe over PCIe: https://nvmexpress.org/specification/nvme-over-pcie-transport-specification/
- NVMe over TCP: https://nvmexpress.org/specification/tcp-transport-specification/

### Bus / I/O
- PCI Express specification index: https://pcisig.com/specification-overview/pci-express-base
- USB specifications: https://www.usb.org/documents

### Firmware / platform
- UEFI and ACPI specifications: https://uefi.org/specifications

### Graphics / compute
- Vulkan specification: https://registry.khronos.org/vulkan/specs/latest/html/vkspec.html

### Network / Internet
- IPv4: RFC 791
- IPv6: RFC 8200
- ARP: RFC 826
- ICMPv4: RFC 792
- ICMPv6 / NDP family: RFC 4443, RFC 4861
- UDP: RFC 768
- TCP: RFC 9293
- DHCPv4: RFC 2131
- DHCPv6: RFC 8415
- DNS concepts/implementation baseline: RFC 1034, RFC 1035
- RFC corpus: https://www.rfc-editor.org/

Ethernet/Wi-Fi/Bluetooth/cellular and device-family specifications will be mapped from their respective standards bodies subject to availability and licensing.

## Decomposition record

For every architecture/domain entry record:

1. construct identity;
2. source provenance and version;
3. architectural layer;
4. inputs/operands;
5. outputs/results;
6. addressing/position;
7. binary/register/descriptor representation;
8. pre-state;
9. transition;
10. post-state;
11. ordering/scheduling constraints;
12. memory/storage effects;
13. synchronization/completion;
14. exception/error behavior;
15. privilege/security constraints;
16. concurrency/atomicity;
17. persistence/durability where relevant;
18. host-specific constraints;
19. MCSP primitive mapping;
20. unresolved semantic residue;
21. self-description status.

## Development sequence

1. Processor: x86-64, AArch64, RISC-V instruction/register/state decomposition.
2. Memory: addressing, load/store, pages, translation, ordering, atomics and caches.
3. Exceptions, interrupts, timers and synchronization.
4. PCIe/MMIO/DMA/IOMMU.
5. Storage: NVMe block read/write/completion path, then additional storage families.
6. Network: NIC TX/RX then Ethernet/IP/ICMP/UDP/TCP and configuration/name-resolution layers.
7. GPU/accelerator execution.
8. Display output/control.
9. Firmware/boot/platform/power.
10. USB and human input.
11. Audio, camera and sensors.
12. Wireless/radio and positioning.
13. Embedded/peripheral buses.
14. Virtualization and security hardware.
15. Cross-domain reduction of primitives.
16. Encode MCSP definitions in MCSP.
17. Execute the self-description closure test.
18. Build and test host realization mappings.

## Qualification boundary

This specification establishes development topology and governing invariants. It does not yet establish semantic equivalence among ISAs, universal primitive closure, complete hardware coverage, executable self-description, or production qualification.

Current qualification: **Under Constructive Development / Unverified**.

A future Constructive Seal requires at minimum reproducible source provenance, formal construct definitions, cross-host mappings, a machine-readable self-description representation, closure testing, and contradiction tracking.
