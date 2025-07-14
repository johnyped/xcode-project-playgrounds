//
//  CryptographicHelper.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation

// MARK: - CryptographicHelperable

// https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_secure_enclave
// https://support.apple.com/guide/security/secure-enclave-sec59b0b31ff/web
// https://medium.com/@alx.gridnev/ios-keychain-using-secure-enclave-stored-keys-8f7c81227f4

protocol CryptographicHelperable {
    func encrypt(plaintext: String,
                 forKey keyName: String) throws -> Data
    func decrypt(_ ciphertext: Data,
                 forKeyName keyName: String) throws -> Data
    func removeKey(_ name: String)
}

// MARK: - CryptographicHelper

class CryptographicHelper: CryptographicHelperable {
    enum CryptographicError: Error {
        case canNotCreateKey
        case canNotGetPublishKey
        case canNotConvertPlaintextToData
        case algorithmNotSupported
        case canNotConvertError
        case secKeyCreateRandomKeyError
        case keyNotFound
    }

    init() {}

    func encrypt(plaintext: String,
                 forKey keyName: String) throws -> Data {
        let key = try prepareKey(keyName)

        guard
            let publicKey = SecKeyCopyPublicKey(key)
        else { throw CryptographicError.canNotGetPublishKey }

        guard
            let plaintextData = plaintext.data(using: .utf8)
        else { throw CryptographicError.canNotConvertPlaintextToData }

        let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM

        guard
            SecKeyIsAlgorithmSupported(publicKey,
                                       .encrypt,
                                       algorithm)
        else { throw CryptographicError.algorithmNotSupported }

        var error: Unmanaged<CFError>?

        if let ciphertext = SecKeyCreateEncryptedData(publicKey,
                                                      algorithm,
                                                      plaintextData as CFData,
                                                      &error) as Data? {
            return ciphertext
        } else if let error = error?.takeRetainedValue() {
            throw error
        } else {
            throw CryptographicError.canNotConvertError
        }
    }

    func decrypt(_ ciphertext: Data,
                 forKeyName keyName: String) throws -> Data {
        guard
            let key = loadKey(keyName)
        else { throw CryptographicError.keyNotFound }

        let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM

        guard
            SecKeyIsAlgorithmSupported(key,
                                       .decrypt,
                                       algorithm)
        else {
            throw CryptographicError.algorithmNotSupported
        }

        var error: Unmanaged<CFError>?
        if let data = SecKeyCreateDecryptedData(key,
                                                algorithm,
                                                ciphertext as CFData,
                                                &error) as Data? {
            return data
        } else if let error = error?.takeRetainedValue() {
            throw error
        } else {
            throw CryptographicError.canNotConvertError
        }
    }

    func removeKey(_ name: String) {
        guard
            let tag = name.data(using: .utf8)
        else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
        ]

        SecItemDelete(query as CFDictionary)
    }
}

private extension CryptographicHelper {
    func prepareKey(_ name: String) throws -> SecKey {
        if let key = loadKey(name) {
            return key
        }

        return try createKey(name)
    }

    func loadKey(_ name: String) -> SecKey? {
        guard
            let tag = name.data(using: .utf8)
        else { return nil }

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecAttrKeyType as String: kSecAttrKeyTypeEC,
            kSecReturnRef as String: true,
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary,
                                         &item)

        guard
            status == errSecSuccess
        else { return nil }

        return (item as! SecKey)
    }

    func createKey(_ name: String,
                   requiresBiometry: Bool = false) throws -> SecKey {
        let flags: SecAccessControlCreateFlags = requiresBiometry ? [.privateKeyUsage, .biometryCurrentSet] : .privateKeyUsage
        let access = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                     kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                     flags,
                                                     nil)!
        let tag = name.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits as String: 256,
            kSecAttrTokenID as String: kSecAttrTokenIDSecureEnclave,
            kSecPrivateKeyAttrs as String: [
                kSecAttrIsPermanent as String: true,
                kSecAttrApplicationTag as String: tag,
                kSecAttrAccessControl as String: access,
            ],
        ]

        var error: Unmanaged<CFError>?

        if let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary,
                                                  &error) {
            return privateKey
        } else if let error = error?.takeRetainedValue() {
            throw error
        } else {
            throw CryptographicError.secKeyCreateRandomKeyError
        }
    }
}
