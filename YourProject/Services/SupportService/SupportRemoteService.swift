//
//  SupportRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol SupportServiceProtocol: AnyObject {
    func fetchMinAppVersion() async throws -> SupportVersion
}

class SupportRemoteService: SupportServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchMinAppVersion() async throws -> SupportVersion {
        let router = SupportServiceRouter.fetchMinAppVersion
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
} 
