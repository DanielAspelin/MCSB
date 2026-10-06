# MCSP 0.54 Kbuild Module Integration Requalification Evidence

Qualification date: 2026-10-06
Result: CONDITIONAL PASS
Qualification class: Constructive Linux module-build checkpoint

## Preserved failure lineage

Initial 0.54 build checkpoint 4aa31162122d8e671457cf3da4f97a27156aa966
did not qualify. Kbuild/objtool exposed:
- missing Kbuild command tracking for the hand-built NASM object;
- missing kernel-appropriate return-thunk projection;
- missing ELF function-size annotation.

A subsequent correction used invalid GAS-style size syntax in NASM and failed.
A later NASM declaration duplicated inconsistent function attributes and failed.
These checkpoints remain preserved as failed experimental lineage.

## Corrected projection

Final source correction:

    3e5f02b3c7536acb7ecb12d0fd00fa7b0022e1a2

The MCSP object now:
- declares a sized ELF FUNC symbol;
- uses the Linux x86-64 __x86_return_thunk boundary required by this RETHUNK build;
- remains assembly-owned;
- is tracked through Kbuild's command mechanism.

## Kbuild result

Running build boundary:

    Linux 6.12.111+deb13-amd64

Pipeline completed:

    CC adapter
    NASM MCSP object
    LD composite object
    MODPOST
    CC module metadata
    LD mcsp_probe.ko
    BTF

Result: PASS.

mcsp_probe.ko:
- ELF64 x86-64 REL;
- mcsp_exclusive_u64 present as GLOBAL FUNC, size 11;
- no userspace _start;
- MCSP disassembly preserves mov RDI->RAX then XOR RSI;
- relocation to __x86_return_thunk is present;
- adapter relocation to mcsp_exclusive_u64 is present.

Module metadata read directly from .modinfo:
- license=GPL
- description=MCSP 0.54 Kbuild integration qualification probe
- author=MCSP qualification fixture
- vermagic=6.12.111+deb13-amd64 SMP preempt mod_unload modversions

modinfo utility was unavailable on the host; no package was installed. ELF-native
inspection supplied the required metadata evidence.

Final .ko SHA-256:

    0065c05eb95759be74fac74e26c90e390baeeec523d02b8c03a4eb0eccacfafc

Final MCSP object SHA-256:

    5a71bc15f8d2e0e7244e8678914e4fe86d5a90bb12848fcccd459574126572e5

MODULE_NOT_LOADED=PASS.

## Qualification

MCSP NASM object inside Kbuild composite module: VERIFIED fixture.
Kbuild command tracking: VERIFIED.
objtool-compatible bounded assembly projection: VERIFIED for this kernel config.
MODPOST completion: VERIFIED.
Final .ko link: VERIFIED.
BTF build stage: VERIFIED.
MCSP symbol linkage from adapter: VERIFIED.
Module metadata presence: VERIFIED.
No module loading: VERIFIED.

In-kernel execution: UNVERIFIED and not attempted.
insmod/modprobe: NOT AUTHORIZED / NOT ATTEMPTED.
Driver registration/hardware access: UNVERIFIED.
Kernel-version/config portability: UNVERIFIED.
Module signing/enforcement: UNVERIFIED.
Production qualification: UNVERIFIED.

Linux-specific return-thunk and Kbuild metadata are realization constraints, not
MCSP semantic authority.

Kernel remains DETERMINATE CONDITION.
C is used only as the minimal Linux module-interface adapter; MCSP semantic and
machine construction remains assembly-owned.
