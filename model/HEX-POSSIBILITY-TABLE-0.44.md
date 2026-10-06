# MCSP Hex Possibility Table 0.44

| Hex | Binary | Decimal |
|---|---|---:|
| 0 | 0000 | 0 |
| 1 | 0001 | 1 |
| 2 | 0010 | 2 |
| 3 | 0011 | 3 |
| 4 | 0100 | 4 |
| 5 | 0101 | 5 |
| 6 | 0110 | 6 |
| 7 | 0111 | 7 |
| 8 | 1000 | 8 |
| 9 | 1001 | 9 |
| A | 1010 | 10 |
| B | 1011 | 11 |
| C | 1100 | 12 |
| D | 1101 | 13 |
| E | 1110 | 14 |
| F | 1111 | 15 |

## Composition

One hex position = 4 binary positions = 16 possibilities.

Two hex positions = 1 byte = 8 binary positions = 256 possibilities.

Hex text is a projection. The binary distinctions and their qualified machine interpretation remain separate.

## Current machine examples

    48 31 D8
    4 8 | 3 1 | D 8
    01001000 00110001 11011000

and candidate second operation:

    48 09 D8
    4 8 | 0 9 | D 8
    01001000 00001001 11011000

These examples demonstrate that the same positional table can represent materially different encodings without assigning semantics to hexadecimal digits themselves.
