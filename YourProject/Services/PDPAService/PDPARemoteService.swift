//
//  PDPARemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol PDPAServiceProtocol: AnyObject {
    func fetchPdpas(request: PDPAServiceRequest.FetchPdpas) async throws -> Pdpas
    func fetchPdpa(request: PDPAServiceRequest.FetchPdpa) async throws -> Pdpa
}

class PDPARemoteService: PDPAServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchPdpas(request: PDPAServiceRequest.FetchPdpas) async throws -> Pdpas {
        let router = PDPAServiceRouter.fetchPdpas(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchPdpa(request: PDPAServiceRequest.FetchPdpa) async throws -> Pdpa {
        let router = PDPAServiceRouter.fetchPdpa(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
} 
