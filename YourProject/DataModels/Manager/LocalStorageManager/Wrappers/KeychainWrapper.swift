//
//  KeychainWrapper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation

// MARK: - KeychainWrapper

@propertyWrapper
struct KeychainWrapper<T> {
    var wrappedValue: T {
        get {
            let tType = "\(T.self)"
            let stringType = "\(String.self)"
            let boolType = "\(Bool.self)"

            if tType.contains(stringType) {
                let value = keychain.get(key: key) as? T
                return value ?? defaultValue
            }
            else if tType.contains(boolType) {
                let value = keychain.getBool(key: key) as? T
                return value ?? defaultValue
            }
            else {
                let value = keychain.getData(key: key) as? T
                return value ?? defaultValue
            }
        }

        set {
            if let optional = newValue as? AnyOptional,
               optional.isNil {
                keychain.delete(key)
                return
            }

            saveToKeychain(newValue)
        }
    }

    private let key: String
    private let defaultValue: T
    private let keychain: KeychainHelperable

    init(wrappedValue defaultValue: T,
         key: String,
         keychain: KeychainHelperable = KeyChainHelper(),
         isOverrideExistingValue: Bool = false) {
        self.defaultValue = defaultValue
        self.key = key
        self.keychain = keychain

        let v = getData() ?? defaultValue
        storeDefaultValue(v)
    }
}

extension KeychainWrapper where T: ExpressibleByNilLiteral {
    init(key: String,
         keychain: KeychainHelperable = KeyChainHelper(),
         isOverrideExistingValue: Bool = false) {
        self.init(wrappedValue: nil,
                  key: key,
                  keychain: keychain,
                  isOverrideExistingValue: isOverrideExistingValue)
    }
}

private extension KeychainWrapper {
    func storeDefaultValue(_ value: T) {
        if let optional = value as? AnyOptional,
           optional.isNil {
            return
        }

        saveToKeychain(value)
    }

    func saveToKeychain(_ value: T) {
        if let value = value as? String {
            keychain.set(value,
                         forKey: key)
        }
        else if let value = value as? Bool {
            keychain.set(value,
                         forKey: key)
        }
        else if let value = value as? Data {
            keychain.set(value,
                         forKey: key)
        }
    }

    func getData() -> T? {
        let tType = "\(T.self)"
        let stringType = "\(String.self)"
        let boolType = "\(Bool.self)"

        if tType.contains(stringType) {
            let value = keychain.get(key: key) as? T
            return value
        }
        else if tType.contains(boolType) {
            let value = keychain.getBool(key: key) as? T
            return value
        }
        else {
            let value = keychain.getData(key: key) as? T
            return value
        }
    }
}
