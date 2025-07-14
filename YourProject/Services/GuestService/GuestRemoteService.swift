//
//  StaffRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol GuestServiceProtocol: AnyObject {
    func fetchGuestsByHotel(request: GuestServiceRequest.FetchGuests) async throws -> Paginator<Guest>
    func fetchGuestsByQuery(request: GuestServiceRequest.FetchGuestsQuery) async throws -> Paginator<Guest>
    func fetchGuestsByCompany(request: GuestServiceRequest.FetchGuestsCompany) async throws -> Paginator<Guest>
    func fetchGuestsByReservation(request: GuestServiceRequest.FetchGuestsReservation) async throws -> Paginator<Guest>
    func fetchGuestsByDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset) async throws -> Paginator<Guest>

    func fetchGuest(request: GuestServiceRequest.FetchGuest) async throws -> Guest
    func createGuest(request: GuestServiceRequest.CreateGuest) async throws -> Guest
    func updateGuest(request: GuestServiceRequest.UpdateGuest) async throws -> Guest
    func deleteGuest(request: GuestServiceRequest.DeleteGuest) async throws
    
    func hideGuest(request: GuestServiceRequest.HideGuest) async throws -> Guest
    func unhideGuest(request: GuestServiceRequest.UnhideGuest) async throws -> Guest
    
    func removeGuestCompany(request: GuestServiceRequest.RemoveGuestCompany) async throws -> Guest
    
}

class GuestRemoteService: GuestServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchGuestsByHotel(request: GuestServiceRequest.FetchGuests) async throws -> Paginator<Guest> {
        let router = GuestServiceRouter.fetchGuestsByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByQuery(request: GuestServiceRequest.FetchGuestsQuery) async throws -> Paginator<Guest> {
        let router = GuestServiceRouter.fetchGuestsByQuery(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByCompany(request: GuestServiceRequest.FetchGuestsCompany) async throws -> Paginator<Guest> {
        let router = GuestServiceRouter.fetchGuestsByCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByReservation(request: GuestServiceRequest.FetchGuestsReservation) async throws -> Paginator<Guest> {
        let router = GuestServiceRouter.fetchGuestsByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset) async throws -> Paginator<Guest> {
        let router = GuestServiceRouter.fetchGuestsByDatetimeOffset(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuest(request: GuestServiceRequest.FetchGuest) async throws -> Guest {
        let router = GuestServiceRouter.fetchGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createGuest(request: GuestServiceRequest.CreateGuest) async throws -> Guest {
        let router = GuestServiceRouter.createGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateGuest(request: GuestServiceRequest.UpdateGuest) async throws -> Guest {
        let router = GuestServiceRouter.updateGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteGuest(request: GuestServiceRequest.DeleteGuest) async throws {
        let router = GuestServiceRouter.deleteGuest(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func hideGuest(request: GuestServiceRequest.HideGuest) async throws -> Guest {
        let router = GuestServiceRouter.hideGuest(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func unhideGuest(request: GuestServiceRequest.UnhideGuest) async throws -> Guest {
        let router = GuestServiceRouter.unhideGuest(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func removeGuestCompany(request: GuestServiceRequest.RemoveGuestCompany) async throws -> Guest {
        let router = GuestServiceRouter.removeGuestCompany(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
}
