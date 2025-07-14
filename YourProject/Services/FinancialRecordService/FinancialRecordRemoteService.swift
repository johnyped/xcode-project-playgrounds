//  FinancialRecordRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol FinancialRecordServiceProtocol: AnyObject {
    func fetchByHotel(request: FinancialRecordServiceRequest.FetchByHotel) async throws -> Paginator<FinancialRecord>
    func fetchByPeriod(request: FinancialRecordServiceRequest.FetchByPeriod) async throws -> Paginator<FinancialRecord>
    func fetchByReservation(request: FinancialRecordServiceRequest.FetchByReservation) async throws -> Paginator<FinancialRecord>
    func fetchByCreatedAt(request: FinancialRecordServiceRequest.FetchByCreatedAt) async throws -> Paginator<FinancialRecord>
    func fetchByAccountItem(request: FinancialRecordServiceRequest.FetchByAccountItem) async throws -> Paginator<FinancialRecord>
    
    func fetchById(request: FinancialRecordServiceRequest.FetchById) async throws -> FinancialRecord
    func createFinancialRecord(request: FinancialRecordServiceRequest.CreateFinancialRecord) async throws -> FinancialRecord
    func updateFinancialRecord(request: FinancialRecordServiceRequest.UpdateFinancialRecord) async throws -> FinancialRecord
    func deleteFinancialRecord(request: FinancialRecordServiceRequest.DeleteFinancialRecord) async throws
}

class FinancialRecordRemoteService: FinancialRecordServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: FinancialRecordServiceRequest.FetchByHotel) async throws -> Paginator<FinancialRecord> {
        let router = FinancialRecordServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByPeriod(request: FinancialRecordServiceRequest.FetchByPeriod) async throws -> Paginator<FinancialRecord> {
        let router = FinancialRecordServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByReservation(request: FinancialRecordServiceRequest.FetchByReservation) async throws -> Paginator<FinancialRecord> {
        let router = FinancialRecordServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByCreatedAt(request: FinancialRecordServiceRequest.FetchByCreatedAt) async throws -> Paginator<FinancialRecord> {
        let router = FinancialRecordServiceRouter.fetchByCreatedAt(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByAccountItem(request: FinancialRecordServiceRequest.FetchByAccountItem) async throws -> Paginator<FinancialRecord> {
        let router = FinancialRecordServiceRouter.fetchByAccountItem(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: FinancialRecordServiceRequest.FetchById) async throws -> FinancialRecord {
        let router = FinancialRecordServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createFinancialRecord(request: FinancialRecordServiceRequest.CreateFinancialRecord) async throws -> FinancialRecord {
        let router = FinancialRecordServiceRouter.createFinancialRecord(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateFinancialRecord(request: FinancialRecordServiceRequest.UpdateFinancialRecord) async throws -> FinancialRecord {
        let router = FinancialRecordServiceRouter.updateFinancialRecord(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteFinancialRecord(request: FinancialRecordServiceRequest.DeleteFinancialRecord) async throws {
        let router = FinancialRecordServiceRouter.deleteFinancialRecord(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
} 
