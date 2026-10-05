# MCSP 0.37 Assembly / Disassembly Self-Scaffold Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL CROSS-ASSEMBLER SELF-SCAFFOLD PASS

Architecture amendment:

    model/ASSEMBLY-DISASSEMBLY-0.37.mcsp

Qualified source checkpoint:

    ec7247a07f656c09307eb88d079327877006597f

## Independent normalization target

Role/value sequence:

    1,0xA11,2,0xF0,3,1,4,1,5,1,6,0,7,0x100,8,0

Fingerprint procedure inherited from the bootstrap normal form:

    H0 = 1469598103934665603
    H(n+1) = (Hn XOR field) * 1099511628211 mod 2^64

The expected fingerprint was independently derived before runtime:

    0x8c8892de1e018683

An earlier provisional constant in the source was corrected before qualification and was not accepted as evidence.

## Assembly witnesses

NASM:

    assembly/x86_64/nasm/mcsp_self_scaffold_normalize.asm

Observed:

    MCSP NASM self-scaffold 0.37: CONDITIONAL PASS
    exit 0

Executable SHA-256:

    068df11e20397724a4e85a97dc951a6ea76a381aa8ba85efe6b419bc868c7759

GAS:

    assembly/x86_64/gas/mcsp_self_scaffold.s

Observed:

    MCSP GAS self-scaffold 0.37: CONDITIONAL PASS
    exit 0

Executable SHA-256:

    b419ddda9edf4fc50c9ae591dab929b7e04585f8c61178dbcfbd8cc78d4f9c56

## Disassembly evidence

GNU objdump was applied independently to both linked artifacts.

NASM disassembly text SHA-256:

    167376adeab8e6097f22ba964d402257b2525d98b3514db003d3415963df9730

GAS disassembly text SHA-256:

    c2fb81ba85d638f400cd67258d62656c2ee30dbc0fc7c7f66a1c4daf67a85843

The disassembly observations show the material normalization core in both artifacts:
- load scaffold address;
- initialize the same 64-bit H0;
- initialize the same 64-bit multiplier;
- process sixteen 64-bit role/value fields;
- XOR each field;
- multiply modulo machine width;
- compare against the same expected fingerprint;
- branch to failure on mismatch.

Symbol spelling differs and is documentary.
Disassembly text hashes differ.
Executable hashes differ.

Those differences do not prevent the same qualified semantic projection.

## Qualification

Assembly as official MCSP realization discipline: ESTABLISHED by 0.37 architecture.
Disassembly as official MCSP inspection/qualification discipline: ESTABLISHED by 0.37 architecture.
NASM self-scaffold normalization runtime: VERIFIED within fixture scope.
GAS self-scaffold normalization runtime: VERIFIED within fixture scope.
Cross-assembler normalized projection: VERIFIED within fixture scope.
Disassembly-based realization comparison: VERIFIED within fixture scope.
Binary identity: deliberately NOT REQUIRED.
Source-symbol identity: deliberately NOT REQUIRED.

Cross-ISA 0.37 self-scaffold normalization: UNVERIFIED.
MCSP-native disassembler: UNVERIFIED.
MCSP-native assembler: UNVERIFIED.
Full self-description closure: UNVERIFIED.
Semantic closure: UNVERIFIED.

Assembly/disassembly are reciprocal qualification directions, not exact inverses.

C was not used.
Kernel remains DETERMINATE CONDITION.
