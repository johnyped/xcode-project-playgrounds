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
class LocalizedDecoder {
    
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
    
    // MARK: - Main Function for Shell Script
    func run() {
        do {
            // Get the current directory where the script is located
            let currentDirectory = FileManager.default.currentDirectoryPath
            let jsonFilePath = "\(currentDirectory)/variables.json"
            
            // Check if variables.json exists
            guard FileManager.default.fileExists(atPath: jsonFilePath) else {
                print("Error: variables.json not found in current directory: \(currentDirectory)")
                return
            }
            
            // Read the JSON file
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            
            // Decode the data
            let (languages, keyPaths) = try decodeLocalizedData(from: jsonData)
            
            // Print results
            printResults(languages: languages, keyPaths: keyPaths)
            
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
let decoder = LocalizedDecoder()
decoder.run()
