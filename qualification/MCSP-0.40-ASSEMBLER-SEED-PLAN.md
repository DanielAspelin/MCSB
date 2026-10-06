# MCSP 0.40 Assembler Seed Qualification Plan

Required evidence:
1. exact committed structural tuple is accepted;
2. emitted target bytes are 48 31 d8;
3. mutated width 32 is rejected as unsupported;
4. emitted bytes execute and produce the 0.39 structural result;
5. source preservation remains satisfied;
6. disassembly of extracted emitted bytes identifies the expected x86-64 realization;
7. NASM source mnemonic for the target operation is not used to generate the emitted target bytes.

Qualification must distinguish:
- bootstrap emitter implementation;
- MCSP structural selection;
- emitted realization;
- runtime behavior.

General x86-64 assembly remains UNVERIFIED.
