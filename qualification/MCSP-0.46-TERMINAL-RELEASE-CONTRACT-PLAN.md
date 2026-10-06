# MCSP 0.46 Terminal Release Transition Contract Qualification Plan

Qualification target: condition-only contract; no terminal release.

Required evidence:

1. TERMINAL_ATTACHED = 1.
2. TERMINAL_RELEASE_CAPABLE = 1.
3. TERMINAL_RELEASE_DETERMINED = 0.
4. TERMINAL_RELEASE_INVOKED = 0.
5. BACKGROUND_OPERATING = 0.
6. No STATE is introduced by the model or executable condition record.
7. No RELEASE_READY condition or equivalent exists.
8. Capability does not mutate determination, invocation, or background operation.
9. Executable paths contain no terminal-detachment operation.
10. PASS output is emitted through inherited stdout and the process exits normally.

Adversarial requirements:

- force release_determined=1 -> qualification must fail;
- force release_invoked=1 -> qualification must fail;
- force background_operating=1 -> qualification must fail;
- force state_introduced=1 -> qualification must fail.

No actual detachment is authorized or required.
