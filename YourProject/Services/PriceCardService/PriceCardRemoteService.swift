//
//  PriceCardRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol PriceCardServiceProtocol: AnyObject {
    func fetchPriceCards(request: PriceCardServiceRequest.FetchPriceCards) async throws -> Paginator<LocalPriceCard>
    func fetchPriceCard(request: PriceCardServiceRequest.FetchPriceCard) async throws -> LocalPriceCard
    func fetchPriceCardsByPeriod(request: PriceCardServiceRequest.FetchPriceCardsByPeriod) async throws -> LocalPriceCards
    func createPriceCard(request: PriceCardServiceRequest.CreatePriceCard) async throws -> LocalPriceCard
    func updatePriceCard(request: PriceCardServiceRequest.UpdatePriceCard) async throws -> LocalPriceCard
    func deletePriceCard(request: PriceCardServiceRequest.DeletePriceCard) async throws
}

class PriceCardRemoteService: PriceCardServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchPriceCards(request: PriceCardServiceRequest.FetchPriceCards) async throws -> Paginator<LocalPriceCard> {
        let router = PriceCardServiceRouter.fetchPriceCards(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchPriceCard(request: PriceCardServiceRequest.FetchPriceCard) async throws -> LocalPriceCard {
        let router = PriceCardServiceRouter.fetchPriceCard(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchPriceCardsByPeriod(request: PriceCardServiceRequest.FetchPriceCardsByPeriod) async throws -> LocalPriceCards {
        let router = PriceCardServiceRouter.fetchPriceCardsByPeriod(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createPriceCard(request: PriceCardServiceRequest.CreatePriceCard) async throws -> LocalPriceCard {
        let router = PriceCardServiceRouter.createPriceCard(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updatePriceCard(request: PriceCardServiceRequest.UpdatePriceCard) async throws -> LocalPriceCard {
        let router = PriceCardServiceRouter.updatePriceCard(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deletePriceCard(request: PriceCardServiceRequest.DeletePriceCard) async throws {
        let router = PriceCardServiceRouter.deletePriceCard(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
} 
