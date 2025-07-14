//
//  GuestRegisterCardRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Mockable

@Mockable
protocol GuestRegisterCardServiceProtocol: AnyObject {
    func fetchGuestRegisterCards(request: GuestRegisterCardServiceRequest.FetchGuestRegisterCards) async throws -> Paginator<GuestRegisterCard>
    func fetchByGuest(request: GuestRegisterCardServiceRequest.FetchByGuest) async throws -> Paginator<GuestRegisterCard>
    func fetchByReservation(request: GuestRegisterCardServiceRequest.FetchByReservation) async throws -> Paginator<GuestRegisterCard>
    func fetchByPeriod(request: GuestRegisterCardServiceRequest.FetchByPeriod) async throws -> Paginator<GuestRegisterCard>
    
    func fetchGuestRegisterCardById(request: GuestRegisterCardServiceRequest.FetchById) async throws -> GuestRegisterCard
    func updateGuestRegisterCard(request: GuestRegisterCardServiceRequest.UpdateGuestRegisterCard) async throws -> GuestRegisterCard
    func deleteGuestRegisterCard(request: GuestRegisterCardServiceRequest.DeleteGuestRegisterCard) async throws
    
    func acceptPdpa(request: GuestRegisterCardServiceRequest.AcceptPdpa) async throws -> GuestRegisterCard
    func acceptRules(request: GuestRegisterCardServiceRequest.AcceptRules) async throws -> GuestRegisterCard
}

class GuestRegisterCardRemoteService: GuestRegisterCardServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchGuestRegisterCards(request: GuestRegisterCardServiceRequest.FetchGuestRegisterCards) async throws -> Paginator<GuestRegisterCard> {
        let router = GuestRegisterCardServiceRouter.fetchGuestRegisterCards(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByGuest(request: GuestRegisterCardServiceRequest.FetchByGuest) async throws -> Paginator<GuestRegisterCard> {
        let router = GuestRegisterCardServiceRouter.fetchByGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByReservation(request: GuestRegisterCardServiceRequest.FetchByReservation) async throws -> Paginator<GuestRegisterCard> {
        let router = GuestRegisterCardServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByPeriod(request: GuestRegisterCardServiceRequest.FetchByPeriod) async throws -> Paginator<GuestRegisterCard> {
        let router = GuestRegisterCardServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestRegisterCardById(request: GuestRegisterCardServiceRequest.FetchById) async throws -> GuestRegisterCard {
        let router = GuestRegisterCardServiceRouter.fetchGuestRegisterCardById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateGuestRegisterCard(request: GuestRegisterCardServiceRequest.UpdateGuestRegisterCard) async throws -> GuestRegisterCard {
        let router = GuestRegisterCardServiceRouter.updateGuestRegisterCard(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteGuestRegisterCard(request: GuestRegisterCardServiceRequest.DeleteGuestRegisterCard) async throws {
        let router = GuestRegisterCardServiceRouter.deleteGuestRegisterCard(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func acceptPdpa(request: GuestRegisterCardServiceRequest.AcceptPdpa) async throws -> GuestRegisterCard {
        let router = GuestRegisterCardServiceRouter.acceptPdpa(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func acceptRules(request: GuestRegisterCardServiceRequest.AcceptRules) async throws -> GuestRegisterCard {
        let router = GuestRegisterCardServiceRouter.acceptRules(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
