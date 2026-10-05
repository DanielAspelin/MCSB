# Processor Decomposition — MCSP 0.4

**Status:** Constructive implementation  
**Qualification:** Under Conditional Experiment  
**Witnesses:** x86-64, AArch64/A64, RISC-V RV32I/RV64I families

## Rule

MCSP is not a union instruction set. ISA mnemonics are realization evidence. The MCSP layer records semantic effects; a realization maps those effects to one or more host instructions.

## Semantic state model

For the first decomposition, processor-visible state is modeled provisionally as:

    STATE {
      positions
      values
      control_position
      memory_relation
      condition_state
      privilege_state
      exception_state
    }

A semantic operation transforms a pre-state into a post-state subject to constraints.

## 0.4 semantic operations

### VALUE

Construct or identify a value without assuming a host immediate encoding.

    VALUE(destination, value, width)

Realization may require one or several instructions.

### COPY

Copy a value between processor-visible positions without asserting that all hosts expose a literal MOV opcode.

    COPY(destination, source, width)

Postcondition:

    value(destination) := value(source)

Host-specific side effects and special-register rules remain realization constraints.

### READ

Transfer a value from an addressed memory position into processor-visible state.

    READ(destination, address, width, attributes)

Abstract transition:

    resolved := TRANSLATE(address, attributes)
    value := memory[resolved, width]
    destination := value

Faults, alignment, ordering, translation, privilege and device-memory effects are constraints/results, not erased by the abstraction.

### WRITE

Transfer a processor-visible value to an addressed memory position.

    WRITE(address, source, width, attributes)

Abstract transition:

    resolved := TRANSLATE(address, attributes)
    memory[resolved, width] := value(source)

Visibility, atomicity, ordering, cacheability, persistence and MMIO behavior are explicit attributes/constraints.

### COMPUTE

Apply a defined operation to input values and produce output state.

    COMPUTE(operation, destination, inputs, width, attributes)

Initial operations include ADD, SUBTRACT, AND, OR, XOR and SHIFT. ISA flag behavior is not assumed universal; condition-state effects are separately mapped.

### COMPARE

Derive condition state from values without assuming a universal flags register.

    COMPARE(relation, inputs, width) -> condition

A host may realize this through flags, a register result, fused branch comparison, or another mechanism.

### BRANCH

Select a control position.

    BRANCH(target)
    BRANCH_IF(condition, target, fallthrough)

The MCSP semantic construct is control-position transition, not a particular program-counter encoding.

### INVOKE / RETURN

Represent transfer of control with an explicit continuation relation.

    INVOKE(target, continuation, convention)
    RETURN(continuation, convention)

Stack usage, link registers and calling conventions are realization/convention properties, not fundamental requirements of invocation.

## First ISA mappings

| MCSP effect | x86-64 witness | AArch64 witness | RISC-V witness |
| --- | --- | --- | --- |
| COPY register value | MOV reg,reg | MOV alias / ORR-based realization where applicable | ADDI rd,rs,0 convention |
| VALUE immediate | MOV and related immediate forms | MOVZ/MOVN/MOVK or aliases/sequences | LUI/ADDI and related sequences |
| READ memory | MOV reg,[mem] and typed variants | LDR family | LB/LH/LW/LD families as applicable |
| WRITE memory | MOV [mem],reg and typed variants | STR family | SB/SH/SW/SD families as applicable |
| ADD | ADD | ADD | ADD/ADDI |
| unconditional control transfer | JMP | B | JAL with discarded link where applicable |
| conditional control transfer | Jcc after condition production | B.cond / compare-and-branch families | conditional branch instructions |

This table demonstrates mappings only; it does not assert identical edge semantics.

## Important architectural differences retained

### x86-64

x86-64 permits many instructions to use memory operands and its MOV family covers register/memory data movement. Operand encodings, implicit architectural state, flags, segmentation/system behavior and exception rules remain x86 realization data.

### AArch64

AArch64 uses explicit load/store operations for ordinary memory transfer. Register width, addressing modes, zero/sign extension, architectural aliases, condition flags and system-register behavior remain AArch64 realization data.

### RISC-V

Base RISC-V is load-store: arithmetic operates on registers while loads/stores access memory. The execution environment determines portions of the address space and related behavior. Extensions are capabilities, not assumed base MCSP semantics.

## Why COPY, READ and WRITE are separate

A host instruction spelling such as MOV must not define the semantic taxonomy. Register-to-register copying and memory access have materially different addressing, faulting, ordering and visibility behavior.

Therefore:

    COPY != READ != WRITE

even where one ISA mnemonic can realize more than one of them.

## Address construction

Address calculation is modeled separately from access:

    POSITION(base, displacement, index, scale, relation)
        -> address

Each host realization may fuse address calculation into an instruction encoding. Fusion does not collapse the MCSP semantic distinction.

## Exceptions and completion

Every operation has an outcome relation:

    OUTCOME {
      completed
      exception
      unsupported
      implementation_defined
      environment_defined
    }

An operation that faults is not represented as if its intended post-state completed.

## Self-description requirement

The constructs STATE, VALUE, COPY, READ, WRITE, COMPUTE, COMPARE, BRANCH, INVOKE, RETURN, POSITION and OUTCOME are provisional MCSP definitions. They must later be encoded using the same MCSP construct system.

If a definition requires a semantic term that MCSP cannot itself represent, that term becomes unresolved residue and must be decomposed or admitted as a candidate primitive.

## Next decomposition

1. Formalize POSITION/addressing.
2. Formalize width/value representation.
3. Compare load/store fault and ordering behavior.
4. Decompose arithmetic and condition production.
5. Decompose branch/call/return state.
6. Add atomic and memory-ordering witnesses.
7. Encode this 0.4 model in a machine-readable self-description form.
