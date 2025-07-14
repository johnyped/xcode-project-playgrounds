//  HSDocumentRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import Foundation

protocol HSDocumentServiceProtocol: AnyObject {
    func fetchByFinancialRecord(request: HSDocumentServiceRequest.FetchByFinancialRecord) async throws -> Paginator<HSDocument>
    func fetchByAccountItem(request: HSDocumentServiceRequest.FetchByAccountItem) async throws -> Paginator<HSDocument>
    func fetchByReservation(request: HSDocumentServiceRequest.FetchByReservation) async throws -> Paginator<HSDocument>
    func fetchByFileName(request: HSDocumentServiceRequest.FetchByFileName) async throws -> Paginator<HSDocument>
    func fetchByKind(request: HSDocumentServiceRequest.FetchByKind) async throws -> Paginator<HSDocument>
    func fetchGuestRegisterCardSignature(request: HSDocumentServiceRequest.FetchGuestRegisterCardSignature) async throws -> HSDocuments
    func fetchById(request: HSDocumentServiceRequest.FetchById) async throws -> HSDocument
    
    func createDocument(request: HSDocumentServiceRequest.CreateDocument) async throws -> HSDocument
    func requestUploadUrl(request: HSDocumentServiceRequest.RequestUploadUrl) async throws -> HSDocumentServiceResponse.UploadUrl
    
    func deleteDocument(request: HSDocumentServiceRequest.DeleteDocument) async throws
    func batchDelete(request: HSDocumentServiceRequest.BatchDelete) async throws
    func batchDeleteByKind(request: HSDocumentServiceRequest.BatchDeleteByKind) async throws
}

class HSDocumentRemoteService: HSDocumentServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByFinancialRecord(request: HSDocumentServiceRequest.FetchByFinancialRecord) async throws -> Paginator<HSDocument> {
        let router = HSDocumentServiceRouter.fetchByFinancialRecord(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByAccountItem(request: HSDocumentServiceRequest.FetchByAccountItem) async throws -> Paginator<HSDocument> {
        let router = HSDocumentServiceRouter.fetchByAccountItem(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByReservation(request: HSDocumentServiceRequest.FetchByReservation) async throws -> Paginator<HSDocument> {
        let router = HSDocumentServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByFileName(request: HSDocumentServiceRequest.FetchByFileName) async throws -> Paginator<HSDocument> {
        let router = HSDocumentServiceRouter.fetchByFileName(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByKind(request: HSDocumentServiceRequest.FetchByKind) async throws -> Paginator<HSDocument> {
        let router = HSDocumentServiceRouter.fetchByKind(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestRegisterCardSignature(request: HSDocumentServiceRequest.FetchGuestRegisterCardSignature) async throws -> HSDocuments {
        let router = HSDocumentServiceRouter.fetchGuestRegisterCardSignature(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: HSDocumentServiceRequest.FetchById) async throws -> HSDocument {
        let router = HSDocumentServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createDocument(request: HSDocumentServiceRequest.CreateDocument) async throws -> HSDocument {
        let router = HSDocumentServiceRouter.createDocument(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func requestUploadUrl(request: HSDocumentServiceRequest.RequestUploadUrl) async throws -> HSDocumentServiceResponse.UploadUrl {
        let router = HSDocumentServiceRouter.requestUploadUrl(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteDocument(request: HSDocumentServiceRequest.DeleteDocument) async throws {
        let router = HSDocumentServiceRouter.deleteDocument(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func batchDelete(request: HSDocumentServiceRequest.BatchDelete) async throws {
        let router = HSDocumentServiceRouter.batchDelete(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func batchDeleteByKind(request: HSDocumentServiceRequest.BatchDeleteByKind) async throws {
        let router = HSDocumentServiceRouter.batchDeleteByKind(request: request)
        return try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 
