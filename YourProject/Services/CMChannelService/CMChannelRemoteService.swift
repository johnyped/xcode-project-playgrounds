//  CMChannelRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol CMChannelServiceProtocol: AnyObject {
    func fetchByHotel(request: CMChannelServiceRequest.FetchByHotel) async throws -> CMChannels
}

class CMChannelRemoteService: CMChannelServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: CMChannelServiceRequest.FetchByHotel) async throws -> CMChannels {
        let router = CMChannelServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
