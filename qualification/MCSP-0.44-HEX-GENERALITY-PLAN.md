# MCSP 0.44 Hex Layer and Generality Qualification Plan

Required evidence:
1. verify all 16 hex digits map bijectively to values 0..15 and four-bit binary patterns;
2. construct existing relation-1 bytes through nibble composition rather than target mnemonic;
3. reconstruct hex nibbles from those bytes during disassembly;
4. introduce relation token 2 with materially different truth row 11->1;
5. construct relation-2 candidate bytes through the same hex/byte machinery;
6. execute both generated operations over discriminating inputs;
7. disassemble both internally and preserve raw hex plus structural tuple;
8. decompile both to their respective four-row relations;
9. reject semantic cross-identification between relation 1 and relation 2;
10. keep mnemonic text external to semantic authority.

This tests whether the pipeline generalizes across two operations while the kernel remains unchanged.
