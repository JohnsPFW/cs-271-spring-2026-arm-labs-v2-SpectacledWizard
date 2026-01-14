#!/bin/bash
# Lab 03 Autograder Test Script

echo "🔧 Building Educore hardware..."
make build_educore
if [ $? -ne 0 ]; then
    echo "❌ FAILED: Could not compile Verilog files"
    exit 1
fi

echo "🔧 Assembling Lab 03..."
make lab03
if [ $? -ne 0 ]; then
    echo "❌ FAILED: Could not assemble test_lab03.s"
    exit 1
fi

echo "🚀 Running simulation..."
output=$(make sim_lab03 2>&1)
echo "$output"

if echo "$output" | grep -q "Apollo has landed"; then
    echo ""
    echo "✅ SUCCESS: Lab 03 passed!"
    exit 0
else
    echo ""
    echo "❌ FAILED: Simulation did not complete successfully."
    exit 1
fi
