//
//  CMRateRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol CMRateServiceProtocol: AnyObject {
    func fetchByPeriod(request: CMRateServiceRequest.FetchByPeriod) async throws -> Paginator<CMRate>
    func fetchByHotel(request: CMRateServiceRequest.FetchByHotel) async throws -> Paginator<CMRate>
    func fetchByRoomType(request: CMRateServiceRequest.FetchByRoomType) async throws -> CMRates
    func fetchById(request: CMRateServiceRequest.FetchById) async throws -> CMRate

    func createCMRate(request: CMRateServiceRequest.CreateCMRate) async throws -> CMRate
    func updateCMRate(request: CMRateServiceRequest.UpdateCMRate) async throws -> CMRate
    func deleteCMRate(request: CMRateServiceRequest.DeleteCMRate) async throws

    func changeUnitable(request: CMRateServiceRequest.ChangeUnitableRequest) async throws -> CMRate
}

class CMRateRemoteService: CMRateServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByPeriod(request: CMRateServiceRequest.FetchByPeriod) async throws -> Paginator<CMRate> {
        let router = CMRateServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByHotel(request: CMRateServiceRequest.FetchByHotel) async throws -> Paginator<CMRate> {
        let router = CMRateServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }

    func fetchByRoomType(request: CMRateServiceRequest.FetchByRoomType) async throws -> CMRates {
        let router = CMRateServiceRouter.fetchByRoomType(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: CMRateServiceRequest.FetchById) async throws -> CMRate {
        let router = CMRateServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createCMRate(request: CMRateServiceRequest.CreateCMRate) async throws -> CMRate {
        let router = CMRateServiceRouter.createCMRate(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateCMRate(request: CMRateServiceRequest.UpdateCMRate) async throws -> CMRate {
        let router = CMRateServiceRouter.updateCMRate(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteCMRate(request: CMRateServiceRequest.DeleteCMRate) async throws {
        let router = CMRateServiceRouter.deleteCMRate(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func changeUnitable(request: CMRateServiceRequest.ChangeUnitableRequest) async throws -> CMRate {
        let router = CMRateServiceRouter.changeUnitable(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
