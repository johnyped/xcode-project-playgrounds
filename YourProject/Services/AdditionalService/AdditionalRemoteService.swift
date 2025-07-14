//
//  AdditionalRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Alamofire
import Mockable

@Mockable
protocol AdditionalServiceProtocol: AnyObject {
    func fetchAdditionals(request: AdditionalServiceRequest.FetchAdditionals) async throws -> Paginator<Additional>
    func fetchAdditionalsByCreatedAt(request: AdditionalServiceRequest.FetchAdditionalsByCreatedAt) async throws -> Paginator<Additional>
    func fetchAdditionalsByDateIssue(request: AdditionalServiceRequest.FetchAdditionalsByDateIssue) async throws -> Paginator<Additional>
    
    func fetchAdditionalById(request: AdditionalServiceRequest.FetchById) async throws -> Additional
    func createAdditional(request: AdditionalServiceRequest.CreateAdditional) async throws -> Additional
    func updateAdditional(request: AdditionalServiceRequest.UpdateAdditional) async throws -> Additional
    func deleteAdditional(request: AdditionalServiceRequest.DeleteAdditional) async throws
    
    func voidAdditional(request: AdditionalServiceRequest.VoidAdditional) async throws -> Additional
}

class AdditionalRemoteService: AdditionalServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchAdditionals(request: AdditionalServiceRequest.FetchAdditionals) async throws -> Paginator<Additional> {
        let router = AdditionalServiceRouter.fetchAdditionals(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchAdditionalsByCreatedAt(request: AdditionalServiceRequest.FetchAdditionalsByCreatedAt) async throws -> Paginator<Additional> {
        let router = AdditionalServiceRouter.fetchAdditionalsByCreatedAt(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchAdditionalsByDateIssue(request: AdditionalServiceRequest.FetchAdditionalsByDateIssue) async throws -> Paginator<Additional> {
        let router = AdditionalServiceRouter.fetchAdditionalsByDateIssue(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchAdditionalById(request: AdditionalServiceRequest.FetchById) async throws -> Additional {
        let router = AdditionalServiceRouter.fetchAdditionalById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createAdditional(request: AdditionalServiceRequest.CreateAdditional) async throws -> Additional {
        let router = AdditionalServiceRouter.createAdditional(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateAdditional(request: AdditionalServiceRequest.UpdateAdditional) async throws -> Additional {
        let router = AdditionalServiceRouter.updateAdditional(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteAdditional(request: AdditionalServiceRequest.DeleteAdditional) async throws {
        let router = AdditionalServiceRouter.deleteAdditional(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func voidAdditional(request: AdditionalServiceRequest.VoidAdditional) async throws -> Additional {
        let router = AdditionalServiceRouter.voidAdditional(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
