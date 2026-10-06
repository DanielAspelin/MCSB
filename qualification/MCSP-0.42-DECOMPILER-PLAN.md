# MCSP 0.42 Decompiler Qualification Plan

Required checks:
1. consume the five-field 0.41 decoded tuple;
2. reconstruct width=64, source-preservation and destination-replacement obligations;
3. reconstruct all four per-position relation rows;
4. compare reconstruction against the 0.39 pre-settlement;
5. prove an incompatible OR relation differs;
6. reject unknown relation token;
7. reject incompatible width;
8. do not use mnemonic text as decompiler input.

The fixture tests bounded semantic reconstruction, not general source-code recovery.
