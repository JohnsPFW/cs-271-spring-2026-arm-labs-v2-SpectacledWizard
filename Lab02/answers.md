# Lab 02 Answers
**Student Name:** Gabriel Martinez

---

## How to decode an instruction encoding

For each question below, find the hex encoding in your disassembly log, convert it to 32-bit binary, then fill in each field using the bit layout diagram.

**Worked Example: `MOVZ X1, #1` (encoding: `d2800021`)**

Step 1 — Convert hex to binary (4 bits per digit):
```
d    2    8    0    0    0    2    1
1101 0010 1000 0000 0000 0000 0010 0001
```

Step 2 — Map bits to the MOVZ field layout:

| 31 | 30-29 | 28-23  | 22-21 | 20-5             | 4-0   |
|----|-------|--------|-------|------------------|-------|
| sf | 10    | 100101 | hw    | imm16            | Rd    |
| 1  | 10    | 100101 | 00    | 0000000000000001 | 00001 |

Step 3 — Identify each field:
- `sf` = 1 → 64-bit register
- `hw` = 00 → no shift (LSL #0)
- `imm16` = 0000000000000001 = 1
- `Rd` = 00001 = X1

---

## Section 3.2 — Interpreting Instruction Encodings

---

**1. `MOVZ X0, #5`**

Hex encoding (from disassembly log): `0x` d29fffe5

Binary (32-bit):
```
d    2    9    f    f    f    e    5
1101 0010 1001 1111 1111 1111 1110 0101
```

| 31 | 30-29 | 28-23  | 22-21 | 20-5  | 4-0 |
|----|-------|--------|-------|-------|-----|
| sf | 10    | 100101 | hw    | imm16 | Rd  |
| 1  | 10    | 100101 | 00    | 1111111111111111 | 00101 |

- `sf` = 1
- `hw` = 00
- `imm16` = 1111111111111111
- `Rd` = 00101

---

**2. `ADD X4, X4, X0`**

Hex encoding (from disassembly log): `0x` 8b040004

Binary (32-bit):
```
8    b    0    4    0    0    0    4
1000 1011 0000 0100 0000 0000 0000 0100
```

| 31 | 30 | 29 | 28-24 | 23-22 | 20-16 | 15-10 | 9-5 | 4-0 |
|----|----|----|-------|-------|-------|-------|-----|-----|
| sf | op | S  | 01011 | shift | Rm    | imm6  | Rn  | Rd  |
| 1  | 0  | 0  | 01011 | 00    | 00100 | 000000|00000|00100|

- `Rm` (binary) = 00100
- `Rn` (binary) = 00000
- `Rd` (binary) = 00100

---

**3. `SUBS X0, X0, X1`**

Hex encoding (from disassembly log): `0x` eb010000

Binary (32-bit):
```
e    b    0    1    0    0    0    0
1110 1011 0000 0001 0000 0000 0000 0000
```

| 31 | 30 | 29 | 28-24 | 23-22 | 20-16 | 15-10 | 9-5 | 4-0 |
|----|----|----|-------|-------|-------|-------|-----|-----|
| sf | op | S  | 01011 | shift | Rm    | imm6  | Rn  | Rd  |
| 1  | 1  | 1  | 01011 | 00    | 00001 | 000000|00000|00000|

Compare the `op` and `S` bits to `ADD` above:
- How does the encoding differ to signal that condition flags should be updated?
The op and S bits are both 1 instead of 0 to signal that condition flags should update.
---

**4. `B.NE sum_loop`**

Hex encoding (from disassembly log): `0x` 54ffffa1

Binary (32-bit):
```
5    4    f    f    f    f    a    1
0101 0100 1111 1111 1111 1111 1010 0001
```

| 31-24    | 23-5  | 4 | 3-0  |
|----------|-------|---|------|
| 01010100 | imm19 | 0 | cond |
| 01010100 | 1111111111111111101 | 0 | 0001 |

- `imm19` (binary) = 1111111111111111101
- `imm19` as a two's complement integer = 0000000000000000011
- Byte offset (imm19 × 4) = 0000000000000001100
- `B.NE` address (from disassembly) = 10
- `sum_loop` address (from disassembly) = 10
- Do they match?
Yes, 10 = 10.
---

## Section 4.1 — Logical Immediate Values

`MOVZ` and `MOVK` each write a 16-bit immediate into one of four slots in a 64-bit register. The `LSL` shift selects which slot:

| bits 63-48 | bits 47-32 | bits 31-16 | bits 15-0 |
|------------|------------|------------|-----------|
| LSL #48    | LSL #32    | LSL #16    | LSL #0    |

`MOVZ` writes the selected slot and **zeros** all others.
`MOVK` writes the selected slot and **keeps** all other bits unchanged.

Use this layout to trace the value of X5 step by step before answering.

---

**X5** (after `MOVZ` + `MOVK`):
`X5 = 0x`

movz = #0xffff (0000000000000000ffff)
movk = #0xff lsl #16

**X6** (after `AND X6, X5, #0x00003ffc00003ffc`):
`X6 = 0x`

**X7** (after `ORR X7, X5, #0x00003ffc00003ffc`):
`X7 = 0x`

---

## Section 5 — Instruction Aliases

- What is the base instruction that `CMP X0, X1` translates to?
CMP Xn, Xm is an alias for SUBS XZR, Xn, Xm
- What is the full expanded form (including all operands)?
The fully expanded form would translate to SUBS XZR, X0, X1