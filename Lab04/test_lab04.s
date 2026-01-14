// =============================================================================
// CS 271 Computer Architecture - Lab 04: Pipeline Hazards
// Purdue University Fort Wayne
// =============================================================================
// STUDENT NAME: ___________________
// DATE:         ___________________
// =============================================================================
// OBJECTIVE:
//   Understand how pipelining affects instruction execution and learn to
//   identify data hazards. You will observe how the pipelined processor
//   handles dependencies between instructions.
//
// IMPORTANT:
//   This lab uses a PIPELINED processor (not the single-cycle from Labs 00-03)!
//   The pipeline has stages: Fetch → Decode → Execute → Memory → Writeback
//
// =============================================================================

    .text
    .global _start

_start:
    // =========================================================================
    // PART 1: Independent Instructions (No Hazards)
    // =========================================================================
    // These instructions don't depend on each other's results.
    // They can flow through the pipeline efficiently.
    
    MOVZ    X0, #0xf            // X0 = 15
    MOVZ    X1, #0xe            // X1 = 14
    MOVZ    X2, #0xd            // X2 = 13
    MOVZ    X3, #0xc            // X3 = 12
    MOVZ    X4, #0xb            // X4 = 11
    
    // =========================================================================
    // PART 2: Simple Dependencies
    // =========================================================================
    // These instructions use results from previous instructions.
    // Q: Does the pipeline need to stall?
    
    ADD     X5, X0, #1          // X5 = X0 + 1 = 16
    ADD     X6, X1, X2          // X6 = X1 + X2 = 27
    SUBS    X7, X0, X1          // X7 = X0 - X1 = 1, sets flags
    
    // =========================================================================
    // PART 3: Read-After-Write (RAW) Hazard
    // =========================================================================
    // This is a DATA HAZARD: X9 is written then immediately read!
    //
    // Clock 1: ADD X9, X1, X2  - computes X9
    // Clock 2: AND X10, X9, X3 - needs X9 (but X9 isn't written back yet!)
    //
    // TODO: Observe in the waveform how the processor handles this.
    
_test2:
    ADD     X9, X1, X2          // X9 = X1 + X2 = 27
    AND     X10, X9, X3         // X10 = X9 AND X3 (HAZARD: X9 not ready!)
    ORR     X11, X5, X9         // X11 = X5 OR X9
    SUB     X12, X9, X7         // X12 = X9 - X7
    
    // =========================================================================
    // PART 4: NOPs for Pipeline Timing
    // =========================================================================
    // NOP (No Operation) instructions can be used to:
    // 1. Delay execution while waiting for data
    // 2. Align code for branch targets
    // 3. Observe pipeline behavior in waveforms
    
    NOP
    NOP
    NOP
    NOP
    
    // =========================================================================
    // COMPLETION
    // =========================================================================
    YIELD

// =============================================================================
// ANALYSIS QUESTIONS
// =============================================================================
//
// After running the simulation and viewing waveforms, answer these:
//
// 1. In Part 3, how many cycles does it take from when X9 is computed to
//    when X10 uses it?
//
// 2. Does the pipeline stall (wait) or forward (bypass) to handle the
//    RAW hazard on X9?
//
// 3. What values do you observe in X10, X11, and X12?
//
// 4. If the processor didn't have forwarding, how many NOPs would you
//    need to insert between the ADD and AND instructions?
//
// 5. Count the total cycles from _start to YIELD. How does this compare
//    to the number of instructions?
//
// =============================================================================
