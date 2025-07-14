//
//  DocumentFileWrapper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation

// MARK: - DocumentFileWrapper

@propertyWrapper
struct DocumentFileWrapper<T: Codable> {
    var wrappedValue: T {
        get {
            if let data = try? load(fileName: fileName),
               let value = try? JSONDecoder().decode(T.self,
                                                     from: data) {
                return value
            }

            return defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional,
               optional.isNil {
                try? remove(fileName: fileName)
            }
            else if let encoded = try? JSONEncoder().encode(newValue) {
                try? save(fileName: fileName,
                          data: encoded)
            }
        }
    }

    private let storage: FileManager
    private let fileName: String
    private let defaultValue: T

    init(wrappedValue defaultValue: T,
         key: String,
         storage: FileManager = .default) {
        self.defaultValue = defaultValue
        self.fileName = key
        self.storage = storage
    }
}

private extension DocumentFileWrapper {
    enum DocumentFileWrapperError: Error {
        case invalidFilePath
        case cannotOpen
    }

    func save(fileName: String,
              data: Data) throws {
        guard
            let dir = storage.urls(for: .documentDirectory,
                                   in: .userDomainMask).first
        else {
            throw DocumentFileWrapperError.invalidFilePath
        }

        let fileURL = dir.appendingPathComponent(fileName)

        try data.write(to: fileURL,
                       options: .completeFileProtection)

        print("\(fileURL) saved")
    }

    func remove(fileName: String) throws {
        guard
            let dir = storage.urls(for: .documentDirectory,
                                   in: .userDomainMask).first
        else {
            throw DocumentFileWrapperError.invalidFilePath
        }

        let fileURL = dir.deletingPathExtension().appendingPathComponent(fileName)

        try storage.removeItem(at: fileURL)

        print("\(fileURL) removed")
    }

    func load(fileName: String) throws -> Data {
        guard
            let dir = storage.urls(for: .documentDirectory,
                                   in: .userDomainMask).first
        else {
            throw DocumentFileWrapperError.invalidFilePath
        }

        let fileURL = dir.appendingPathComponent(fileName)

        print("\(fileURL) readed")

        return try Data(contentsOf: fileURL)
    }
}

extension DocumentFileWrapper where T: ExpressibleByNilLiteral {
    init(key: String,
         storage: FileManager = .default) {
        self.init(wrappedValue: nil,
                  key: key,
                  storage: storage)
    }
}
