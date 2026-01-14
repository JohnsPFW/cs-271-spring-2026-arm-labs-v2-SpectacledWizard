# Lab 04: Pipeline Hazards

## Overview

In this lab, you will explore how a **pipelined processor** executes instructions and learn to identify **data hazards**. This is a critical concept in computer architecture!

**Prerequisites:** Complete Labs 00-03 first!

**Estimated Time:** 60-90 minutes

---

## ⚠️ Important: Different Processor!

This lab uses a **PIPELINED** processor, not the single-cycle processor from Labs 00-03!

| Single-Cycle (Labs 00-03) | Pipelined (Lab 04) |
|--------------------------|-------------------|
| One instruction at a time | Multiple instructions in-flight |
| CPI = 1 (but slow clock) | CPI ≈ 1 (with faster clock) |
| Simple | Complex (hazards!) |

---

## Learning Objectives

After completing this lab, you will be able to:
1. Explain the 5 stages of a pipeline (Fetch, Decode, Execute, Memory, Writeback)
2. Identify Read-After-Write (RAW) data hazards
3. Understand how forwarding (bypassing) resolves hazards
4. Analyze pipeline behavior using waveforms
5. Calculate CPI (Cycles Per Instruction)

---

## Background

### The 5-Stage Pipeline

```
┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐
│  Fetch  │→│  Decode │→│ Execute │→│  Memory │→│Writeback│
└─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘
     IF          ID          EX          MEM          WB
```

Each clock cycle, instructions move one stage to the right. This means 5 instructions can be "in-flight" simultaneously!

### The Pipeline Hazard Problem

Consider these two instructions:
```asm
ADD     X9, X1, X2      // Cycle 1: Compute X9
AND     X10, X9, X3     // Cycle 2: Use X9 ← But X9 isn't written yet!
```

When AND needs X9 in cycle 2:
- ADD is still in the Execute stage
- X9 won't be written until cycle 5 (Writeback)

This is called a **RAW (Read-After-Write) Hazard**.

### Solutions to Hazards

| Solution | Description | Penalty |
|----------|-------------|---------|
| **Stalling** | Wait for the value to be ready | Adds bubble cycles |
| **Forwarding** | Bypass result directly from EX or MEM stage | No penalty (if hardware supports it) |
| **NOP insertion** | Programmer adds NOPs to wait | Wastes instruction slots |

---

## Your Task

### Step 1: Read the Code

Open `test_lab04.s` and understand each section:
- Part 1: Independent instructions (no hazards)
- Part 2: Simple dependencies
- Part 3: RAW hazard example
- Part 4: NOPs for timing

### Step 2: Run the Simulation

```bash
make sim_lab04
```

**Note:** Lab 04 uses a different Makefile target that compiles the pipelined processor.

### Step 3: Analyze Waveforms

Open `dump.vcd` in Surfer and observe:
1. When each instruction enters each pipeline stage
2. How the pipeline handles the X9 dependency
3. The timing of register writes

### Step 4: Answer the Analysis Questions

The questions are at the bottom of `test_lab04.s`. Write your answers there.

---

## Waveform Analysis Guide

### Key Signals to Observe

| Signal | What It Shows |
|--------|---------------|
| `clk` | Clock cycles |
| `pc` | Program Counter (instruction address) |
| `IF_instruction` | Instruction in Fetch stage |
| `ID_instruction` | Instruction in Decode stage |
| `EX_instruction` | Instruction in Execute stage |
| `register_file.R[9]` | Value of X9 over time |

### Counting Cycles

1. Find when the first instruction enters Fetch
2. Find when YIELD completes Writeback
3. The difference is total execution cycles

---

## Analysis Questions

Answer these in `test_lab04.s` or on paper:

1. **Hazard Timing:** In Part 3, how many cycles between when X9 is computed and when X10 uses it?

2. **Hazard Resolution:** Does the pipeline stall or forward to handle the RAW hazard?

3. **Result Values:** What are the final values of X10, X11, and X12?

4. **Without Forwarding:** If the processor didn't have forwarding, how many NOPs would you need between ADD and AND?

5. **CPI Calculation:** Count total cycles from _start to YIELD. Divide by number of instructions. What is the CPI?

---

## Expected Values

| Register | Expected Value | Notes |
|----------|---------------|-------|
| X0 | 0xF (15) | |
| X1 | 0xE (14) | |
| X2 | 0xD (13) | |
| X3 | 0xC (12) | |
| X4 | 0xB (11) | |
| X5 | 0x10 (16) | X0 + 1 |
| X6 | 0x1B (27) | X1 + X2 |
| X7 | 0x1 (1) | X0 - X1 |
| X9 | 0x1B (27) | X1 + X2 |
| X10 | ? | X9 AND X3 |
| X11 | ? | X5 OR X9 |
| X12 | ? | X9 - X7 |

---

## Submission

```bash
git add .
git commit -m "Completed Lab 04"
git push
```

---

## Further Reading

- Patterson & Hennessy, Chapter 4: The Processor
- ARM Architecture Reference Manual: Pipeline descriptions
