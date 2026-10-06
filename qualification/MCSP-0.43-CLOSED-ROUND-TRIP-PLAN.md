# MCSP 0.43 Closed Round-Trip Qualification Plan

One executable fixture must prove the composed path rather than relying on separate historical passes.

Required:
1. assemble the qualified structural tuple to target bytes at runtime;
2. execute those emitted bytes and preserve 0.39 behavior;
3. disassemble those same emitted bytes internally;
4. compare decoded tuple to assembler input field-for-field;
5. decompile decoded tuple to semantic structure;
6. compare reconstructed semantics to the original 0.39 structure field-for-field;
7. reject mutated opcode bytes;
8. reject unsupported structural relation;
9. distinguish an incompatible OR semantic reconstruction;
10. retain external disassembly only as audit evidence.

A pass is bounded x86-64 fixture evidence, not closure.
