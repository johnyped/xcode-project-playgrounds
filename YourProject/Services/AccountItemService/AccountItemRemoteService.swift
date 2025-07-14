//
//  AccountItemRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol AccountItemServiceProtocol: AnyObject {
    func fetchByPeriod(request: AccountItemServiceRequest.FetchByPeriod) async throws -> Paginator<AccountItem>
    func fetchByKeyword(request: AccountItemServiceRequest.FetchByKeyword) async throws -> Paginator<AccountItem>
    
    func fetchById(request: AccountItemServiceRequest.FetchById) async throws -> AccountItem
    func createAccountItem(request: AccountItemServiceRequest.CreateAccountItem) async throws -> AccountItem
    func updateAccountItem(request: AccountItemServiceRequest.UpdateAccountItem) async throws -> AccountItem
    func deleteAccountItem(request: AccountItemServiceRequest.DeleteAccountItem) async throws
}

class AccountItemRemoteService: AccountItemServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByPeriod(request: AccountItemServiceRequest.FetchByPeriod) async throws -> Paginator<AccountItem> {
        let router = AccountItemServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByKeyword(request: AccountItemServiceRequest.FetchByKeyword) async throws -> Paginator<AccountItem> {
        let router = AccountItemServiceRouter.fetchByKeyword(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: AccountItemServiceRequest.FetchById) async throws -> AccountItem {
        let router = AccountItemServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createAccountItem(request: AccountItemServiceRequest.CreateAccountItem) async throws -> AccountItem {
        let router = AccountItemServiceRouter.createAccountItem(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateAccountItem(request: AccountItemServiceRequest.UpdateAccountItem) async throws -> AccountItem {
        let router = AccountItemServiceRouter.updateAccountItem(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteAccountItem(request: AccountItemServiceRequest.DeleteAccountItem) async throws {
        let router = AccountItemServiceRouter.deleteAccountItem(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 