#!/bin/bash

# Localized Decoder Runner Script
# This script runs the Swift-based localized decoder

echo "=== Localized Decoder Runner ==="
echo "Current directory: $(pwd)"
echo ""

# Check if variables.json exists
if [ ! -f "variables.json" ]; then
    echo "Error: variables.json not found in current directory"
    echo "Please place variables.json in the same directory as this script"
    exit 1
fi

echo "Found variables.json, running decoder..."
echo ""

# Run the Swift script
swift run_localize_decoder.swift

echo ""
echo "=== Decoder completed ==="
