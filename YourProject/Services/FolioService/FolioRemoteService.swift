//
//  FolioRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol FolioServiceProtocol: AnyObject {
    func fetchFolios(request: FolioServiceRequest.FetchFolios) async throws -> Paginator<Folio>
    func fetchFoliosByCategory(request: FolioServiceRequest.FetchFoliosByCategory) async throws -> Folios
    func fetchFolio(request: FolioServiceRequest.FetchFolio) async throws -> Folio
    func createFolio(request: FolioServiceRequest.CreateFolio) async throws -> Folio
    func updateFolio(request: FolioServiceRequest.UpdateFolio) async throws -> Folio
    func deleteFolio(request: FolioServiceRequest.DeleteFolio) async throws
}

class FolioRemoteService: FolioServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchFolios(request: FolioServiceRequest.FetchFolios) async throws -> Paginator<Folio> {
        let router = FolioServiceRouter.fetchFolios(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchFoliosByCategory(request: FolioServiceRequest.FetchFoliosByCategory) async throws -> Folios {
        let router = FolioServiceRouter.fetchFoliosByCategory(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchFolio(request: FolioServiceRequest.FetchFolio) async throws -> Folio {
        let router = FolioServiceRouter.fetchFolio(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createFolio(request: FolioServiceRequest.CreateFolio) async throws -> Folio {
        let router = FolioServiceRouter.createFolio(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateFolio(request: FolioServiceRequest.UpdateFolio) async throws -> Folio {
        let router = FolioServiceRouter.updateFolio(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteFolio(request: FolioServiceRequest.DeleteFolio) async throws {
        let router = FolioServiceRouter.deleteFolio(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
} 
