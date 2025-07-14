//
//  BankAccountRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol BankAccountServiceProtocol: AnyObject {
    func fetchBankAccounts(request: BankAccountServiceRequest.FetchBankAccounts) async throws -> Paginator<BankAccounts>
    func fetchBankAccount(request: BankAccountServiceRequest.FetchBankAccount) async throws -> BankAccount
    func createBankAccount(request: BankAccountServiceRequest.CreateBankAccount) async throws -> BankAccount
    func updateBankAccount(request: BankAccountServiceRequest.UpdateBankAccount) async throws -> BankAccount
    func deleteBankAccount(request: BankAccountServiceRequest.DeleteBankAccount) async throws
    func setDefaultBankAccount(request: BankAccountServiceRequest.SetDefaultBankAccount) async throws -> BankAccount
}

class BankAccountRemoteService: BankAccountServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchBankAccounts(request: BankAccountServiceRequest.FetchBankAccounts) async throws -> Paginator<BankAccounts> {
        let router = BankAccountServiceRouter.fetchBankAccounts(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchBankAccount(request: BankAccountServiceRequest.FetchBankAccount) async throws -> BankAccount {
        let router = BankAccountServiceRouter.fetchBankAccount(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createBankAccount(request: BankAccountServiceRequest.CreateBankAccount) async throws -> BankAccount {
        let router = BankAccountServiceRouter.createBankAccount(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateBankAccount(request: BankAccountServiceRequest.UpdateBankAccount) async throws -> BankAccount {
        let router = BankAccountServiceRouter.updateBankAccount(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteBankAccount(request: BankAccountServiceRequest.DeleteBankAccount) async throws {
        let router = BankAccountServiceRouter.deleteBankAccount(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func setDefaultBankAccount(request: BankAccountServiceRequest.SetDefaultBankAccount) async throws -> BankAccount {
        let router = BankAccountServiceRouter.setDefaultBankAccount(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
} 
