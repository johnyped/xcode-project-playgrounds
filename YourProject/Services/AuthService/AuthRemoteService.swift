//
//  AuthService.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol AuthServiceProtocol: AnyObject {
    func emailLogin(request: AuthServiceRequest.EmailLogin) async throws
    func appleIdLogin(request: AuthServiceRequest.AppleIdLogin) async throws
    func tokenRefresh(request: AuthServiceRequest.TokenRefresh) async throws
    func logout() async throws        
    func resendEmailConfirmation(request: AuthServiceRequest.ResendEmailConfirmation) async throws
    func passwordReset(request: AuthServiceRequest.PasswordReset) async throws
    func signup(request: AuthServiceRequest.Signup) async throws
}

class AuthRemoteService: AuthServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func emailLogin(request: AuthServiceRequest.EmailLogin) async throws {
        let router = AuthServiceRouter.emailLogin(request: request)
        
        let response: AuthTokenResponse = try await apiManager.request(router: router,
                                                                       requiredAuthorization: false)
        localStorage.setToken(response)
    }
    
    func appleIdLogin(request: AuthServiceRequest.AppleIdLogin) async throws {
        let router = AuthServiceRouter.appleIdLogin(request: request)
        
        let response: AuthTokenResponse = try await apiManager.request(router: router,
                                                                       requiredAuthorization: false)
        localStorage.setToken(response)
    }
    
    func tokenRefresh(request: AuthServiceRequest.TokenRefresh) async throws {
        let router = AuthServiceRouter.refreshToken(request: request)
        let response: AuthTokenResponse = try await apiManager.request(router: router,
                                                                       requiredAuthorization: true)
        localStorage.setToken(response)
    }
    
    func logout() async {
        let router = AuthServiceRouter.logout
        do {
            try await apiManager.requestACK(router: router,
                                            requiredAuthorization: true)
            localStorage.clearToken()
        } catch {
            localStorage.clearToken()
        }
    }

    func resendEmailConfirmation(request: AuthServiceRequest.ResendEmailConfirmation) async throws {
        let router = AuthServiceRouter.resendEmailConfirmation(request: request)
        try await apiManager.requestACK(router: router,
                                            requiredAuthorization: false)
    }

    func passwordReset(request: AuthServiceRequest.PasswordReset) async throws {
        let router = AuthServiceRouter.passwordReset(request: request)
        try await apiManager.requestACK(router: router,
                                            requiredAuthorization: true)
    }
    
    func signup(request: AuthServiceRequest.Signup) async throws {
        let router = AuthServiceRouter.signup(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: false)
    }
}
