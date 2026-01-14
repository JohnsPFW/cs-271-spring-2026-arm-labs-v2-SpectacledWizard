# Lab 01: String Copy (STRCPY)

## Overview

In this lab, you will implement a string copy function in ARM assembly. This is similar to the C function `strcpy()` which copies characters from one memory location to another.

**Prerequisites:** Complete Lab 00 first!

**Estimated Time:** 45-60 minutes

---

## Learning Objectives

After completing this lab, you will be able to:
1. Use memory load instructions (`LDRB`)
2. Use memory store instructions (`STRB`)
3. Implement loops with conditional branches (`CBZ`, `B`)
4. Work with pointers in assembly

---

## Background

### Memory Operations

In Lab 00, you worked with registers only. Now you'll read and write to **memory**.

| Instruction | Syntax | Meaning |
|-------------|--------|---------|
| `LDRB` | `LDRB W2, [X0]` | Load a byte from memory address in X0 into W2 |
| `STRB` | `STRB W2, [X1]` | Store the byte in W2 to memory address in X1 |

### String Representation

A "string" in memory is just a sequence of bytes (characters) ending with a **null terminator** (value 0).

Example: The string "Hello" in memory:
```
Address:  0x50  0x51  0x52  0x53  0x54  0x55
Value:    'H'   'e'   'l'   'l'   'o'   0x00  ← null terminator
          72    101   108   108   111    0
```

### The STRCPY Algorithm

```
1. Load byte from source address
2. Store byte to destination address
3. If byte was 0 (null terminator), we're done
4. Otherwise, increment both pointers and repeat
```

---

## Your Task

Open `test_STRCPY.s` and complete the TODO sections to implement the string copy loop.

### Memory Layout

| Location | Address | Content |
|----------|---------|---------|
| Source string | 0x50 (80 decimal) | "Hello" |
| Destination buffer | 0x13C (316 decimal) | Empty space |

### What You Need to Do

1. **Exercise 1:** Load a byte from source into W2 using `LDRB`
2. **Exercise 2:** Store that byte to destination using `STRB`
3. **Exercise 3:** Check if it's the null terminator using `CBZ`
4. **Exercise 4:** Increment both pointers using `ADD`
5. **Exercise 5:** Loop back using `B`

---

## Step-by-Step Instructions

### Step 1: Understand the Starter Code

The file already has:
- `MOV X0, #0x50` — X0 points to source string
- `MOV X1, #0x13C` — X1 points to destination
- A `copy_loop:` label for the loop
- A `done:` label with `YIELD`

### Step 2: Implement the Loop

Add these instructions in the TODO sections:

```asm
copy_loop:
    LDRB    W2, [X0]      // Load byte from source
    STRB    W2, [X1]      // Store byte to destination
    CBZ     W2, done      // If byte is 0, we're done
    ADD     X0, X0, #1    // Move source pointer forward
    ADD     X1, X1, #1    // Move destination pointer forward
    B       copy_loop     // Repeat
```

### Step 3: Build and Run

```bash
make sim_lab01
```

### Step 4: Verify Success

You should see:
```
[EDUCORE LOG]: Apollo has landed
```

### Step 5: Check Waveforms (Optional)

Open `dump.vcd` in Surfer and verify:
- X0 ends at a value past 0x50
- X1 ends at a value past 0x13C
- Memory at 0x13C now contains "Hello"

---

## Understanding the Instructions

### LDRB W2, [X0]

- `LDRB` = Load Register Byte
- `W2` = 32-bit destination register (lower 32 bits of X2)
- `[X0]` = Memory address stored in X0

This reads ONE BYTE from the memory address in X0 and puts it in W2.

### STRB W2, [X1]

- `STRB` = Store Register Byte
- `W2` = Source register
- `[X1]` = Memory address stored in X1

This writes ONE BYTE from W2 to the memory address in X1.

### CBZ W2, done

- `CBZ` = Compare and Branch if Zero
- `W2` = Register to check
- `done` = Label to jump to if W2 equals 0

If W2 is 0 (null terminator), jump to the `done` label.

### B copy_loop

- `B` = Branch (unconditional jump)
- `copy_loop` = Label to jump to

Always jump back to the start of the loop.

---

## Common Mistakes

### Wrong register size
```asm
LDRB    X2, [X0]    // ❌ WRONG - use W2 for byte operations
LDRB    W2, [X0]    // ✅ CORRECT
```

### Forgetting to increment pointers
```asm
// ❌ Infinite loop - pointers never move!
copy_loop:
    LDRB    W2, [X0]
    STRB    W2, [X1]
    CBZ     W2, done
    B       copy_loop

// ✅ CORRECT - increment both pointers
copy_loop:
    LDRB    W2, [X0]
    STRB    W2, [X1]
    CBZ     W2, done
    ADD     X0, X0, #1
    ADD     X1, X1, #1
    B       copy_loop
```

### Checking for null BEFORE storing
```asm
// ❌ WRONG - doesn't copy the null terminator
copy_loop:
    LDRB    W2, [X0]
    CBZ     W2, done      // Jumps before storing!
    STRB    W2, [X1]
    ...

// ✅ CORRECT - store first, then check
copy_loop:
    LDRB    W2, [X0]
    STRB    W2, [X1]      // Store happens first
    CBZ     W2, done      // Then check
    ...
```

---

## Submission

When your code works:

```bash
git add .
git commit -m "Completed Lab 01"
git push
```

The autograder will verify that your STRCPY implementation is correct.

---

## Quick Reference

```asm
LDRB    W2, [X0]      // Load byte from memory
STRB    W2, [X1]      // Store byte to memory
CBZ     W2, label     // Branch if W2 == 0
ADD     X0, X0, #1    // Increment pointer
B       label         // Unconditional branch
```

---

## Next Steps

After completing Lab 01, you'll be ready for Lab 02 where you'll learn about more complex data structures and operations!
