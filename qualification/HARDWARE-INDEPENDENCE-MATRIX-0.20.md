# MCSP Hardware Independence Matrix 0.20

Status: Constructive qualification experiment
Qualification: Under Conditional Experiment
Parent: Interpretation and Hardware Independence 0.19

## Witness semantic

Candidate canonical:

    TRANSFER

Provisional invariant:

    Under declared applicability, information associated with a source relation
    becomes available through a destination relation while the material
    distinctions required by the transfer contract are preserved.

TRANSFER does not require:
- one instruction;
- one register;
- one address form;
- one memory hierarchy;
- one assembler;
- one bus;
- one protocol;
- one completion mechanism.

This definition remains subject to reduction.

## Orthogonal dimensions under test

    semantic identity
    source relation
    destination relation
    representation
    position/addressing
    extent
    order
    completion
    failure
    realization path

A realization may vary one or more of these without redefining the TRANSFER invariant unless that dimension is material to the declared contract.

## Witness matrix

### x86-64 register/memory realization

Possible realization paths include register moves, loads/stores, or instruction sequences.

Assembler witnesses:
- NASM syntax where applicable
- GNU assembler syntax where applicable

Hardware-specific register names, addressing syntax, opcodes, and encodings are realization data.

Expected semantic projection:
    source relation -> destination relation
    with declared material distinctions preserved.

Status: STRUCTURAL CANDIDATE.

### AArch64 realization

Possible realization paths include register transfer and load/store instruction classes.

GNU assembler may represent the ISA realization.

Different register model, instruction encoding, and addressing forms SHALL NOT redefine canonical TRANSFER.

Status: STRUCTURAL CANDIDATE.

### RISC-V realization

Possible realization paths include register operations and load/store instruction classes.

GNU assembler may represent the ISA realization.

Differences in ISA encoding and available extensions are explicit realization capabilities/constraints.

Status: STRUCTURAL CANDIDATE.

### DMA realization

A device/controller may transfer information between memory/device-visible regions using descriptors, queues, bus transactions, and completion signaling.

No CPU data-movement instruction is required to perform the material transfer itself.

This is the principal non-processor witness.

Status: STRUCTURAL CANDIDATE.

### Network realization

A network path may realize a broader transfer contract through framing, packetization, routing, buffering, retransmission, checks, and completion semantics.

Network transfer is NOT automatically equivalent to a local memory transfer.

Equivalence is only claimable for the explicitly shared invariant and declared applicability.

Status: BOUNDED CROSS-DOMAIN CANDIDATE.

## Independence observations

The witnesses can differ in:
- instruction count;
- opcode;
- encoding;
- register naming;
- address representation;
- physical path;
- buffering;
- queueing;
- scheduling;
- completion notification;
- error model.

These differences are not automatically semantic differences.

A difference becomes semantic when it changes a material invariant declared by the TRANSFER contract.

## Canonical test

A TRANSFER realization passes only if:

1. source and destination roles are established within applicability;
2. required information distinctions are preserved;
3. required extent is preserved;
4. declared ordering constraints are preserved;
5. declared completion semantics are preserved;
6. declared failures remain observable as required;
7. no forbidden observable side effect violates the contract.

Unsupported capability SHALL be explicit.

## NASM/GAS test

For an applicable x86-64 realization:

    MCSP TRANSFER
      -> x86-64 semantic realization
      -> NASM representation
      -> machine encoding

and independently:

    MCSP TRANSFER
      -> x86-64 semantic realization
      -> GAS representation
      -> machine encoding

Assembler text is not compared as semantic identity.

The projected machine behavior is compared against the same canonical invariant.

This keeps NASM and GAS boundaries distinct.

## Hardware-clearance result

TRANSFER is representation-cleared by construction in this model.

It is assembler-cleared as a hypothesis because assembler notation is outside the invariant.

It is ISA-cleared as a candidate because x86-64, AArch64, and RISC-V can provide materially different realization paths.

It is cross-domain only in bounded form because DMA/network realizations introduce ordering, completion, persistence, and failure differences that must be declared rather than erased.

## Qualification matrix

| Witness | Representation varies | ISA varies | Non-CPU path | Canonical invariant candidate |
| x86-64 / NASM | yes | baseline | no | preserve |
| x86-64 / GAS | yes | baseline | no | preserve |
| AArch64 / GAS | yes | yes | no | preserve |
| RISC-V / GAS | yes | yes | no | preserve |
| DMA | yes | yes/none | yes | preserve under declared contract |
| Network | yes | yes/none | yes | preserve only for bounded shared invariant |

## Result

No witness requires its assembler mnemonic, opcode, register name, encoding, bus, or protocol to define TRANSFER.

This is evidence that MCSP's semantic/canonical/orthogonal separation can produce hardware clearance.

It is NOT yet runtime proof of hardware independence.

Current qualification:

    TRANSFER:
        hardware-clearance architecture: CONDITIONAL PASS
        hardware independence: UNVERIFIED pending concrete execution/projection evidence

## Next

Encode concrete realization cases and expected observations.

Where execution environments are available, compile/run independent witnesses and compare projected behavior rather than textual assembly.

No Permanent Seal is asserted.
