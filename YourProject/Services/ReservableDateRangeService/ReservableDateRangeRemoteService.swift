//
//  ReservableDateRangeRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol ReservableDateRangeServiceProtocol: AnyObject {
    func fetchReservableDateRanges(request: ReservableDateRangeServiceRequest.FetchReservableDateRanges) async throws -> ReservedDateRange
}

class ReservableDateRangeRemoteService: ReservableDateRangeServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchReservableDateRanges(request: ReservableDateRangeServiceRequest.FetchReservableDateRanges) async throws -> ReservedDateRange {
        let router = ReservableDateRangeServiceRouter.fetchReservableDateRanges(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 