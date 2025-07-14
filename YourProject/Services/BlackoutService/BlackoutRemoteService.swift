//  BlackoutRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol BlackoutServiceProtocol: AnyObject {
    func fetchByPeriod(request: BlackoutServiceRequest.FetchByPeriod) async throws -> Paginator<BlackoutUnit>
    func fetchById(request: BlackoutServiceRequest.FetchById) async throws -> BlackoutUnit
    
    func createBlackoutUnit(request: BlackoutServiceRequest.CreateBlackoutUnit) async throws -> BlackoutUnit
    func updateBlackoutUnit(request: BlackoutServiceRequest.UpdateBlackoutUnit) async throws -> BlackoutUnit
    func deleteBlackoutUnit(request: BlackoutServiceRequest.DeleteBlackoutUnit) async throws
    
    func batchCreateBlackoutUnits(request: BlackoutServiceRequest.BatchCreateBlackoutUnits) async throws -> BlackoutUnits
    func batchDeleteBlackoutUnits(request: BlackoutServiceRequest.BatchDeleteBlackoutUnits) async throws
}

class BlackoutRemoteService: BlackoutServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByPeriod(request: BlackoutServiceRequest.FetchByPeriod) async throws -> Paginator<BlackoutUnit> {
        let router = BlackoutServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: BlackoutServiceRequest.FetchById) async throws -> BlackoutUnit {
        let router = BlackoutServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createBlackoutUnit(request: BlackoutServiceRequest.CreateBlackoutUnit) async throws -> BlackoutUnit {
        let router = BlackoutServiceRouter.createBlackoutUnit(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateBlackoutUnit(request: BlackoutServiceRequest.UpdateBlackoutUnit) async throws -> BlackoutUnit {
        let router = BlackoutServiceRouter.updateBlackoutUnit(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteBlackoutUnit(request: BlackoutServiceRequest.DeleteBlackoutUnit) async throws {
        let router = BlackoutServiceRouter.deleteBlackoutUnit(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func batchCreateBlackoutUnits(request: BlackoutServiceRequest.BatchCreateBlackoutUnits) async throws -> BlackoutUnits {
        let router = BlackoutServiceRouter.batchCreateBlackoutUnits(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func batchDeleteBlackoutUnits(request: BlackoutServiceRequest.BatchDeleteBlackoutUnits) async throws {
        let router = BlackoutServiceRouter.batchDeleteBlackoutUnits(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 
