# Gen Localize - Localization Generator

A Swift-based localization tool that processes JSON files and generates:
1. **Localized.swift** - Swift structs with localization keys
2. **Localizable.xcstrings** - Xcode localization file with format placeholder conversion

## Features

- **Automatic Format Conversion**: Converts format placeholders like `{1}`, `{2}` to `%@` for `.xcstrings` compatibility
- **Nested Struct Generation**: Creates nested structs with proper CamelCase naming
- **Multi-language Support**: Supports multiple languages (en, th, my)
- **Complex JSON Handling**: Handles complex nested JSON structures
- **Xcode Ready**: Generates files that work seamlessly with Xcode

## Quick Start

### Using the Shell Script (Recommended)

```bash
# Basic usage with default files
./gen_localize.sh

# Custom input file
./gen_localize.sh -i custom_variables.json

# Custom output files
./gen_localize.sh -s CustomLocalized.swift -x CustomLocalizable.xcstrings

# Show help
./gen_localize.sh --help
```

### Using the Swift Script Directly

```bash
# Basic usage
swift gen_localize.swift

# Custom configuration
swift gen_localize.swift -i variables.json -s Localized.swift -x Localizable.xcstrings

# Show help
swift gen_localize.swift --help
```

## File Structure

```
scripts/
├── gen_localize.sh          # Main shell script runner
├── gen_localize.swift       # Swift localization generator
├── variables.json           # Input JSON file (place your file here)
├── Localized.swift          # Generated Swift structs
└── Localizable.xcstrings   # Generated Xcode localization file
```

## Input Format

The tool expects a JSON file with the following structure:

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
      "key_name": {
        "$variable_metadata": {
          "modes": {
            "en": "English text",
            "th": "Thai text",
            "my": "Burmese text"
          }
        }
      }
    }
  }
}
```

## Output Examples

### Localized.swift
```swift
struct Localized {
   struct TvNavigationDrawer {
        static let switchProfile = "tv_navigation_drawer.switch_profile"
        static let searchMenu = "tv_navigation_drawer.search_menu"
   }
   
   struct TvHomepage {
        static let premiumTv = "tv_homepage.premium_tv"
   }
}
```

### Localizable.xcstrings
```json
{
  "tv_navigation_drawer.switch_profile": {
    "extractionState": "manual",
    "localizations": {
      "en": {
        "stringUnit": {
          "state": "translated",
          "value": "Switch Profile"
        }
      },
      "th": {
        "stringUnit": {
          "state": "translated",
          "value": "สลับโปรไฟล์"
        }
      }
    }
  }
}
```

## Format Placeholder Conversion

The tool automatically converts format placeholders:
- `"{1} นาที"` → `"%@ นาที"`
- `"Next Episode in {2} seconds.."` → `"Next Episode in %@ seconds.."`
- `"Live Time {1}"` → `"Live Time %@"`

This ensures compatibility with Xcode's localization system.

## Requirements

- macOS with Swift 5.0+
- Bash shell
- Input JSON file in the same directory as the scripts

## Usage Examples

### Basic Generation
```bash
cd scripts
./gen_localize.sh
```

### Custom File Names
```bash
./gen_localize.sh -i my_variables.json -s MyLocalized.swift -x MyLocalizable.xcstrings
```

### Batch Processing
```bash
# Process multiple JSON files
for file in *.json; do
    ./gen_localize.sh -i "$file" -s "${file%.json}_Localized.swift" -x "${file%.json}_Localizable.xcstrings"
done
```

## Troubleshooting

- **File not found**: Ensure `variables.json` is in the same directory as the scripts
- **Permission denied**: Run `chmod +x gen_localize.sh` to make the script executable
- **Swift errors**: Ensure you have Swift 5.0+ installed (`swift --version`)

## License

This tool is part of the xcode-project-playgrounds project.
