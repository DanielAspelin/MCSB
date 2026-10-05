# MCSP Corpus

This directory is the evidence-to-construct workspace for MCSP.

Each corpus family decomposes authoritative machine specifications into candidate MCSP constructs. Source-specific names remain provenance; they do not automatically become universal MCSP primitives.

## Families

- processor — ISA instructions, registers, state and execution
- memory — addressing, blocks/pages, translation, ordering and coherency
- storage — persistent block/device command models
- network — NIC through link/network/transport protocols
- graphics — GPU/accelerator execution
- display — scanout, display links and device control
- bus — PCIe, USB, MMIO, DMA and machine interconnect
- firmware — boot, discovery, ACPI/UEFI/platform interfaces
- input — HID and human input
- audio — capture/playback, streams and codecs
- imaging — camera/image capture
- sensors — sensor and positioning devices
- radio — Wi-Fi, Bluetooth, cellular and other radio links
- power — power, thermal, clocks and timers
- security — protection, IOMMU, secure execution and accelerators
- virtualization — virtual CPUs/memory/devices and emulation
- peripheral — UART, SPI, I2C/I3C, GPIO and related embedded I/O

Every decomposition must preserve source provenance and identify unresolved semantic residue.
