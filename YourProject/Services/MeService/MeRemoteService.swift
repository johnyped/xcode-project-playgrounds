//
//  MeRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol MeServiceProtocol: AnyObject {
    func fetchProfile() async throws -> Me
    func updateProfile(request: MeServiceRequest.UpdateProfile) async throws -> Me
    func changeEmail(request: MeServiceRequest.ChangeEmail) async throws -> Me
    func changePassword(request: MeServiceRequest.ChangePassword) async throws -> Me
    func verification(userId: Int, request: MeServiceRequest.Verification) async throws -> Me
    
    func getNotificationSettings() async throws -> NotificationSettings
    func updateNotificationSettings(request: MeServiceRequest.NotificationSettings) async throws -> Me
    
    func emailLoginResendCode(request: MeServiceRequest.EmailLoginResendCode) async throws
    func emailLoginLink(request: MeServiceRequest.EmailLoginLink) async throws -> Me
    func emailLoginSendCode(request: MeServiceRequest.EmailLoginSendCode) async throws
    
    func appleLoginLink(request: MeServiceRequest.AppleLoginLink) async throws
    func appleLoginUnlink(request: MeServiceRequest.AppleLoginUnlink) async throws
    
    func fetchDevices() async throws -> Devices
}

class MeRemoteService: MeServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }    
    
    func fetchProfile() async throws -> Me {
        let router = MeServiceRouter.fetchProfile
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateProfile(request: MeServiceRequest.UpdateProfile) async throws -> Me {
        let router = MeServiceRouter.updateProfile(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func changeEmail(request: MeServiceRequest.ChangeEmail) async throws -> Me {
        let router = MeServiceRouter.changeEmail(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func changePassword(request: MeServiceRequest.ChangePassword) async throws -> Me {
        let router = MeServiceRouter.changePassword(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func verification(userId: Int, request: MeServiceRequest.Verification) async throws -> Me {
        let router = MeServiceRouter.verification(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func getNotificationSettings() async throws -> NotificationSettings {
        let router = MeServiceRouter.getNotificationSettings
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateNotificationSettings(request: MeServiceRequest.NotificationSettings) async throws -> Me {
        let router = MeServiceRouter.updateNotificationSettings(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func emailLoginResendCode(request: MeServiceRequest.EmailLoginResendCode) async throws {
        let router = MeServiceRouter.emailLoginResendCode(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func emailLoginLink(request: MeServiceRequest.EmailLoginLink) async throws -> Me {
        let router = MeServiceRouter.emailLoginLink(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func emailLoginSendCode(request: MeServiceRequest.EmailLoginSendCode) async throws {
        let router = MeServiceRouter.emailLoginSendCode(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func appleLoginLink(request: MeServiceRequest.AppleLoginLink) async throws {
        let router = MeServiceRouter.appleLoginLink(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func appleLoginUnlink(request: MeServiceRequest.AppleLoginUnlink) async throws {
        let router = MeServiceRouter.appleLoginUnlink(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func fetchDevices() async throws -> Devices {
        let router = MeServiceRouter.fetchDevices
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
}
