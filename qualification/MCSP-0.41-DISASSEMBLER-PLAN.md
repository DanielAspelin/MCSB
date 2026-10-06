# MCSP 0.41 Disassembler Qualification Plan

Required checks:
1. raw bytes 48 31 d8 are accepted;
2. reconstructed tuple equals the qualified 0.40 input tuple in all five material fields;
3. opcode mutation 48 09 d8 is rejected;
4. incompatible width/prefix sequence 31 d8 90 is rejected;
5. external objdump is used only to compare audit observation, never as decoder input;
6. 0.40 assembly followed by 0.41 disassembly preserves the bounded structural tuple.

General x86-64 instruction decoding remains UNVERIFIED.
