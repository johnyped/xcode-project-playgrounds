//
//  PayeeRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation
import Mockable

@Mockable
protocol PayeeServiceProtocol: AnyObject {
    func fetchByHotel(request: PayeeServiceRequest.FetchByHotel) async throws -> Paginator<Payee>
    func fetchById(request: PayeeServiceRequest.FetchById) async throws -> Payee
    func createPayee(request: PayeeServiceRequest.CreatePayee) async throws -> Payee
    func updatePayee(request: PayeeServiceRequest.UpdatePayee) async throws -> Payee
    func deletePayee(request: PayeeServiceRequest.DeletePayee) async throws
}

class PayeeRemoteService: PayeeServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: PayeeServiceRequest.FetchByHotel) async throws -> Paginator<Payee> {
        let router = PayeeServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: PayeeServiceRequest.FetchById) async throws -> Payee {
        let router = PayeeServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createPayee(request: PayeeServiceRequest.CreatePayee) async throws -> Payee {
        let router = PayeeServiceRouter.createPayee(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updatePayee(request: PayeeServiceRequest.UpdatePayee) async throws -> Payee {
        let router = PayeeServiceRouter.updatePayee(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deletePayee(request: PayeeServiceRequest.DeletePayee) async throws {
        let router = PayeeServiceRouter.deletePayee(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 