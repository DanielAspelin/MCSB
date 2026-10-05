# Processor Decomposition

## Initial witnesses

- x86-64 / Intel 64 and AMD64
- AArch64 / A64
- RISC-V

## First comparison classes

- register-to-register data movement
- immediate/value construction
- memory load
- memory store
- arithmetic
- logical/bit operations
- compare/test
- conditional control flow
- unconditional control flow
- call/return
- stack/state-save patterns
- atomic operations
- memory ordering/barriers
- privilege/system-register operations
- exception/interrupt transitions

The objective is not to create a union ISA. Each instruction is decomposed into host-independent semantic effects plus host realization and encoding.
