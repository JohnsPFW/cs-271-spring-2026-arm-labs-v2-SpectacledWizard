# Lab 02: Post-Increment Addressing

## Overview

In this lab, you will learn a more efficient version of string copy using **post-increment addressing**. This addressing mode automatically updates the pointer after each memory access, reducing the number of instructions needed.

**Prerequisites:** Complete Lab 00 and Lab 01 first!

**Estimated Time:** 30-45 minutes

---

## Learning Objectives

After completing this lab, you will be able to:
1. Use post-increment addressing mode `[Xn], #1`
2. Understand the difference between `LDRB/STRB` and `LDURB/STURB`
3. Use `CMP` and `BNE` for conditional loops
4. Write more efficient assembly code

---

## Background

### Post-Increment Addressing

In Lab 01, you used separate instructions to increment pointers:
```asm
LDRB    W2, [X0]        // Load from X0
ADD     X0, X0, #1      // Increment X0 (separate instruction!)
```

With post-increment, you do both in ONE instruction:
```asm
LDRB    W2, [X0], #1    // Load from X0, THEN add 1 to X0
```

### Comparison: Lab 01 vs Lab 02

| Lab 01 (6 instructions per iteration) | Lab 02 (4 instructions per iteration) |
|---------------------------------------|---------------------------------------|
| `LDRB W2, [X0]` | `LDRB W2, [X0], #1` |
| `STRB W2, [X1]` | `STRB W2, [X1], #1` |
| `CBZ W2, done` | `CMP X2, #0` |
| `ADD X0, X0, #1` | `BNE loop` |
| `ADD X1, X1, #1` | |
| `B loop` | |

That's **2 fewer instructions per character copied!**

### New Instructions

| Instruction | Syntax | Meaning |
|-------------|--------|---------|
| `LDRB` with post-inc | `LDRB W2, [X0], #1` | Load byte, then X0 = X0 + 1 |
| `STRB` with post-inc | `STRB W2, [X1], #1` | Store byte, then X1 = X1 + 1 |
| `CMP` | `CMP X2, #0` | Compare X2 with 0, set flags |
| `BNE` | `BNE label` | Branch if Not Equal (flag-based) |

---

## Your Task

Open `test_lab02.s` and complete the 4 TODO sections:

1. **TODO #1:** Load byte with post-increment
2. **TODO #2:** Store byte with post-increment
3. **TODO #3:** Compare to zero
4. **TODO #4:** Branch if not equal

---

## Step-by-Step Instructions

### Step 1: Understand the Starter Code

The file already sets up:
- X0 pointing to source (0x50)
- X1 pointing to destination (0x13C)
- A test string "ef" stored at the source

### Step 2: Implement the Loop

```asm
_strcpyloop:
    LDRB    W2, [X0], #1    // TODO #1
    STRB    W2, [X1], #1    // TODO #2
    CMP     X2, #0          // TODO #3
    BNE     _strcpyloop     // TODO #4
```

### Step 3: Build and Run

```bash
make sim_lab02
```

### Step 4: Verify

You should see `[EDUCORE LOG]: Apollo has landed`

---

## Common Mistakes

### Using W2 instead of X2 in CMP
```asm
CMP     W2, #0      // ⚠️ May work but use X2 for consistency
CMP     X2, #0      // ✅ Recommended
```

### Forgetting the post-increment amount
```asm
LDRB    W2, [X0]        // ❌ No post-increment!
LDRB    W2, [X0], #1    // ✅ Correct
```

### Wrong branch condition
```asm
BEQ     _strcpyloop     // ❌ Branches when EQUAL to zero (wrong!)
BNE     _strcpyloop     // ✅ Branches when NOT equal to zero
```

---

## Submission

```bash
git add .
git commit -m "Completed Lab 02"
git push
```

---

## Quick Reference

```asm
LDRB    W2, [X0], #1    // Load byte, post-increment
STRB    W2, [X1], #1    // Store byte, post-increment
CMP     X2, #0          // Compare to zero
BNE     label           // Branch if not equal
```
