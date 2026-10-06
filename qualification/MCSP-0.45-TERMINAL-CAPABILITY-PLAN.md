# MCSP 0.45 Terminal Release Capability Qualification Plan

Required:
1. execute from the normal terminal foreground invocation;
2. calculate TERMINAL_RELEASE_CAPABLE from bounded Linux x86-64 realization knowledge;
3. retain TERMINAL_ATTACHED throughout the run;
4. keep TERMINAL_RELEASE_INVOKED false;
5. keep BACKGROUND_OPERATING false;
6. inspect the executable/disassembly for absence of an invoked fork/setsid/close/dup2 detachment path;
7. verify inherited stdout remains usable through normal completion;
8. treat capability, current attachment and future background operation as conditions, not kernel states.

No actual detachment is authorized or required by 0.45.
