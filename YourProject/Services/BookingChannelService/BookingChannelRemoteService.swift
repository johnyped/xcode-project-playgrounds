//
//  BookingChannelRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol BookingChannelServiceProtocol: AnyObject {
    func fetchChannels() async throws -> BookingChannels
    func fetchChannel(request: BookingChannelServiceRequest.FetchChannel) async throws -> BookingChannel
    func createChannel(request: BookingChannelServiceRequest.CreateChannel) async throws -> BookingChannel
    func updateChannel(request: BookingChannelServiceRequest.UpdateChannel) async throws -> BookingChannel
    func deleteChannel(request: BookingChannelServiceRequest.DeleteChannel) async throws
    
    func fetchSubChannels(request: BookingChannelServiceRequest.FetchSubChannels) async throws -> [BookingChannel.SubChannel]
    func createSubChannel(request: BookingChannelServiceRequest.CreateSubChannel) async throws -> BookingChannel.SubChannel
    func updateSubChannel(request: BookingChannelServiceRequest.UpdateSubChannel) async throws -> BookingChannel.SubChannel
    func deleteSubChannel(request: BookingChannelServiceRequest.DeleteSubChannel) async throws
}

class BookingChannelRemoteService: BookingChannelServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchChannels() async throws -> BookingChannels {
        let router = BookingChannelServiceRouter.fetchChannels
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func fetchChannel(request: BookingChannelServiceRequest.FetchChannel) async throws -> BookingChannel {
        let router = BookingChannelServiceRouter.fetchChannel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func createChannel(request: BookingChannelServiceRequest.CreateChannel) async throws -> BookingChannel {
        let router = BookingChannelServiceRouter.createChannel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateChannel(request: BookingChannelServiceRequest.UpdateChannel) async throws -> BookingChannel {
        let router = BookingChannelServiceRouter.updateChannel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func deleteChannel(request: BookingChannelServiceRequest.DeleteChannel) async throws {
        let router = BookingChannelServiceRouter.deleteChannel(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
    
    func fetchSubChannels(request: BookingChannelServiceRequest.FetchSubChannels) async throws -> [BookingChannel.SubChannel] {
        let router = BookingChannelServiceRouter.fetchSubChannels(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func createSubChannel(request: BookingChannelServiceRequest.CreateSubChannel) async throws -> BookingChannel.SubChannel {
        let router = BookingChannelServiceRouter.createSubChannel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateSubChannel(request: BookingChannelServiceRequest.UpdateSubChannel) async throws -> BookingChannel.SubChannel {
        let router = BookingChannelServiceRouter.updateSubChannel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func deleteSubChannel(request: BookingChannelServiceRequest.DeleteSubChannel) async throws {
        let router = BookingChannelServiceRouter.deleteSubChannel(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
} 
