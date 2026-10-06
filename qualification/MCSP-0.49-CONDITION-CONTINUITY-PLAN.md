# MCSP 0.49 Condition Continuity Qualification Plan

Baseline sequence:

1. NONE -> IDLE / FOREGROUND
2. IDLE -> PROCESSING / FOREGROUND
3. PROCESSING -> PROCESSING / BACKGROUND
4. PROCESSING -> IDLE / FOREGROUND

Required:
- deterministic final lineage = 257;
- final sequence = 4;
- final condition = IDLE;
- equal consecutive PROCESSING conditions remain separate calculations;
- STATE remains absent;
- TYPE remains absent;
- terminal release remains absent.

Attacks:
- incorrect prior condition must be rejected;
- unsupported current condition must be rejected;
- unsupported mode must be rejected;
- forced STATE must be rejected;
- forced TYPE must be rejected;
- forced release must be rejected.

The fixture remains attached to inherited terminal output.
