//
//  JsonFile.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import Foundation

class JsonFile {
    
    let filePath: String   // fixture Path
    
    init(path: String) {
        filePath = path
    }
    
    func data(from fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.url(forResource: "\(filePath)/\(fileName)",
            withExtension: "json") else {
            print("File not found: \(filePath)/\(fileName).json")
            return nil
        }
        
        guard let data = try? Data(contentsOf: path) else {
            print("Failed to transform fixture file name: \(filePath)/\(fileName) to data")
            return nil
        }
        
        return data
    }
    
    func data(fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.url(forResource: "\(filePath)/\(fileName)",
            withExtension: "json")
        else {
            print("File not found: \(filePath)/\(fileName).json")
            throw NSError(domain: "File not found",
                          code: 0,
                          userInfo: nil)
        }
                
        return try Data(contentsOf: path)
    }
}

class FileHelper {
    enum FixtureError: Error {
        case resourceNotFound
    }
    
    static let shared = FileHelper()
    
    func data(fromResource name: String,
              withExtension ext: String = "json") throws -> Data {
        return try fixturesDataFrom(forResource: name,
                                    withExtension: ext)
    }
}

private extension FileHelper {
    func fixturesDataFrom(forResource name: String,
                          withExtension ext: String = "json") throws -> Data {
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
           let bundle = Bundle(identifier: bundleIdentifier),
           let path = bundle.url(forResource: name,
                                 withExtension: ext) {
            return try Data(contentsOf: path)
        }

        let bundle = Bundle(for: type(of: self))

        if let path = bundle.url(forResource: name,
                                 withExtension: ext) {
            return try Data(contentsOf: path)
        }

        throw FixtureError.resourceNotFound
    }
}
