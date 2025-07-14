//
//  CMCalendarRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol CMCalendarServiceProtocol: AnyObject {
    func fetchByMonth(request: CMCalendarServiceRequest.FetchByMonth) async throws -> CMCalendarServiceResponse.CMCalendarMonth
}

class CMCalendarRemoteService: CMCalendarServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByMonth(request: CMCalendarServiceRequest.FetchByMonth) async throws -> CMCalendarServiceResponse.CMCalendarMonth {
        let router = CMCalendarServiceRouter.fetchByMonth(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
