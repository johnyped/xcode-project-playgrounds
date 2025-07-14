//  SyncAllotmentRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol SyncAllotmentServiceProtocol: AnyObject {
    func fetchById(request: SyncAllotmentServiceRequest.FetchById) async throws -> CMSyncAllotment
    func createSyncAllotment(request: SyncAllotmentServiceRequest.CreateSyncAllotment) async throws -> CMSyncAllotment
}

class SyncAllotmentRemoteService: SyncAllotmentServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchById(request: SyncAllotmentServiceRequest.FetchById) async throws -> CMSyncAllotment {
        let router = SyncAllotmentServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createSyncAllotment(request: SyncAllotmentServiceRequest.CreateSyncAllotment) async throws -> CMSyncAllotment {
        let router = SyncAllotmentServiceRouter.createSyncAllotment(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
} 
