# MCSP 0.16 Kernel Counterexample Test

Qualification target: Determinate Condition Kernel 0.16
Method: conceptual adversarial qualification
Runtime dependency: none

## T1 Static physical condition

Witness:
A realization presents a stable discriminable electrical condition with no required semantic name and no required transition.

Question:
Can the kernel admit it without STATE, VALUE, ORDER, or binary semantics?

Result: PASS.

Reason:
Determinacy may constrain later interpretation even when no change or temporal ordering is asserted. Calling the witness high/low or 0/1 is unnecessary.

## T2 Completely unconstrained placeholder

Witness:
A purported condition is asserted, but no evidence can exclude any interpretation whatsoever.

Question:
Does MCSP qualify an arbitrary semantic claim over it?

Result: PASS (rejection expected).

Reason:
0.16 leaves the interpretation unqualified. This demonstrates non-vacuity.

## T3 Same observation, competing meanings

Witness:
The same realization evidence is claimed to mean two incompatible canonical semantics.

Question:
Does the kernel itself choose a meaning?

Result: PASS.

Reason:
The kernel chooses neither. Each canonical application must independently demonstrate sufficient determination for its material distinctions. Pre-written semantics do not decide applicability.

## T4 Unordered capability

Witness:
A device exposes two independently accessible capabilities with no semantic before/after relation.

Question:
Does kernel admission require ORDER or POSITION?

Result: PASS.

Reason:
Neither is required at kernel level. They may be introduced by later interpretation where applicable.

## T5 Unknown device condition

Witness:
A driver can discriminate a device condition but has no current OS semantic use for it.

Question:
Must the driver name/classify it?

Result: PASS.

Reason:
The condition may remain uninterpreted. Future extension semantics can be added without rewriting the kernel.

## T6 Host spelling divergence

Witness:
NASM and GNU assembler spell or structure equivalent host realization paths differently.

Question:
Does assembler representation alter the kernel?

Result: PASS.

Reason:
Assembler syntax belongs to realization. Determinate condition and canonical semantic qualification remain above assembler spelling.

## T7 State-first challenge

Witness:
An implementation exposes a conventional machine state directly.

Question:
Must MCSP treat STATE as kernel primitive because the host does?

Result: PASS (rejection expected).

Reason:
The host may project a state interpretation from determinate conditions. Host convenience does not redefine the MCSP kernel.

## T8 Determination-alone challenge

Witness:
DETERMINATION is asserted without anything whose interpretations are constrained.

Question:
Can determination stand alone?

Result: PASS (rejection expected).

Reason:
It is semantically empty in the current model. This supports the coupled determinate-condition formulation.

## T9 Condition-without-determinacy challenge

Witness:
A CONDITION is asserted while every possible interpretation remains equally supportable.

Question:
Can it support qualified semantics?

Result: PASS (rejection expected).

Reason:
It may remain documentary/unknown, but cannot support a qualified semantic projection.

## T10 Product contamination

Witness:
The kernel is defined as BIT, OBJECT, INSTRUCTION, VALUE, or BOOLEAN.

Question:
Does the candidate remain product-free?

Result: PASS (rejection expected).

Reason:
Each proposed definition introduces a later semantic or realization product and is therefore rejected as kernel definition.

## Summary

Tests executed conceptually: 10
Counterexamples defeating 0.16: 0
Qualification result: CONDITIONAL PASS

This is not proof of semantic closure.

Unresolved residue:
- evidence
- incompatibility
- interpretation boundary
- support
- exclusion

Next qualification:
Attempt to reduce these residue terms and encode the qualification relation without relying on natural-language authority.
