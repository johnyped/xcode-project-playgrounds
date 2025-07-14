//
//  AccountRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol AccountServiceProtocol: AnyObject {
    // MARK: - Fetch Methods
    func fetchAccounts(request: AccountServiceRequest.FetchAccounts) async throws -> Paginator<Account>
    func fetchAccount(request: AccountServiceRequest.FetchById) async throws -> Account
    func fetchAccountBalance(request: AccountServiceRequest.FetchAccountBalance) async throws -> AccountServiceResponse.BalanceInfo
    
    // MARK: - CRUD Operations
    func createAccount(request: AccountServiceRequest.CreateAccount) async throws -> Account
    func updateAccount(request: AccountServiceRequest.UpdateAccount) async throws -> Account
    func deleteAccount(request: AccountServiceRequest.DeleteAccount) async throws
    
    // MARK: - Additional Operations
    func setAccountAsDefault(request: AccountServiceRequest.SetAsDefault) async throws -> Account
}

class AccountRemoteService: AccountServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    // MARK: - Fetch Methods
    
    func fetchAccounts(request: AccountServiceRequest.FetchAccounts) async throws -> Paginator<Account> {
        let router = AccountServiceRouter.fetchAccounts(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchAccount(request: AccountServiceRequest.FetchById) async throws -> Account {
        let router = AccountServiceRouter.fetchAccount(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchAccountBalance(request: AccountServiceRequest.FetchAccountBalance) async throws -> AccountServiceResponse.BalanceInfo {
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    // MARK: - CRUD Operations
    
    func createAccount(request: AccountServiceRequest.CreateAccount) async throws -> Account {
        let router = AccountServiceRouter.createAccount(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateAccount(request: AccountServiceRequest.UpdateAccount) async throws -> Account {
        let router = AccountServiceRouter.updateAccount(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteAccount(request: AccountServiceRequest.DeleteAccount) async throws {
        let router = AccountServiceRouter.deleteAccount(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    // MARK: - Additional Operations
    
    func setAccountAsDefault(request: AccountServiceRequest.SetAsDefault) async throws -> Account {
        let router = AccountServiceRouter.setAccountAsDefault(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 