//  ReservationLogRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol ReservationLogServiceProtocol: AnyObject {
    func fetchByReservation(request: ReservationLogServiceRequest.FetchByReservation) async throws -> ReservationLogs
}

class ReservationLogRemoteService: ReservationLogServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByReservation(request: ReservationLogServiceRequest.FetchByReservation) async throws -> ReservationLogs {
        let router = ReservationLogServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
}
