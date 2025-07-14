//
//  SecureEnclaveWrapper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation

// MARK: - SecureEnclaveWrapper

@propertyWrapper
struct SecureEnclaveWrapper<T> {
    var wrappedValue: T {
        get {
            let tType = "\(T.self)"
            let stringType = "\(String.self)"

            guard
                tType.contains(stringType),
                let ciphertext = keychain.getData(key: key),
                let decryptedData = try? cryptographicHelper.decrypt(ciphertext,
                                                                     forKeyName: secureKey),
                let text = String(data: decryptedData,
                                  encoding: .utf8) as? T
            else { return defaultValue }

            return text
        }

        set {
            if let optional = newValue as? AnyOptional,
               optional.isNil {
                keychain.delete(key)
                return
            }
            encryptDataAndSaveToKeychain(newValue)
        }
    }

    private let key: String
    private let defaultValue: T
    private let keychain: KeychainHelperable
    private let cryptographicHelper: CryptographicHelperable
    private let secureKey: String

    init(wrappedValue defaultValue: T,
         key: String,
         keychain: KeychainHelperable = KeyChainHelper(),
         cryptographicHelper: CryptographicHelperable = CryptographicHelper()) {
        self.defaultValue = defaultValue
        self.key = key
        self.keychain = keychain
        self.cryptographicHelper = cryptographicHelper
        self.secureKey = "\(key).secure"

        storeDefaultValue(defaultValue)
    }
}

extension SecureEnclaveWrapper where T: ExpressibleByNilLiteral {
    init(key: String,
         keychain: KeychainHelperable = KeyChainHelper(),
         cryptographicHelper: CryptographicHelperable = CryptographicHelper()) {
        self.init(wrappedValue: nil,
                  key: key,
                  keychain: keychain,
                  cryptographicHelper: cryptographicHelper)
    }
}

private extension SecureEnclaveWrapper {
    func encryptDataInSecureEnclave(plaintext: String,
                                    key: String) -> Data? {
        try? cryptographicHelper.encrypt(plaintext: plaintext,
                                         forKey: secureKey)
    }

    func storeDefaultValue(_ value: T) {
        if let optional = value as? AnyOptional,
           optional.isNil {
            return
        }

        encryptDataAndSaveToKeychain(value)
    }

    func encryptDataAndSaveToKeychain(_ value: T) {
        if let value = value as? String,
           let data = encryptDataInSecureEnclave(plaintext: value,
                                                 key: key) {
            keychain.set(data,
                         forKey: key)
        } else {
            print(#function, "not support string")
        }
    }
}
