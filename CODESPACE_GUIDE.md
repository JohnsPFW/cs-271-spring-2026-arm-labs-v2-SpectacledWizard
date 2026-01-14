# Codespace Adaptation Guide

## How This Environment Differs from the Original Tutorials

The ARM Education Kit tutorials were written for specific development tools (Keil MDK, ARM DS-5, or ModelSim). In this course, we use **GitHub Codespaces** which provides a free, browser-based development environment. This guide explains what's different.

---

## Quick Reference: Command Translation

| Tutorial Says... | In Codespaces, Do This Instead |
|------------------|-------------------------------|
| "Open Keil MDK" or "Open DS-5" | Open your Codespace (already done!) |
| "Create a new project" | Not needed — project is pre-configured |
| "Build the project" | `make lab00` or `make lab01` |
| "Run the simulation" | `make sim_lab00` or `make sim_lab01` |
| "Open the waveform viewer" | Click on the `.vcd` file in VS Code |
| "Set breakpoints" | Not available — use waveform viewer instead |
| "Use the debugger" | Not available — use `$display` statements in Verilog |

---

## Tool Equivalents

| Original Tool | Codespaces Equivalent | Purpose |
|--------------|----------------------|---------|
| Keil MDK / ARM DS-5 | VS Code + GCC Cross-Compiler | Write and assemble ARM code |
| ModelSim / Vivado | Icarus Verilog (`iverilog`) | Simulate the processor |
| GTKWave | Surfer (VS Code extension) | View waveforms |
| Built-in debugger | Waveform analysis | Debug your code |

---

## Step-by-Step Differences

### Lab 00: Getting Started

#### Original Tutorial
The tutorial likely asks you to:
1. Install Keil MDK or DS-5
2. Create a new project
3. Configure the target device
4. Write assembly code
5. Build and run on a simulator or board

#### Codespaces Version
Everything is pre-configured! Just:
1. Open your Codespace
2. Edit `Lab00/hello_arm.s`
3. Run: `make sim_lab00`
4. See "Apollo has landed" = success!

---

### Lab 01: String Copy (STRCPY)

#### Original Tutorial
1. Write assembly code in the IDE
2. Build the project
3. Run the simulation
4. Use the debugger to step through code
5. Check register values in the debugger

#### Codespaces Version
1. Edit `Lab01/test_STRCPY.s`
2. Run: `make sim_lab01`
3. View the waveform: click on `dump.vcd` in VS Code
4. Check register values in Surfer:
   - Look for `educore > register_file > R` signals
   - X0 should show `0x50`, X1 should show `0x13C`

---

## Understanding the Build Process

### What the Original Tools Do
```
Assembly File (.s) → Linker → Executable (.elf) → Debugger
```

### What Codespaces Does
```
Assembly File (.s) → Assembler → Object File (.o) → Memory File (.mem) → Verilog Simulation
```

#### Detailed Steps:
1. **Assemble**: `aarch64-linux-gnu-gcc -c -march=armv8-a file.s -o file.o`
   - The `-c` flag means "compile only, don't link"
   - We skip linking because we're loading directly into simulated memory

2. **Convert to Memory Format**: `aarch64-linux-gnu-objcopy -O verilog file.o file.mem`
   - Creates a hex file that the Verilog testbench can read

3. **Run Simulation**: `iverilog ... && vvp test_Educore.vvp +TEST_CASE=file.mem`
   - The Verilog processor reads your code from the `.mem` file
   - Executes it cycle-by-cycle
   - Generates waveform output

---

## Using the Waveform Viewer (Instead of Debugger)

Since we don't have a traditional debugger, you'll use waveforms to see what's happening inside the processor.

### Opening Waveforms
1. After running a simulation, a `dump.vcd` file is created
2. Click on it in VS Code's file explorer
3. It opens in the Surfer waveform viewer

### Key Signals to Watch

| Signal Path | What It Shows |
|-------------|---------------|
| `test_Educore > educore > pc` | Program Counter (current instruction address) |
| `test_Educore > educore > instruction_memory_v` | Current instruction being executed |
| `test_Educore > educore > register_file > R[0]` | Value in register X0 |
| `test_Educore > educore > register_file > R[1]` | Value in register X1 |
| `test_Educore > memory[80]` | Memory at address 0x50 (source string) |
| `test_Educore > memory[316]` | Memory at address 0x13C (destination) |

### Adding Signals to the View
1. In the left panel, expand the signal hierarchy
2. Click on a signal to add it to the waveform view
3. Zoom in/out with the scroll wheel
4. Click on a time point to see values at that cycle

---

## Common Issues and Solutions

### "Command not found: aarch64-linux-gnu-gcc"
**Problem**: Tools didn't install properly when Codespace was created.
**Solution**: Run manually:
```bash
sudo apt-get update && sudo apt-get install -y iverilog gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
```

### "Houston, we got a problem"
**Problem**: Your code hit an undefined instruction or error.
**Solution**: 
- Check for typos in instruction names
- Make sure registers are correct (X0-X30 for 64-bit, W0-W30 for 32-bit)
- Verify your loop terminates (reaches YIELD)

### Simulation runs forever
**Problem**: Infinite loop in your code.
**Solution**: 
- Press `Ctrl+C` to stop
- Check your branch conditions
- Make sure CBZ/CBNZ can actually branch out of the loop

### Can't see anything useful in waveforms
**Problem**: Signals not added to view.
**Solution**:
- Expand the hierarchy in Surfer's left panel
- Double-click on signals to add them
- Look for `educore > register_file` for register values

---

## Summary: What You DO and DON'T Need to Do

### ❌ You Do NOT Need To:
- Install any software
- Configure project settings
- Worry about linker scripts
- Set up a debugger
- Connect to hardware

### ✅ You DO Need To:
- Write ARM assembly code in the `.s` files
- Use `make` commands to build and run
- Analyze waveforms to debug your code
- Push your code to submit

---

## Makefile Commands Reference

```bash
make lab00      # Assemble Lab 00
make sim_lab00  # Run Lab 00 simulation
make lab01      # Assemble Lab 01
make sim_lab01  # Run Lab 01 simulation
make clean      # Remove all generated files
make help       # Show all available commands
```

---

## Need Help?

If something in the original tutorial doesn't make sense for Codespaces:
1. Check this guide first
2. Ask on the course discussion board
3. Office hours

Remember: The **concepts** in the tutorials are still valid — it's just the **tools** that are different!
