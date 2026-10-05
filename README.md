# MCSB

## Machine Construct Set Positional (MCSP)

**Status:** Initial constructive specification  
**Qualification:** Pre-informative / Unverified  
**Purpose:** Formalize a self-describing machine-level construct system.

## Concept

Machine Construct Set Positional (MCSP) is a proposed machine-level representation in which the constructs of machine computation can formally describe themselves, their positions, their relationships, their semantics, and their host realizations.

The central idea is to make the machine construct set capable of looking at and describing the machine construct set itself.

Rather than treating assembly syntax as the fundamental definition of a machine, MCSP separates the machine model into explicit constructs. Human-readable assembly can then become a projection or serialization of that model.

## Core model

MCSP is intended to represent constructs including:

- instructions
- operands
- registers
- memory
- addresses and addressing
- widths and types
- encodings
- execution semantics
- state transitions
- relationships between constructs
- host realizations

A construct may therefore be understood conceptually as:

    CONSTRUCT
      identity
      position
      operands
      relation
      operation
      state transition
      encoding
      host realization

## Self-description

The intended closure is:

    machine constructs
        -> describe their structure
        -> describe their relationships
        -> describe their encoding
        -> describe their execution
        -> collectively describe the machine construct system

The objective is a finite self-description closure: the construct set contains enough formally defined primitives to describe the construct set itself without requiring an undefined recursive language layer.

## Syntax, semantics, and encoding

MCSP keeps three concerns distinct:

1. **Syntax** — how a construct is represented for humans or tools.
2. **Semantics** — what the construct means and what state transition it defines.
3. **Encoding** — how the construct is realized on a physical or virtual host.

This separation allows the semantic machine model to remain stable while host-specific encodings vary.

## Host realization

A future architecture may map the same MCSP semantics onto multiple instruction-set architectures:

    MCSP
      -> semantic machine model
      -> host realization
          -> x86-64
          -> AArch64
          -> RISC-V
          -> other machine architectures

Host-specific capabilities should be modeled explicitly rather than pretending that all physical architectures provide identical behavior.

## Relationship to an ISA

A conventional Instruction Set Architecture defines what a particular machine can execute.

MCSP instead aims to define what machine constructs are, where they stand relative to one another, how they describe one another, and how they may be realized by a host ISA.

Assembly may therefore become a human-readable representation of MCSP rather than the fundamental machine definition.

## Initial design objective

The first technical milestone is to determine the smallest construct vocabulary capable of describing:

- a construct
- a definition
- an instruction
- an operand
- machine state
- an execution rule
- an encoding rule
- a host realization

Once those primitives can express their own definitions, MCSP reaches self-description closure.

## Repository lineage

This repository begins the independent MCSB project lineage. This README records the initial concept discussed on 2026-10-05.

No production implementation or portability claim is established by this initial specification. Such claims require implementation, testing, qualification, and reproducible evidence.
