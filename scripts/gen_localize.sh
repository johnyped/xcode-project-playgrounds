#!/bin/bash

# Gen Localize - Localization Generator Script
# This script runs the Swift-based localization generator

echo "=== Gen Localize - Localization Generator ==="
echo "Current directory: $(pwd)"
echo ""

# Default values
INPUT_FILE="variables.json"
SWIFT_OUTPUT="Localized.swift"
XCSTRINGS_OUTPUT="Localizable.xcstrings"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input)
            INPUT_FILE="$2"
            shift 2
            ;;
        -s|--swift)
            SWIFT_OUTPUT="$2"
            shift 2
            ;;
        -x|--xcstrings)
            XCSTRINGS_OUTPUT="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  -i, --input <file>       Input JSON file (default: variables.json)"
            echo "  -s, --swift <file>       Output Localized.swift file (default: Localized.swift)"
            echo "  -x, --xcstrings <file>   Output Localizable.xcstrings file (default: Localizable.xcstrings)"
            echo "  -h, --help               Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0"
            echo "  $0 -i custom_variables.json"
            echo "  $0 -s CustomLocalized.swift -x CustomLocalizable.xcstrings"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found in current directory"
    echo "Please place $INPUT_FILE in the same directory as this script"
    exit 1
fi

echo "Input file: $INPUT_FILE"
echo "Swift output: $SWIFT_OUTPUT"
echo "Xcstrings output: $XCSTRINGS_OUTPUT"
echo ""

echo "Found $INPUT_FILE, running decoder..."
echo ""

# Run the Swift script with configuration
swift gen_localize.swift -i "$INPUT_FILE" -s "$SWIFT_OUTPUT" -x "$XCSTRINGS_OUTPUT"

echo ""
echo "=== Localization generation completed ==="
