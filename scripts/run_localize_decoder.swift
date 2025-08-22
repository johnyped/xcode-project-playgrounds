#!/usr/bin/env swift

import Foundation

// MARK: - Data Structures
struct LanguageMode: Codable {
    let key: String
    let name: String
}

struct CollectionMetadata: Codable {
    let name: String
    let figmaId: String
    let modes: [LanguageMode]
}

struct VariableMetadata: Codable {
    let name: String
    let figmaId: String
    let modes: [String: String]
}

struct LocalizedItem: Codable {
    let type: String
    let value: String
    let description: String
    let variableMetadata: VariableMetadata
    
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case value = "$value"
        case description = "$description"
        case variableMetadata = "$variable_metadata"
    }
}

struct LocalizedKeyPath: Codable {
    let paths: [String]
    let key: String
    let modes: [String: String]
}

struct LocalizedData {
    let localized: [String: Any]
    
    init(from jsonData: Data) throws {
        guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let localized = json["@localized"] as? [String: Any] else {
            throw LocalizedDecoderError.invalidJSONStructure
        }
        self.localized = localized
    }
}

// MARK: - LocalizedDecoder Class
/// A Swift-based localization tool that processes JSON files and generates:
/// 1. Localized.swift - Swift structs with localization keys
/// 2. Localizable.xcstrings - Xcode localization file with format placeholder conversion
/// 
/// Features:
/// - Automatically converts format placeholders like {1}, {2} to %@ for .xcstrings compatibility
/// - Generates nested structs with proper CamelCase naming
/// - Supports multiple languages (en, th, my)
/// - Handles complex nested JSON structures
class LocalizedDecoder {
    
    // MARK: - Configuration
    struct Config {
        let inputFilePath: String
        let localizedSwiftOutputPath: String
        let xcstringsOutputPath: String
        
        init(
            inputFilePath: String = "variables.json",
            localizedSwiftOutputPath: String = "Localized.swift",
            xcstringsOutputPath: String = "Localizable.xcstrings"
        ) {
            self.inputFilePath = inputFilePath
            self.localizedSwiftOutputPath = localizedSwiftOutputPath
            self.xcstringsOutputPath = xcstringsOutputPath
        }
    }
    
    private let config: Config
    
    init(config: Config = Config()) {
        self.config = config
    }
    
    // MARK: - Main Decoder Function
    func decodeLocalizedData(from jsonData: Data) throws -> (languages: [String], keyPaths: [LocalizedKeyPath]) {
        // First, decode the collection metadata to get available languages
        let collectionMetadata = try extractCollectionMetadata(from: jsonData)
        let availableLanguages = extractAvailableLanguages(from: collectionMetadata)
        
        // Then extract all localized key paths
        let localizedKeyPaths = try extractLocalizedKeyPaths(from: jsonData)
        
        return (availableLanguages, localizedKeyPaths)
    }
    
    // MARK: - Extract Collection Metadata
    private func extractCollectionMetadata(from jsonData: Data) throws -> CollectionMetadata {
        guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let localized = json["@localized"] as? [String: Any],
              let collectionMetadata = localized["$collection_metadata"] as? [String: Any],
              let modesData = collectionMetadata["modes"] as? [[String: Any]] else {
            throw LocalizedDecoderError.invalidJSONStructure
        }
        
        let modes = try modesData.map { modeDict -> LanguageMode in
            guard let key = modeDict["key"] as? String,
                  let name = modeDict["name"] as? String else {
                throw LocalizedDecoderError.invalidModeStructure
            }
            return LanguageMode(key: key, name: name)
        }
        
        return CollectionMetadata(
            name: collectionMetadata["name"] as? String ?? "",
            figmaId: collectionMetadata["figmaId"] as? String ?? "",
            modes: modes
        )
    }
    
    // MARK: - Extract Available Languages
    private func extractAvailableLanguages(from metadata: CollectionMetadata) -> [String] {
        return metadata.modes.map { $0.key }
    }
    
    // MARK: - Extract Localized Key Paths
    private func extractLocalizedKeyPaths(from jsonData: Data) throws -> [LocalizedKeyPath] {
        guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let localized = json["@localized"] as? [String: Any] else {
            throw LocalizedDecoderError.invalidJSONStructure
        }
        
        var keyPaths: [LocalizedKeyPath] = []
        
        for (sectionKey, sectionValue) in localized {
            if sectionKey == "$collection_metadata" { continue }
            
            if let sectionDict = sectionValue as? [String: Any] {
                // Remove '$' prefix from section key before adding to path
                let cleanSectionKey = sectionKey.hasPrefix("$") ? String(sectionKey.dropFirst()) : sectionKey
                let sectionPaths = traverseAndExtractPaths(from: sectionDict, currentPath: [cleanSectionKey])
                keyPaths.append(contentsOf: sectionPaths)
            }
        }
        
        return keyPaths
    }
    
