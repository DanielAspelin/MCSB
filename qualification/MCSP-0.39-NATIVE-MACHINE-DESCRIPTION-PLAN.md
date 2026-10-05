# MCSP 0.39 Native Machine Description Qualification Plan

The qualification procedure must use three evidence classes:

1. structural description: model/NATIVE-MACHINE-DESCRIPTION-0.39.mcsp;
2. machine behavior: execute the committed assembly witness;
3. machine reconstruction: inspect the built artifact/disassembly and reconstruct the material operation without relying on source comments.

Required positive checks:
- A=0x55aa55aa55aa55aa;
- B=0x0f0ff0f00f0ff0f0;
- predicted result=0x5aa5a55a5aa5a55a;
- source remains B;
- decoded transition is a 64-bit two-register operation;
- decoded operation's bit relation matches 00->0, 01->1, 10->1, 11->0.

Required negative check:
- substitute an incompatible per-position OR relation; its predicted value must differ for the fixture or truth-table structure must independently exclude it.

The mnemonic may be reported as realization evidence but cannot be the sole basis of semantic qualification.
