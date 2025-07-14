//
//  HotelRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol HotelServiceProtocol: AnyObject {
    func fetchHotels() async throws -> Hotels
    func createHotel(request: HotelServiceRequest.CreateHotel) async throws -> Hotel
    func updateHotel(request: HotelServiceRequest.UpdateHotel) async throws -> Hotel
    func fetchHotelsShort() async throws -> HotelsShort
    func deleteHotel(request: HotelServiceRequest.DeleteHotel) async throws
    func fetchChannelManagerFeature(request: HotelServiceRequest.FetchChannelManagerFeature) async throws -> ChannelManagerFeature
    func fetchBeds24Config(request: HotelServiceRequest.FetchBeds24Config) async throws -> Beds24Config
    func updateBeds24Config(request: HotelServiceRequest.UpdateBeds24Config) async throws -> Beds24Config
    func fetchColorProfile(request: HotelServiceRequest.FetchColorProfile) async throws -> ColorProfile
    func updateColorProfile(request: HotelServiceRequest.UpdateColorProfile) async throws -> ColorProfile
}

class HotelRemoteService: HotelServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchHotels() async throws -> Hotels {
        let router = HotelServiceRouter.fetchHotels
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createHotel(request: HotelServiceRequest.CreateHotel) async throws -> Hotel {
        let router = HotelServiceRouter.createHotel(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateHotel(request: HotelServiceRequest.UpdateHotel) async throws -> Hotel {
        let router = HotelServiceRouter.updateHotel(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchHotelsShort() async throws -> HotelsShort {
        let router = HotelServiceRouter.fetchHotelsShort
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteHotel(request: HotelServiceRequest.DeleteHotel) async throws {
        let router = HotelServiceRouter.deleteHotel(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func fetchChannelManagerFeature(request: HotelServiceRequest.FetchChannelManagerFeature) async throws -> ChannelManagerFeature {
        let router = HotelServiceRouter.fetchChannelManager(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchBeds24Config(request: HotelServiceRequest.FetchBeds24Config) async throws -> Beds24Config {
        let router = HotelServiceRouter.fetchBeds24Config(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateBeds24Config(request: HotelServiceRequest.UpdateBeds24Config) async throws -> Beds24Config {
        let router = HotelServiceRouter.updateBeds24Config(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchColorProfile(request: HotelServiceRequest.FetchColorProfile) async throws -> ColorProfile {
        let router = HotelServiceRouter.fetchColorProfile(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateColorProfile(request: HotelServiceRequest.UpdateColorProfile) async throws -> ColorProfile {
        let router = HotelServiceRouter.updateColorProfile(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
} 
