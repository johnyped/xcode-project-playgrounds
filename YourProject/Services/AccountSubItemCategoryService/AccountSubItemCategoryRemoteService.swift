//  AccountSubItemCategoryRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol AccountSubItemCategoryServiceProtocol: AnyObject {
    func fetchByHotel(request: AccountSubItemCategoryServiceRequest.FetchByHotel) async throws -> Paginator<AccountSubItemCategory>
    func fetchByAccountItemCategory(request: AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory) async throws -> AccountSubItemCategories
    func fetchById(request: AccountSubItemCategoryServiceRequest.FetchById) async throws -> AccountSubItemCategory
    func createAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory) async throws -> AccountSubItemCategory
    func updateAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory) async throws -> AccountSubItemCategory
    func deleteAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.DeleteAccountSubItemCategory) async throws
}

class AccountSubItemCategoryRemoteService: AccountSubItemCategoryServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: AccountSubItemCategoryServiceRequest.FetchByHotel) async throws -> Paginator<AccountSubItemCategory> {
        let router = AccountSubItemCategoryServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByAccountItemCategory(request: AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory) async throws -> AccountSubItemCategories {
        let router = AccountSubItemCategoryServiceRouter.fetchByAccountItemCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: AccountSubItemCategoryServiceRequest.FetchById) async throws -> AccountSubItemCategory {
        let router = AccountSubItemCategoryServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory) async throws -> AccountSubItemCategory {
        let router = AccountSubItemCategoryServiceRouter.createAccountSubItemCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory) async throws -> AccountSubItemCategory {
        let router = AccountSubItemCategoryServiceRouter.updateAccountSubItemCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.DeleteAccountSubItemCategory) async throws {
        let router = AccountSubItemCategoryServiceRouter.deleteAccountSubItemCategory(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 