    // MARK: - Recursive Traversal
    private func traverseAndExtractPaths(from dict: [String: Any], currentPath: [String]) -> [LocalizedKeyPath] {
        var keyPaths: [LocalizedKeyPath] = []
        
        for (key, value) in dict {
            if let itemDict = value as? [String: Any] {
                // Remove '$' prefix from key before adding to path
                let cleanKey = key.hasPrefix("$") ? String(key.dropFirst()) : key
                let newPath = currentPath + [cleanKey]
                
                // Check if this item has variable metadata with modes
                if let variableMetadata = itemDict["$variable_metadata"] as? [String: Any],
                   let modes = variableMetadata["modes"] as? [String: String] {
                    
                    // Generate key from full path (join with dots)
                    let fullKey = newPath.joined(separator: ".")
                    
                    // For paths, remove the last value (as per requirements)
                    let pathsForStruct = newPath.count > 1 ? Array(newPath.dropLast()) : newPath
                    
                    // Handle edge case: if paths is empty, insert "Other"
                    let finalPaths = pathsForStruct.isEmpty ? ["Other"] : pathsForStruct
                    
                    let keyPath = LocalizedKeyPath(paths: finalPaths, key: fullKey, modes: modes)
                    keyPaths.append(keyPath)
                } else {
                    // Recursively traverse deeper
                    let deeperPaths = traverseAndExtractPaths(from: itemDict, currentPath: newPath)
                    keyPaths.append(contentsOf: deeperPaths)
                }
            }
        }
        
        return keyPaths
    }
    
    // MARK: - Print Results
    func printResults(languages: [String], keyPaths: [LocalizedKeyPath]) {
        print("=== Localized Decoder Results ===")
        print()
        
        print("Available Languages:")
        print("allAvailableKeys = \(languages)")
        print()
        
        print("Localized Key Paths:")
        for (index, keyPath) in keyPaths.enumerated() {
            print("localizedKeyPath[\(index)].paths = \(keyPath.paths)")
            print("localizedKeyPath[\(index)].key = \(keyPath.key)")
            print("localizedKeyPath[\(index)].modes = Modes(modes: \(keyPath.modes))")
            print()
        }
    }
    
    // MARK: - Generate Localized.swift
    func generateLocalizedSwift(keyPaths: [LocalizedKeyPath]) -> String {
        var swiftCode = """
        //
        //  Localized.swift
        //  Generated by LocalizeDecoder
        //
        //  This file contains localization keys for mapping within Localizable.xcstrings
        //
        
        struct Localized {
        
        """
        
        // Build the tree structure
        let rootNodes = buildTree(from: keyPaths)
        
        // Generate Swift code from the tree
        for (_, rootNode) in rootNodes.sorted(by: { $0.key < $1.key }) {
            swiftCode += "\n"
            swiftCode += generateSwiftCode(from: rootNode, indent: "   ")
        }
        
        swiftCode += "}\n"
        return swiftCode
    }
    
    // MARK: - Helper Functions
    private func toCamelCase(_ string: String) -> String {
        let components = string.components(separatedBy: "_")
        let firstComponent = components.first ?? ""
        let remainingComponents = components.dropFirst()
        
        let camelCase = firstComponent + remainingComponents.map { $0.prefix(1).uppercased() + $0.dropFirst() }.joined()
        return camelCase
    }
    
    private func toPascalCase(_ string: String) -> String {
        let components = string.components(separatedBy: "_")
        let pascalCase = components.map { $0.prefix(1).uppercased() + $0.dropFirst() }.joined()
        return pascalCase
    }
    
