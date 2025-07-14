//
//  CompanyRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Mockable

@Mockable
protocol CompanyServiceProtocol: AnyObject {
    func fetchByHotel(request: CompanyServiceRequest.FetchByHotel) async throws -> Paginator<Company>
    func fetchByGuest(request: CompanyServiceRequest.FetchByGuest) async throws -> Paginator<Company>
    
    func fetchById(request: CompanyServiceRequest.FetchById) async throws -> Company
    func createCompany(request: CompanyServiceRequest.CreateCompany) async throws -> Company
    func updateCompany(request: CompanyServiceRequest.UpdateCompany) async throws -> Company
    func deleteCompany(request: CompanyServiceRequest.DeleteCompany) async throws -> Company
    
    func hideCompany(request: CompanyServiceRequest.HideCompany) async throws -> Company
    func unhideCompany(request: CompanyServiceRequest.UnhideCompany) async throws -> Company
}

class CompanyRemoteService: CompanyServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: CompanyServiceRequest.FetchByHotel) async throws -> Paginator<Company> {
        let router = CompanyServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByGuest(request: CompanyServiceRequest.FetchByGuest) async throws -> Paginator<Company> {
        let router = CompanyServiceRouter.fetchByGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: CompanyServiceRequest.FetchById) async throws -> Company {
        let router = CompanyServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createCompany(request: CompanyServiceRequest.CreateCompany) async throws -> Company {
        let router = CompanyServiceRouter.createCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateCompany(request: CompanyServiceRequest.UpdateCompany) async throws -> Company {
        let router = CompanyServiceRouter.updateCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteCompany(request: CompanyServiceRequest.DeleteCompany) async throws -> Company {
        let router = CompanyServiceRouter.deleteCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func hideCompany(request: CompanyServiceRequest.HideCompany) async throws -> Company {
        let router = CompanyServiceRouter.hideCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func unhideCompany(request: CompanyServiceRequest.UnhideCompany) async throws -> Company {
        let router = CompanyServiceRouter.unhideCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
}
