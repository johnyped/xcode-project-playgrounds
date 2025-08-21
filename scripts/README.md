# Localized Decoder

A Swift-based tool for decoding and extracting localized strings from JSON files with configurable input and output paths.

## Overview

This tool reads a JSON file (default: `variables.json`) and extracts:
1. Available language keys from the collection metadata
2. All localized key paths with their corresponding translations

## Requirements

- macOS with Swift installed
- JSON file with the required structure (default: `variables.json`)

## Usage

### Option 1: Run the shell script (Recommended)

```bash
# Use default configuration
./run_decoder.sh

# Customize input and output files
./run_decoder.sh -i custom_variables.json -s CustomLocalized.swift -x CustomLocalizable.xcstrings

# Show help
./run_decoder.sh --help
```

### Option 2: Run the Swift script directly

```bash
# Use default configuration
swift run_localize_decoder.swift

# Customize input and output files
swift run_localize_decoder.swift -i custom_variables.json -s CustomLocalized.swift -x CustomLocalizable.xcstrings

# Show help
swift run_localize_decoder.swift --help
```

## Configuration Options

Both the shell script and Swift script support the following options:

- `-i, --input <file>` - Input JSON file path (default: `variables.json`)
- `-s, --swift <file>` - Output Localized.swift file path (default: `Localized.swift`)
- `-x, --xcstrings <file>` - Output Localizable.xcstrings file path (default: `Localizable.xcstrings`)
- `-h, --help` - Show help message

## Input Format

The tool expects a `variables.json` file with the following structure:

```json
{
  "@localized": {
    "$collection_metadata": {
      "modes": [
        {"key": "en", "name": "EN"},
        {"key": "th", "name": "TH"},
        {"key": "my", "name": "MY"}
      ]
    },
    "$section_name": {
      "item_name": {
        "$variable_metadata": {
          "modes": {
            "en": "English text",
            "th": "Thai text",
            "my": "Myanmar text"
          }
        }
      }
    }
  }
}
```

## Output Format

The tool outputs:

1. **Available Languages**: List of language keys found in the collection metadata
2. **Localized Key Paths**: Each localized item with its path and translations

Example output:
```
=== Localized Decoder Results ===

Available Languages:
allAvailableKeys = ["en", "th", "my"]

Localized Key Paths:
localizedKeyPath[0].paths = ["$tv_navigation_drawer", "switch_profile"]
localizedKeyPath[0].modes = Modes(modes: ["en": "Switch Profile", "th": "สลับโปรไฟล์", "my": "ပရိုဖိုင်ပြောင်းရန်"])
```

## Files

- `run_localize_decoder.swift` - Main Swift script
- `run_decoder.sh` - Shell script wrapper
- `variables.json` - Input JSON file (you need to provide this)
- `README.md` - This documentation

## How It Works

1. **JSON Parsing**: Uses native Swift JSONSerialization to parse the input file
2. **Metadata Extraction**: Extracts language information from collection metadata
3. **Recursive Traversal**: Walks through the JSON structure to find all localized items
4. **Path Building**: Constructs the full path to each localized item
5. **Output Generation**: Formats and displays the results

## Error Handling

The tool includes comprehensive error handling for:
- Missing `variables.json` file
- Invalid JSON structure
- Missing required fields in the JSON

## Integration with iOS Projects

The `LocalizeDecoder.swift` file in the iOS project provides the same functionality as a reusable class that can be integrated into iOS applications.
