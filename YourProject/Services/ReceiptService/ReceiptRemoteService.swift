//
//  ReceiptRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Mockable

@Mockable
protocol ReceiptServiceProtocol: AnyObject {
    func fetchByHotel(request: ReceiptServiceRequest.FetchByHotel) async throws -> Paginator<Receipt>
    func fetchByQuery(request: ReceiptServiceRequest.FetchByQuery) async throws -> Paginator<Receipt>
    func fetchByPeriod(request: ReceiptServiceRequest.FetchByPeriod) async throws -> Paginator<Receipt>
    func fetchByReservation(request: ReceiptServiceRequest.FetchByReservation) async throws -> Paginator<Receipt>
    func fetchByFolioForm(request: ReceiptServiceRequest.FetchByFolioForm) async throws -> Paginator<Receipt>
    func fetchByFinancialRecord(request: ReceiptServiceRequest.FetchByFinancialRecord) async throws -> Paginator<Receipt>
    
    func fetchById(request: ReceiptServiceRequest.FetchById) async throws -> Receipt
    
    func createFromFinancialRecord(request: ReceiptServiceRequest.CreateFromFinancialRecord) async throws -> Receipt
    func createFromFolioForm(request: ReceiptServiceRequest.CreateFromFolioForm) async throws -> Receipt
    func createFromFolioFormVat(request: ReceiptServiceRequest.CreateFromFolioFormVat) async throws -> Receipt
    
    func cancelReceipt(request: ReceiptServiceRequest.CancelReceiptRequest) async throws -> Receipt
    func voidReceipt(request: ReceiptServiceRequest.VoidReceiptRequest) async throws -> Receipt
    
    func previewEmail(request: ReceiptServiceRequest.PreviewEmail) async throws -> ReceiptServiceResponse.PreviewEmail
    func previewPDF(request: ReceiptServiceRequest.PreviewPDF) async throws -> ReceiptServiceResponse.PreviewPDF
    func exportPDF(request: ReceiptServiceRequest.ExportPDF) async throws -> PdfUrl
    func exportImage(request: ReceiptServiceRequest.ExportImage) async throws -> ImageUrl
}

class ReceiptRemoteService: ReceiptServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: ReceiptServiceRequest.FetchByHotel) async throws -> Paginator<Receipt> {
        let router = ReceiptServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByQuery(request: ReceiptServiceRequest.FetchByQuery) async throws -> Paginator<Receipt> {
        let router = ReceiptServiceRouter.fetchByQuery(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByPeriod(request: ReceiptServiceRequest.FetchByPeriod) async throws -> Paginator<Receipt> {
        let router = ReceiptServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByReservation(request: ReceiptServiceRequest.FetchByReservation) async throws -> Paginator<Receipt> {
        let router = ReceiptServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByFolioForm(request: ReceiptServiceRequest.FetchByFolioForm) async throws -> Paginator<Receipt> {
        let router = ReceiptServiceRouter.fetchByFolioForm(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByFinancialRecord(request: ReceiptServiceRequest.FetchByFinancialRecord) async throws -> Paginator<Receipt> {
        let router = ReceiptServiceRouter.fetchByFinancialRecord(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: ReceiptServiceRequest.FetchById) async throws -> Receipt {
        let router = ReceiptServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createFromFinancialRecord(request: ReceiptServiceRequest.CreateFromFinancialRecord) async throws -> Receipt {
        let router = ReceiptServiceRouter.createFromFinancialRecord(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createFromFolioForm(request: ReceiptServiceRequest.CreateFromFolioForm) async throws -> Receipt {
        let router = ReceiptServiceRouter.createFromFolioForm(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createFromFolioFormVat(request: ReceiptServiceRequest.CreateFromFolioFormVat) async throws -> Receipt {
        let router = ReceiptServiceRouter.createFromFolioFormVat(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func cancelReceipt(request: ReceiptServiceRequest.CancelReceiptRequest) async throws -> Receipt {
        let router = ReceiptServiceRouter.cancelReceipt(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func voidReceipt(request: ReceiptServiceRequest.VoidReceiptRequest) async throws -> Receipt {
        let router = ReceiptServiceRouter.voidReceipt(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func previewEmail(request: ReceiptServiceRequest.PreviewEmail) async throws -> ReceiptServiceResponse.PreviewEmail {
        let router = ReceiptServiceRouter.previewEmail(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func previewPDF(request: ReceiptServiceRequest.PreviewPDF) async throws -> ReceiptServiceResponse.PreviewPDF {
        let router = ReceiptServiceRouter.previewPDF(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func exportPDF(request: ReceiptServiceRequest.ExportPDF) async throws -> PdfUrl {
        let router = ReceiptServiceRouter.exportPDF(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func exportImage(request: ReceiptServiceRequest.ExportImage) async throws -> ImageUrl {
        let router = ReceiptServiceRouter.exportImage(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 