//
//  UserDefaultsWrapper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation

// MARK: - UserDefaultsWrapper

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    var wrappedValue: T {
        get {
            if let data = storage.value(forKey: key) as? Data,
               let value = try? JSONDecoder().decode(T.self,
                                                     from: data) {
                return value
            } else if let value = storage.value(forKey: key) as? T {
                return value
            }

            return defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional,
               optional.isNil {
                storage.removeObject(forKey: key)
            }
            else if let encoded = try? JSONEncoder().encode(newValue) {
                storage.set(encoded,
                            forKey: key)
            }
            else {
                storage.set(newValue,
                            forKey: key)
            }
        }
    }

    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults

    init(wrappedValue defaultValue: T,
         key: String,
         storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}

extension UserDefaultsWrapper where T: ExpressibleByNilLiteral {
    init(key: String,
         storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil,
                  key: key,
                  storage: storage)
    }
}

// MARK: - AnyOptional

protocol AnyOptional {
    var isNil: Bool { get }
}

// MARK: - Optional + AnyOptional

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
    var isNotNil: Bool { !isNil }
}
