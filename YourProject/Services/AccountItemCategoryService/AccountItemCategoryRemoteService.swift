//  AccountItemCategoryRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol AccountItemCategoryServiceProtocol: AnyObject {
    func fetchByHotel(request: AccountItemCategoryServiceRequest.FetchByHotel) async throws -> Paginator<AccountItemCategory>
    func fetchById(request: AccountItemCategoryServiceRequest.FetchById) async throws -> AccountItemCategory
    func fetchSubCategories(request: AccountItemCategoryServiceRequest.FetchSubCategories) async throws -> AccountSubItemCategories
    func createAccountItemCategory(request: AccountItemCategoryServiceRequest.CreateAccountItemCategory) async throws -> AccountItemCategory
    func updateAccountItemCategory(request: AccountItemCategoryServiceRequest.UpdateAccountItemCategory) async throws -> AccountItemCategory
    func deleteAccountItemCategory(request: AccountItemCategoryServiceRequest.DeleteAccountItemCategory) async throws
}

class AccountItemCategoryRemoteService: AccountItemCategoryServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: AccountItemCategoryServiceRequest.FetchByHotel) async throws -> Paginator<AccountItemCategory> {
        let router = AccountItemCategoryServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: AccountItemCategoryServiceRequest.FetchById) async throws -> AccountItemCategory {
        let router = AccountItemCategoryServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchSubCategories(request: AccountItemCategoryServiceRequest.FetchSubCategories) async throws -> AccountSubItemCategories {
        let router = AccountItemCategoryServiceRouter.fetchSubCategories(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createAccountItemCategory(request: AccountItemCategoryServiceRequest.CreateAccountItemCategory) async throws -> AccountItemCategory {
        let router = AccountItemCategoryServiceRouter.createAccountItemCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateAccountItemCategory(request: AccountItemCategoryServiceRequest.UpdateAccountItemCategory) async throws -> AccountItemCategory {
        let router = AccountItemCategoryServiceRouter.updateAccountItemCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteAccountItemCategory(request: AccountItemCategoryServiceRequest.DeleteAccountItemCategory) async throws {
        let router = AccountItemCategoryServiceRouter.deleteAccountItemCategory(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 