    /// Converts format placeholders like {1}, {2}, {n} to %@ format for .xcstrings compatibility
    /// Examples:
    /// - "{1} นาที" → "%@ นาที"
    /// - "Next Episode in {2} seconds.." → "Next Episode in %@ seconds.."
    /// - "Live Time {1}" → "Live Time %@"
    private func convertFormatPlaceholders(_ string: String) -> String {
        // Convert format placeholders like {1}, {2}, {n} to %@
        // This regex matches { followed by one or more digits followed by }
        let pattern = "\\{\\d+\\}"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: string.utf16.count)
            let converted = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "%@")
            
            // Log conversion if any placeholders were found and converted
            if converted != string {
                print("   🔄 Format conversion: \"\(string)\" → \"\(converted)\"")
            }
            
            return converted
        } catch {
            print("   ⚠️  Warning: Failed to convert format placeholders in \"\(string)\": \(error)")
            return string
        }
    }
    
    // MARK: - Tree Structure for Nested Structs
    private class LocalizedNode {
        let name: String
        var properties: [String: String] = [:]
        var children: [String: LocalizedNode] = [:]
        
        init(name: String) {
            self.name = name
        }
        
        var hasContent: Bool {
            return !properties.isEmpty || !children.isEmpty
        }
    }
    
    // MARK: - Generate Localizable.xcstrings
    func generateLocalizableXcstrings(keyPaths: [LocalizedKeyPath], languages: [String]) -> String {
        var xcstrings = """
        {
          "sourceLanguage" : "en",
          "strings" : {
        
        """
        
        for (index, keyPath) in keyPaths.enumerated() {
            xcstrings += """
            
                "\(keyPath.key)" : {
                  "extractionState" : "manual",
                  "localizations" : {
            
            """
            
            // Add each language
            for (langIndex, language) in languages.enumerated() {
                let value = keyPath.modes[language] ?? ""
                // Convert format placeholders like {1}, {2} to %@
                let convertedValue = convertFormatPlaceholders(value)
                let escapedValue = convertedValue.replacingOccurrences(of: "\"", with: "\\\"")
                    .replacingOccurrences(of: "\n", with: "\\n")
                
                xcstrings += """
                        "\(language)" : {
                          "stringUnit" : {
                            "state" : "translated",
                            "value" : "\(escapedValue)"
                          }
                        }\(langIndex < languages.count - 1 ? "," : "")
                
                """
            }
            
            xcstrings += """
                  }
                }\(index < keyPaths.count - 1 ? "," : "")
            """
        }
        
        xcstrings += """
        
          },
          "version" : "1.0"
        }
        """
        
        return xcstrings
    }
    
    // MARK: - Tree Building and Code Generation
    private func buildTree(from keyPaths: [LocalizedKeyPath]) -> [String: LocalizedNode] {
        var rootNodes: [String: LocalizedNode] = [:]
        
        for keyPath in keyPaths {
            let paths = keyPath.paths
            let key = keyPath.key
            
            // Handle edge case: if paths is empty, insert "Other"
            let finalPaths = paths.isEmpty ? ["Other"] : paths
            
            // Build the tree structure
            var currentNode: LocalizedNode?
            
            for (index, pathComponent) in finalPaths.enumerated() {
                let cleanPathComponent = pathComponent.hasPrefix("$") ? String(pathComponent.dropFirst()) : pathComponent
                let pascalCaseName = toPascalCase(cleanPathComponent)
                
                if index == 0 {
                    // Root level - work directly with rootNodes
                    if let existingNode = rootNodes[pascalCaseName] {
                        currentNode = existingNode
                    } else {
                        let newNode = LocalizedNode(name: pascalCaseName)
                        rootNodes[pascalCaseName] = newNode
                        currentNode = newNode
                    }
                } else {
                    // Deeper level - work with children
                    if let existingNode = currentNode?.children[pascalCaseName] {
                        currentNode = existingNode
                    } else {
                        let newNode = LocalizedNode(name: pascalCaseName)
                        currentNode?.children[pascalCaseName] = newNode
                        currentNode = newNode
                    }
                }
                
                // If this is the last path component, add the property
                if index == finalPaths.count - 1 {
                    let keyName = toCamelCase(key.components(separatedBy: ".").last ?? "")
                    currentNode?.properties[keyName] = key
                }
            }
        }
        
        return rootNodes
    }
    
    private func generateSwiftCode(from node: LocalizedNode, indent: String = "") -> String {
        var swiftCode = ""
        
        // Generate struct declaration
        swiftCode += "\(indent)struct \(node.name) {\n"
        
        // Generate properties first
        for (propertyName, keyValue) in node.properties.sorted(by: { $0.key < $1.key }) {
            swiftCode += "\(indent)   static let \(propertyName) = \"\(keyValue)\"\n"
        }
        
        // Generate nested structs
        for (_, childNode) in node.children.sorted(by: { $0.key < $1.key }) {
            swiftCode += "\n"
            swiftCode += generateSwiftCode(from: childNode, indent: indent + "   ")
        }
        
        swiftCode += "\(indent)}\n"
        return swiftCode
    }
    
    // MARK: - Main Function for Shell Script
    func run() {
        do {
            // Get the current directory where the script is located
            let currentDirectory = FileManager.default.currentDirectoryPath
            let jsonFilePath = "\(currentDirectory)/\(config.inputFilePath)"
            
            // Check if input file exists
            guard FileManager.default.fileExists(atPath: jsonFilePath) else {
                print("Error: \(config.inputFilePath) not found in current directory: \(currentDirectory)")
                print("Please place \(config.inputFilePath) in the current directory or configure a different path")
                return
            }
            
            print("Found \(config.inputFilePath), reading...")
            
            // Read the JSON file
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            
            // Decode the data
            let (languages, keyPaths) = try decodeLocalizedData(from: jsonData)
            
            // Print results
            printResults(languages: languages, keyPaths: keyPaths)
            
            // Generate Localized.swift file
            print("\n=== Generating Localized.swift ===")
            let localizedSwift = generateLocalizedSwift(keyPaths: keyPaths)
            let swiftFilePath = "\(currentDirectory)/\(config.localizedSwiftOutputPath)"
            try localizedSwift.write(toFile: swiftFilePath, atomically: true, encoding: .utf8)
            print("✅ Localized.swift generated successfully at: \(swiftFilePath)")            
            
            // Generate Localizable.xcstrings file
            print("\n=== Generating Localizable.xcstrings ===")
            print("📝 Converting format placeholders (e.g., {1}, {2} → %@)...")
            let xcstrings = generateLocalizableXcstrings(keyPaths: keyPaths, languages: languages)
            let xcstringsFilePath = "\(currentDirectory)/\(config.xcstringsOutputPath)"
            try xcstrings.write(toFile: xcstringsFilePath, atomically: true, encoding: .utf8)
            print("✅ Localizable.xcstrings generated successfully at: \(xcstringsFilePath)")
            
        } catch {
            print("Error: \(error)")
        }
    }
}

