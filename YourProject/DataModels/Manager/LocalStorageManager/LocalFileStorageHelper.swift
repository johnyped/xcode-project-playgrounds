//
//  LocalFileStorageHelper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//


import Foundation

// MARK: - LocalFileStorageHelperable

protocol LocalFileStorageHelperable {
    func load(from: URL) throws -> Data?
    func loadFromDocumentDirectory(fileName: String) throws -> Data?
    func save(fileName: String,
              file: Data) throws
}

// MARK: - LocalFileStorageHelper

class LocalFileStorageHelper: LocalFileStorageHelperable {
    func load(from: URL) throws -> Data? {
        try Data(contentsOf: from)
    }

    func loadFromDocumentDirectory(fileName: String) throws -> Data? {
        guard
            let dir = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask).first
        else { return nil }

        let fileURL = dir.appendingPathComponent(fileName)
        return try load(from: fileURL)
    }

    func save(fileName: String,
              file: Data) throws {
        guard
            let dir = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask).first
        else { return }

        let fileURL = dir.appendingPathComponent(fileName)
        try file.write(to: fileURL)
    }
}
