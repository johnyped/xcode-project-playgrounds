//  BlackoutCalendarRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol BlackoutCalendarServiceProtocol: AnyObject {    
    func fetchByMonth(request: BlackoutCalendarServiceRequest.FetchByMonth) async throws -> BlackoutCalendarServiceResponse.BlackoutUnitMonth
}

class BlackoutCalendarRemoteService: BlackoutCalendarServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByMonth(request: BlackoutCalendarServiceRequest.FetchByMonth) async throws -> BlackoutCalendarServiceResponse.BlackoutUnitMonth {
        let router = BlackoutCalendarServiceRouter.fetchByMonth(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
} 
