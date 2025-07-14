//  ReservationItemRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol ReservationItemServiceProtocol: AnyObject {
    func fetchByReservation(request: ReservationItemServiceRequest.FetchByReservation) async throws -> Paginator<ReservationItem>
    func fetchById(request: ReservationItemServiceRequest.FetchById) async throws -> ReservationItem
    
    func updateReservationItem(request: ReservationItemServiceRequest.UpdateReservationItem) async throws -> ReservationItem
    func deleteReservationItem(request: ReservationItemServiceRequest.DeleteReservationItem) async throws
    func replaceReservationItems(request: ReservationItemServiceRequest.ReplaceReservationItems) async throws -> [ReservationItem]
}

class ReservationItemRemoteService: ReservationItemServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByReservation(request: ReservationItemServiceRequest.FetchByReservation) async throws -> Paginator<ReservationItem> {
        let router = ReservationItemServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: ReservationItemServiceRequest.FetchById) async throws -> ReservationItem {
        let router = ReservationItemServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateReservationItem(request: ReservationItemServiceRequest.UpdateReservationItem) async throws -> ReservationItem {
        let router = ReservationItemServiceRouter.updateReservationItem(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteReservationItem(request: ReservationItemServiceRequest.DeleteReservationItem) async throws {
        let router = ReservationItemServiceRouter.deleteReservationItem(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func replaceReservationItems(request: ReservationItemServiceRequest.ReplaceReservationItems) async throws -> [ReservationItem] {
        let router = ReservationItemServiceRouter.replaceReservationItems(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 