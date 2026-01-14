#!/bin/bash
# Lab 04 Autograder Test Script (Pipelined Processor)

echo "🔧 Building Pipelined Processor hardware..."
make build_pipeline
if [ $? -ne 0 ]; then
    echo "❌ FAILED: Could not compile Pipelined Verilog files"
    exit 1
fi

echo "🔧 Assembling Lab 04..."
make lab04
if [ $? -ne 0 ]; then
    echo "❌ FAILED: Could not assemble test_lab04.s"
    exit 1
fi

echo "🚀 Running simulation (Pipelined Processor)..."
output=$(make sim_lab04 2>&1)
echo "$output"

if echo "$output" | grep -q "Apollo has landed"; then
    echo ""
    echo "✅ SUCCESS: Lab 04 passed!"
    exit 0
else
    echo ""
    echo "❌ FAILED: Simulation did not complete successfully."
    exit 1
fi
