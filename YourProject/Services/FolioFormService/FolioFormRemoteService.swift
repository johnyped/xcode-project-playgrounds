//  FolioFormRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol FolioFormServiceProtocol: AnyObject {
    func fetchByHotel(request: FolioFormServiceRequest.FetchByHotel) async throws -> Paginator<FolioForm>
    func fetchByQuery(request: FolioFormServiceRequest.FetchByQuery) async throws -> Paginator<FolioForm>
    func fetchByPeriod(request: FolioFormServiceRequest.FetchByPeriod) async throws -> Paginator<FolioForm>
    func fetchByReservation(request: FolioFormServiceRequest.FetchByReservation) async throws -> FolioForms
    
    func fetchById(request: FolioFormServiceRequest.FetchById) async throws -> FolioForm
    func createFolioFormReservation(request: FolioFormServiceRequest.CreateFolioFormReservation) async throws -> FolioForm
    func updateFolioForm(request: FolioFormServiceRequest.UpdateFolioForm) async throws -> FolioForm
    func cancelFolioForm(request: FolioFormServiceRequest.CancelFolioForm) async throws -> FolioForm
    
    func previewEmail(request: FolioFormServiceRequest.PreviewEmail) async throws -> FolioFormServiceResponse.PreviewEmail
    func previewPDF(request: FolioFormServiceRequest.PreviewPDF) async throws -> FolioFormServiceResponse.PreviewPDF
    func exportPDF(request: FolioFormServiceRequest.ExportPDF) async throws -> PdfUrl
    func exportImage(request: FolioFormServiceRequest.ExportImage) async throws -> ImageUrl
}

class FolioFormRemoteService: FolioFormServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: FolioFormServiceRequest.FetchByHotel) async throws -> Paginator<FolioForm> {
        let router = FolioFormServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByQuery(request: FolioFormServiceRequest.FetchByQuery) async throws -> Paginator<FolioForm> {
        let router = FolioFormServiceRouter.fetchByQuery(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByPeriod(request: FolioFormServiceRequest.FetchByPeriod) async throws -> Paginator<FolioForm> {
        let router = FolioFormServiceRouter.fetchByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchByReservation(request: FolioFormServiceRequest.FetchByReservation) async throws -> FolioForms {
        let router = FolioFormServiceRouter.fetchByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: FolioFormServiceRequest.FetchById) async throws -> FolioForm {
        let router = FolioFormServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createFolioFormReservation(request: FolioFormServiceRequest.CreateFolioFormReservation) async throws -> FolioForm {
        let router = FolioFormServiceRouter.createFolioFormReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateFolioForm(request: FolioFormServiceRequest.UpdateFolioForm) async throws -> FolioForm {
        let router = FolioFormServiceRouter.updateFolioForm(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func cancelFolioForm(request: FolioFormServiceRequest.CancelFolioForm) async throws -> FolioForm {
        let router = FolioFormServiceRouter.cancelFolioForm(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func previewEmail(request: FolioFormServiceRequest.PreviewEmail) async throws -> FolioFormServiceResponse.PreviewEmail {
        let router = FolioFormServiceRouter.previewEmail(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func previewPDF(request: FolioFormServiceRequest.PreviewPDF) async throws -> FolioFormServiceResponse.PreviewPDF {
        let router = FolioFormServiceRouter.previewPDF(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func exportPDF(request: FolioFormServiceRequest.ExportPDF) async throws -> PdfUrl {
        let router = FolioFormServiceRouter.exportPDF(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func exportImage(request: FolioFormServiceRequest.ExportImage) async throws -> ImageUrl {
        let router = FolioFormServiceRouter.exportImage(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    
}