// MARK: - Error Types
enum LocalizedDecoderError: Error, LocalizedError {
    case invalidJSONStructure
    case invalidModeStructure
    case fileNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidJSONStructure:
            return "Invalid JSON structure"
        case .invalidModeStructure:
            return "Invalid mode structure in collection metadata"
        case .fileNotFound:
            return "variables.json file not found"
        }
    }
}

// MARK: - Main Entry Point
func printUsage() {
    print("""
    LocalizeDecoder - Swift-based localization tool
    
    Usage:
        swift run_localize_decoder.swift [options]
    
    Options:
        -i, --input <path>           Input JSON file path (default: variables.json)
        -s, --swift <path>           Output Localized.swift path (default: Localized.swift)
        -x, --xcstrings <path>       Output Localizable.xcstrings path (default: Localizable.xcstrings)
        -h, --help                   Show this help message
    
    Examples:
        swift run_localize_decoder.swift
        swift run_localize_decoder.swift -i custom_variables.json
        swift run_localize_decoder.swift -s CustomLocalized.swift -x CustomLocalizable.xcstrings
        swift run_localize_decoder.swift --input /path/to/variables.json --swift /path/to/output.swift
    """)
}

func parseArguments() -> LocalizedDecoder.Config {
    var inputPath = "variables.json"
    var swiftPath = "Localized.swift"
    var xcstringsPath = "Localizable.xcstrings"
    
    let arguments = CommandLine.arguments
    var i = 1 // Skip script name
    
    while i < arguments.count {
        let arg = arguments[i]
        
        switch arg {
        case "-i", "--input":
            if i + 1 < arguments.count {
                inputPath = arguments[i + 1]
                i += 2
            } else {
                print("Error: Missing value for \(arg)")
                exit(1)
            }
        case "-s", "--swift":
            if i + 1 < arguments.count {
                swiftPath = arguments[i + 1]
                i += 2
            } else {
                print("Error: Missing value for \(arg)")
                exit(1)
            }
        case "-x", "--xcstrings":
            if i + 1 < arguments.count {
                xcstringsPath = arguments[i + 1]
                i += 2
            } else {
                print("Error: Missing value for \(arg)")
                exit(1)
            }
        case "-h", "--help":
            printUsage()
            exit(0)
        default:
            if arg.hasPrefix("-") {
                print("Error: Unknown option \(arg)")
                print("Use -h or --help for usage information")
                exit(1)
            }
            i += 1
        }
    }
    
    return LocalizedDecoder.Config(
        inputFilePath: inputPath,
        localizedSwiftOutputPath: swiftPath,
        xcstringsOutputPath: xcstringsPath
    )
}

// Parse command line arguments and create decoder
let config = parseArguments()
let decoder = LocalizedDecoder(config: config)
decoder.run()
