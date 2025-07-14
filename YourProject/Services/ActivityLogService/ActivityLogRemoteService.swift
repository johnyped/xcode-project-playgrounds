//  ActivityLogRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol ActivityLogServiceProtocol: AnyObject {
    func fetchCreatorByFinancialRecord(request: ActivityLogServiceRequest.FetchCreatorByFinancialRecord) async throws -> Creator
    func fetchCreatorByReservation(request: ActivityLogServiceRequest.FetchCreatorByReservation) async throws -> Creator
    func fetchCreatorByAdditional(request: ActivityLogServiceRequest.FetchCreatorByAdditional) async throws -> Creator
    func fetchCreatorByAccount(request: ActivityLogServiceRequest.FetchCreatorByAccount) async throws -> Creator
    func fetchCreatorByAccountItem(request: ActivityLogServiceRequest.FetchCreatorByAccountItem) async throws -> Creator
}

class ActivityLogRemoteService: ActivityLogServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchCreatorByFinancialRecord(request: ActivityLogServiceRequest.FetchCreatorByFinancialRecord) async throws -> Creator {
        let router = ActivityLogServiceRouter.fetchCreatorByFinancialRecord(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchCreatorByReservation(request: ActivityLogServiceRequest.FetchCreatorByReservation) async throws -> Creator {
        let router = ActivityLogServiceRouter.fetchCreatorByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchCreatorByAdditional(request: ActivityLogServiceRequest.FetchCreatorByAdditional) async throws -> Creator {
        let router = ActivityLogServiceRouter.fetchCreatorByAdditional(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchCreatorByAccount(request: ActivityLogServiceRequest.FetchCreatorByAccount) async throws -> Creator {
        let router = ActivityLogServiceRouter.fetchCreatorByAccount(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchCreatorByAccountItem(request: ActivityLogServiceRequest.FetchCreatorByAccountItem) async throws -> Creator {
        let router = ActivityLogServiceRouter.fetchCreatorByAccountItem(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 