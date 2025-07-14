//
//  CalendarRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol CalendarServiceProtocol: AnyObject {
    func fetchMonth(request: CalendarServiceRequest.FetchMonth) async throws -> CalendarReserviceResponse.CalendarMonth
}

class CalendarRemoteService: CalendarServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchMonth(request: CalendarServiceRequest.FetchMonth) async throws -> CalendarReserviceResponse.CalendarMonth {
        let router = CalendarServiceRouter.fetchMonth(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
