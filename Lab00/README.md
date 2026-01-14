# Lab 00: Introduction to ARM Assembly

## Overview

Welcome to your first ARM assembly lab! In this lab, you will:
- Learn the basic development workflow
- Write simple ARM64 instructions
- Verify your code runs correctly
- Submit your work for grading

**Estimated Time:** 30-45 minutes

---

## Background: What is ARM Assembly?

ARM is a processor architecture used in billions of devices — from smartphones to servers. Assembly language lets you write instructions that the processor executes directly.

### Key Concepts

| Concept | Description |
|---------|-------------|
| **Registers** | Fast storage locations inside the processor (X0-X30) |
| **Instructions** | Commands that tell the processor what to do |
| **Immediate Values** | Numbers written directly in your code (prefixed with #) |

### Instructions You'll Use

| Instruction | Syntax | Meaning |
|-------------|--------|---------|
| `MOV` | `MOV X0, #42` | Load the value 42 into register X0 |
| `ADD` | `ADD X2, X0, X1` | X2 = X0 + X1 |
| `SUB` | `SUB X3, X0, X1` | X3 = X0 - X1 |
| `YIELD` | `YIELD` | Signal that the program is finished |

---

## Step 1: Open the Assembly File

Open `hello_arm.s` in this folder. You'll see:
- **Part 1:** Example code that's already written for you
- **Part 2:** Four exercises you need to complete

---

## Step 2: Read the Example Code

Look at Part 1 of the file:

```asm
MOV     X0, #10         // X0 = 10
MOV     X1, #5          // X1 = 5
ADD     X2, X0, X1      // X2 = 10 + 5 = 15
```

This code:
1. Puts the number 10 into register X0
2. Puts the number 5 into register X1
3. Adds them together and stores 15 in register X2

---

## Step 3: Complete the Exercises

Now complete the four exercises in Part 2:

### Exercise 1: Load a Value
Write a `MOV` instruction to put the value 25 into register X3.

### Exercise 2: Addition
Write an `ADD` instruction to add X2 and X3, storing the result in X4.
(The result should be 15 + 25 = 40)

### Exercise 3: Subtraction
Write a `SUB` instruction to subtract X1 from X0, storing the result in X5.
(The result should be 10 - 5 = 5)

### Exercise 4: Make X6 = 100
Use any combination of MOV, ADD, and SUB to make register X6 equal exactly 100.

---

## Step 4: Build and Run

Open the terminal in VS Code (Terminal → New Terminal) and run:

```bash
make sim_lab00
```

### What You Should See

If your code is correct:
```
[BUILD] Assembling Lab00/hello_arm.s...
[BUILD] Generated Lab00/hello_arm.mem
[HW] Compiling Educore Verilog...
[HW] Educore compiled to test_Educore.vvp
[SIM] Running Lab 00 simulation...
[EDUCORE LOG]: Test case: Lab00/hello_arm.mem
[EDUCORE LOG]: Apollo has landed
```

The message **"Apollo has landed"** means your program ran without errors!

### If You See an Error

- **"Houston, we got a problem"** → There's a bug in your code. Check your syntax.
- **Build error** → Check for typos in instruction names or register numbers.

---

## Step 5: Verify with Waveforms

To see exactly what happened inside the processor:

1. Look for `dump.vcd` in the file explorer
2. Click on it to open in Surfer (waveform viewer)
3. In the left panel, expand: `test_Educore → educore → register_file`
4. Click on signals like `R[0]`, `R[1]`, etc. to add them to the view

### Expected Values

| Register | Expected Value | Hex |
|----------|----------------|-----|
| X0 | 10 | 0x0A |
| X1 | 5 | 0x05 |
| X2 | 15 | 0x0F |
| X3 | 25 | 0x19 |
| X4 | 40 | 0x28 |
| X5 | 5 | 0x05 |
| X6 | 100 | 0x64 |

---

## Step 6: Submit Your Work

When you're satisfied with your code:

```bash
git add .
git commit -m "Completed Lab 00"
git push
```

The autograder will automatically run and verify your submission.

---

## Troubleshooting

### "Command not found"
The tools haven't installed yet. Wait a minute and try again, or run:
```bash
sudo apt-get update && sudo apt-get install -y iverilog gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
```

### "Houston, we got a problem"
Your program hit an error. Common causes:
- Typo in an instruction name (use MOV, not MOVE)
- Wrong register format (use X0, not R0)
- Missing the YIELD instruction at the end

### Simulation runs forever
Your program didn't reach the YIELD instruction. Make sure you didn't accidentally delete it!

---

## Quick Reference

```asm
// Load immediate value into register
MOV     X0, #42         // X0 = 42

// Add two registers
ADD     X2, X0, X1      // X2 = X0 + X1

// Subtract two registers
SUB     X3, X0, X1      // X3 = X0 - X1

// Signal program completion
YIELD
```

---

## Next Steps

Once you complete Lab 00, you're ready for **Lab 01: String Copy (STRCPY)**, where you'll learn about memory access and loops!
