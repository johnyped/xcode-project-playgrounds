//  AllotmentRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 7/1/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol AllotmentServiceProtocol: AnyObject {
    func fetchByUnitType(request: AllotmentServiceRequest.FetchByUnitType) async throws -> UnitTypeAllotments
    func fetchByMonth(request: AllotmentServiceRequest.FetchByMonth) async throws -> AllotmentServiceResponse.AllotmentMonth
}

class AllotmentRemoteService: AllotmentServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByUnitType(request: AllotmentServiceRequest.FetchByUnitType) async throws -> UnitTypeAllotments {
        let router = AllotmentServiceRouter.fetchByUnitType(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByMonth(request: AllotmentServiceRequest.FetchByMonth) async throws -> AllotmentServiceResponse.AllotmentMonth {
        let router = AllotmentServiceRouter.fetchByMonth(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
