//
//  ProductUnitRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Mockable

@Mockable
protocol ProductUnitServiceProtocol: AnyObject {
    func fetchByHotel(request: ProductUnitServiceRequest.FetchByHotel) async throws -> Paginator<ProductUnit>
    
    func fetchById(request: ProductUnitServiceRequest.FetchById) async throws -> ProductUnit
    func createProductUnit(request: ProductUnitServiceRequest.CreateProductUnit) async throws -> ProductUnit
    func updateProductUnit(request: ProductUnitServiceRequest.UpdateProductUnit) async throws -> ProductUnit
    func deleteProductUnit(request: ProductUnitServiceRequest.DeleteProductUnit) async throws -> ProductUnit
}

class ProductUnitRemoteService: ProductUnitServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: ProductUnitServiceRequest.FetchByHotel) async throws -> Paginator<ProductUnit> {
        let router = ProductUnitServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchById(request: ProductUnitServiceRequest.FetchById) async throws -> ProductUnit {
        let router = ProductUnitServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createProductUnit(request: ProductUnitServiceRequest.CreateProductUnit) async throws -> ProductUnit {
        let router = ProductUnitServiceRouter.createProductUnit(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateProductUnit(request: ProductUnitServiceRequest.UpdateProductUnit) async throws -> ProductUnit {
        let router = ProductUnitServiceRouter.updateProductUnit(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteProductUnit(request: ProductUnitServiceRequest.DeleteProductUnit) async throws -> ProductUnit {
        let router = ProductUnitServiceRouter.deleteProductUnit(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
