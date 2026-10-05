# Network Decomposition

## Purpose

Decompose networking from machine-visible NIC operation through protocol state without treating protocol-specific structures as universal MCSP primitives.

## Outbound path

instruction -> memory -> descriptor -> map/allocate -> queue/schedule -> DMA/transfer -> NIC -> frame -> packet -> transport -> link -> remote host

## Inbound path

link -> NIC -> queue/descriptor -> DMA/transfer -> memory -> interrupt/poll -> schedule -> protocol transition -> consumer-visible state

## Initial evidence families

- Ethernet/MAC and NIC realization
- ARP / IPv4 / ICMPv4
- IPv6 / ICMPv6 / NDP
- UDP
- TCP
- DHCPv4 / DHCPv6
- DNS
- routing and multicast
- Wi-Fi/Bluetooth/cellular as separate link/radio realizations

## Candidate recurring constructs

address, block, buffer, descriptor, queue, schedule, transfer, frame, packet, route, state, transition, signal, completion, interface, link.

These remain candidates until cross-domain and self-description tests pass.
