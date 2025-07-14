//
//  KeyChainHelper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation
import KeychainSwift

// MARK: - KeychainHelperable

protocol KeychainHelperable {
    func get(key: String) -> String?
    func getBool(key: String) -> Bool?
    func getData(key: String) -> Data?

    @discardableResult
    func set(_ value: String,
             forKey key: String) -> Bool
    @discardableResult
    func set(_ value: Bool,
             forKey key: String) -> Bool
    @discardableResult
    func set(_ value: Data,
             forKey key: String) -> Bool
    @discardableResult
    func delete(_ key: String) -> Bool
    @discardableResult
    func deleteAll() -> Bool
}

// MARK: - KeyChainHelper

class KeyChainHelper: KeychainHelperable {
    private let keychain = KeychainSwift()

    func get(key: String) -> String? {
        keychain.get(key)
    }

    func getBool(key: String) -> Bool? {
        keychain.getBool(key)
    }

    func getData(key: String) -> Data? {
        keychain.getData(key)
    }

    @discardableResult
    func set(_ value: String,
             forKey key: String) -> Bool {
        keychain.set(value,
                     forKey: key,
                     withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }

    @discardableResult
    func set(_ value: Bool,
             forKey key: String) -> Bool {
        keychain.set(value,
                     forKey: key,
                     withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }

    @discardableResult
    func set(_ value: Data,
             forKey key: String) -> Bool {
        keychain.set(value,
                     forKey: key,
                     withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }

    @discardableResult
    func delete(_ key: String) -> Bool {
        keychain.delete(key)
    }

    @discardableResult
    func deleteAll() -> Bool {
        keychain.clear()
    }
}
