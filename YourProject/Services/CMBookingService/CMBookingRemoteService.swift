//  CMBookingRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol CMBookingServiceProtocol: AnyObject {
    func fetchByHotel(request: CMBookingServiceRequest.FetchByHotel) async throws -> Paginator<CMBooking>
    func fetchByPeriod(request: CMBookingServiceRequest.FetchByPeriod) async throws -> Paginator<CMBooking>
    func fetchByStatus(request: CMBookingServiceRequest.FetchByStatus) async throws -> Paginator<CMBooking>
    func fetchByKeyword(request: CMBookingServiceRequest.FetchByKeyword) async throws -> Paginator<CMBooking>
    func fetchByBatchIds(request: CMBookingServiceRequest.FetchByBatchIds) async throws -> CMBookings
    func fetchById(request: CMBookingServiceRequest.FetchById) async throws -> CMBooking
    
    func acknowledge(request: CMBookingServiceRequest.Acknowledge) async throws
    func batchAcknowledge(request: CMBookingServiceRequest.BatchAcknowledge) async throws -> CMBookings
    
    func sync(request: CMBookingServiceRequest.Sync) async throws -> CMBookings
}

class CMBookingRemoteService: CMBookingServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: CMBookingServiceRequest.FetchByHotel) async throws -> Paginator<CMBooking> {
        let router = CMBookingServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByPeriod(request: CMBookingServiceRequest.FetchByPeriod) async throws -> Paginator<CMBooking> {
        let router = CMBookingServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByStatus(request: CMBookingServiceRequest.FetchByStatus) async throws -> Paginator<CMBooking> {
        let router = CMBookingServiceRouter.fetchByStatus(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByKeyword(request: CMBookingServiceRequest.FetchByKeyword) async throws -> Paginator<CMBooking> {
        let router = CMBookingServiceRouter.fetchByKeyword(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByBatchIds(request: CMBookingServiceRequest.FetchByBatchIds) async throws -> CMBookings {
        let router = CMBookingServiceRouter.fetchByBatchIds(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: CMBookingServiceRequest.FetchById) async throws -> CMBooking {
        let router = CMBookingServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func acknowledge(request: CMBookingServiceRequest.Acknowledge) async throws {
        let router = CMBookingServiceRouter.acknowledge(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func batchAcknowledge(request: CMBookingServiceRequest.BatchAcknowledge) async throws -> CMBookings {
        let router = CMBookingServiceRouter.batchAcknowledge(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func sync(request: CMBookingServiceRequest.Sync) async throws -> CMBookings {
        let router = CMBookingServiceRouter.sync(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
