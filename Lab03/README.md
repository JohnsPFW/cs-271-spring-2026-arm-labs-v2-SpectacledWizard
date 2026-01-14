# Lab 03: Instruction Exploration

## Overview

This lab is different from the previous ones! Instead of writing code, you will **analyze and predict** the behavior of various ARM64 instructions, then verify your predictions using the waveform viewer.

**Prerequisites:** Complete Labs 00-02 first!

**Estimated Time:** 45-60 minutes

---

## Learning Objectives

After completing this lab, you will be able to:
1. Trace through ARM64 code and predict register values
2. Understand branching behavior
3. Use logical operations (AND, OR)
4. Use shift operations (LSL, ASR)
5. Use arithmetic with shifted operands
6. Understand signed vs unsigned operations
7. Use the waveform viewer to verify execution

---

## This Lab Is Different!

**You do NOT need to write any code.**

Instead, you will:
1. Read the provided code in `test_lab03.s`
2. Predict the value of each register after execution
3. Run the simulation
4. Use the waveform viewer to check your predictions
5. Fill in the prediction worksheet

---

## Instruction Reference

### Move Instructions
| Instruction | Meaning |
|-------------|---------|
| `MOVZ X0, #0xff` | X0 = 0xff (zero-extend immediate) |
| `MOV X0, #-252` | X0 = -252 (can handle negative values) |

### Branch Instructions
| Instruction | Meaning |
|-------------|---------|
| `B label` | Unconditionally jump to label |
| `BNE label` | Jump if previous comparison was Not Equal |

### Logical Instructions
| Instruction | Meaning |
|-------------|---------|
| `AND X1, X0, #mask` | X1 = X0 AND mask (bitwise) |
| `ORR X1, X0, X2` | X1 = X0 OR X2 |

### Shift Instructions
| Instruction | Meaning |
|-------------|---------|
| `LSL X2, X1, #1` | Logical Shift Left: X2 = X1 << 1 |
| `ASR X2, X1, #3` | Arithmetic Shift Right: X2 = X1 >> 3 (preserves sign) |

### Arithmetic Instructions
| Instruction | Meaning |
|-------------|---------|
| `ADD X4, X1, X0` | X4 = X1 + X0 |
| `ADD X4, X1, X0, LSL #2` | X4 = X1 + (X0 << 2) |
| `SUBS X6, X5, #1` | X6 = X5 - 1, and set condition flags |

### Memory Instructions
| Instruction | Meaning |
|-------------|---------|
| `STUR X0, [X10]` | Store X0 to memory at address in X10 |
| `LDUR X11, [X10]` | Load from memory at address in X10 into X11 |

---

## Your Task

### Step 1: Open the Code

Open `test_lab03.s` and read through each section carefully.

### Step 2: Make Predictions

For each register mentioned, predict its final value. Write your predictions in the worksheet at the bottom of `test_lab03.s`.

### Step 3: Run the Simulation

```bash
make sim_lab03
```

### Step 4: Open the Waveform Viewer

1. Click on `dump.vcd` in the file explorer
2. Expand: `test_Educore > educore > register_file`
3. Add the registers you need to check

### Step 5: Verify Your Predictions

Compare your predictions to the actual values. For each incorrect prediction, figure out why you were wrong.

---

## Hints for Specific Parts

### Part 2: Branch
The `B _TEST` instruction should skip over the next three instructions. If the branch works correctly, X0 should remain 0xff (not 0xffff).

### Part 3: AND with Large Immediate
```
X0   = 0x00000000000000ff
mask = 0x00003ffc00003ffc
X1   = X0 AND mask = ?
```

### Part 4: Arithmetic Shift Right
ASR preserves the sign bit. For negative numbers:
```
X24 = -252 (binary: 11111111111...100)
X25 = X24 >> 3 = -32 (sign is preserved)
```

### Part 5: Shifted Operand
```
ADD X23, X1, X0, LSL #2
```
This means: X23 = X1 + (X0 shifted left by 2)
If X0 = 0xff, then X0 << 2 = 0xff * 4 = 0x3fc

---

## Prediction Worksheet

Copy this table and fill it in:

| Register | Your Prediction (hex) | Actual Value | ✓/✗ |
|----------|----------------------|--------------|-----|
| X0 | | | |
| X1 | | | |
| X2 | | | |
| X4 | | | |
| X5 | | | |
| X6 | | | |
| X10 | | | |
| X11 | | | |
| X20 | | | |
| X21 | | | |
| X22 | | | |
| X23 | | | |
| X24 | | | |
| X25 | | | |

---

## Submission

After completing your predictions and verification:

```bash
git add .
git commit -m "Completed Lab 03"
git push
```

**Note:** The autograder only checks that the simulation runs successfully. Your learning comes from the prediction exercise!

---

## Discussion Questions

After completing the lab, consider these questions:

1. Why does the branch instruction skip over multiple lines of code?
2. What's the difference between `LSL` (Logical Shift Left) and `ASR` (Arithmetic Shift Right)?
3. Why might you use `ADD X23, X1, X0, LSL #2` instead of separate LSL and ADD instructions?
4. What happens when you subtract 1 from 0 using SUBS?
