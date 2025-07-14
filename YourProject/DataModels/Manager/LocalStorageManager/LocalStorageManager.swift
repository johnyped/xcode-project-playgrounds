//
//  LocalStorageManager.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//
import Foundation
import KeychainSwift
import Mockable

@Mockable
protocol LocalStorageManagerProtocal: Sendable {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
    
    // Authenticate
    func isAuthenticated() -> Bool
    func clearToken()
    func setToken(_ token: AuthTokenResponse)
}

class LocalStorageManager: LocalStorageManagerProtocal {
    @SecureEnclaveWrapper(key: Key.accessToken.rawValue)
    var accessToken: String?
    
    @SecureEnclaveWrapper(key: Key.refreshToken.rawValue)
    var refreshToken: String?
    
    private let keychainHelper: KeychainHelperable
    
    init(keychainHelper: KeychainHelperable = KeyChainHelper()) {
        self.keychainHelper = keychainHelper
    }
    
    func isAuthenticated() -> Bool {
        accessToken != nil && refreshToken != nil
    }
    
    func clearToken() {
        accessToken = nil
        refreshToken = nil
    }
    
    func setToken(_ token: AuthTokenResponse) {
        accessToken = token.accessToken
        refreshToken = token.refreshToken
    }
    
}

extension LocalStorageManager {
    enum Key: String {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
