//
//  UserRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

struct UserDevice: Decodable {
    // Add properties based on your API response
}

struct UserDevices: Decodable {
    let devices: [UserDevice]
}
//
//struct Company: Decodable {
//    // Add properties based on your API response
//}
//
//struct Companies: Decodable {
//    let companies: [Company]
//}

@Mockable
protocol UserServiceProtocol: AnyObject {
    func fetchUsers(request: UserServiceRequest.FetchUsers) async throws -> Users
    func fetchUser(request: UserServiceRequest.FetchUser) async throws -> User
    func createUser(request: UserServiceRequest.CreateUser) async throws -> User
    func updateUser(request: UserServiceRequest.UpdateUser) async throws -> User
    func deleteUser(request: UserServiceRequest.DeleteUser) async throws
    
    // New methods
    func changeEmail(request: UserServiceRequest.ChangeEmail) async throws
    func fetchNotificationSettings(request: UserServiceRequest.FetchNotificationSettings) async throws -> NotificationSettings
    func fetchUserDevices(request: UserServiceRequest.FetchUserDevices) async throws -> UserDevices
    func resendEmailLoginCode(request: UserServiceRequest.ResendEmailLoginCode) async throws
    func emailLoginLink(request: UserServiceRequest.EmailLoginLink) async throws -> User
    func sendEmailLoginCode(request: UserServiceRequest.SendEmailLoginCode) async throws
    func appleLoginLink(request: UserServiceRequest.AppleLoginLink) async throws -> User
    func fetchUserCompanies(request: UserServiceRequest.FetchUserCompanies) async throws -> Companies
    func changePassword(request: UserServiceRequest.ChangePassword) async throws
    func updateUserProfile(request: UserServiceRequest.UpdateUserProfile) async throws -> User
    func fetchUserDetail(request: UserServiceRequest.FetchUserDetail) async throws -> User
}

class UserRemoteService: UserServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchUsers(request: UserServiceRequest.FetchUsers) async throws -> Users {
        let router = UserRouterService.fetchUsers(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func fetchUser(request: UserServiceRequest.FetchUser) async throws -> User {
        let router = UserRouterService.fetchUser(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func createUser(request: UserServiceRequest.CreateUser) async throws -> User {
        let router = UserRouterService.createUser(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateUser(request: UserServiceRequest.UpdateUser) async throws -> User {
        let router = UserRouterService.updateUser(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func deleteUser(request: UserServiceRequest.DeleteUser) async throws {
        let router = UserRouterService.deleteUser(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
    
    // New method implementations
    
    func changeEmail(request: UserServiceRequest.ChangeEmail) async throws {
        let router = UserRouterService.changeEmail(request: request)
        try await apiManager.requestACK(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func fetchNotificationSettings(request: UserServiceRequest.FetchNotificationSettings) async throws -> NotificationSettings {
        let router = UserRouterService.fetchNotificationSettings(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func fetchUserDevices(request: UserServiceRequest.FetchUserDevices) async throws -> UserDevices {
        let router = UserRouterService.fetchUserDevices(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func resendEmailLoginCode(request: UserServiceRequest.ResendEmailLoginCode) async throws {
        let router = UserRouterService.resendEmailLoginCode(request: request)
        try await apiManager.requestACK(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func emailLoginLink(request: UserServiceRequest.EmailLoginLink) async throws -> User {
        let router = UserRouterService.emailLoginLink(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func sendEmailLoginCode(request: UserServiceRequest.SendEmailLoginCode) async throws {
        let router = UserRouterService.sendEmailLoginCode(request: request)
        try await apiManager.requestACK(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func appleLoginLink(request: UserServiceRequest.AppleLoginLink) async throws -> User {
        let router = UserRouterService.appleLoginLink(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func fetchUserCompanies(request: UserServiceRequest.FetchUserCompanies) async throws -> Companies {
        let router = UserRouterService.fetchUserCompanies(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func changePassword(request: UserServiceRequest.ChangePassword) async throws {
        let router = UserRouterService.changePassword(request: request)
        try await apiManager.requestACK(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func updateUserProfile(request: UserServiceRequest.UpdateUserProfile) async throws -> User {
        let router = UserRouterService.updateUserProfile(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
    
    func fetchUserDetail(request: UserServiceRequest.FetchUserDetail) async throws -> User {
        let router = UserRouterService.fetchUserDetail(request: request)
        return try await apiManager.request(
            router: router,
            requiredAuthorization: true
        )
    }
} 
