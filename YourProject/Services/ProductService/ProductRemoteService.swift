//
//  ProductRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Mockable

@Mockable
protocol ProductServiceProtocol: AnyObject {
    func fetchByHotel(request: ProductServiceRequest.FetchByHotel) async throws -> Paginator<Product>
    
    func fetchById(request: ProductServiceRequest.FetchById) async throws -> Product
    
    func createProduct(request: ProductServiceRequest.CreateProduct) async throws -> Product
    func updateProduct(request: ProductServiceRequest.UpdateProduct) async throws -> Product
    func deleteProduct(request: ProductServiceRequest.DeleteProduct) async throws -> Product
}

class ProductRemoteService: ProductServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchByHotel(request: ProductServiceRequest.FetchByHotel) async throws -> Paginator<Product> {
        let router = ProductServiceRouter.fetchByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }    
    
    func fetchById(request: ProductServiceRequest.FetchById) async throws -> Product {
        let router = ProductServiceRouter.fetchById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createProduct(request: ProductServiceRequest.CreateProduct) async throws -> Product {
        let router = ProductServiceRouter.createProduct(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateProduct(request: ProductServiceRequest.UpdateProduct) async throws -> Product {
        let router = ProductServiceRouter.updateProduct(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteProduct(request: ProductServiceRequest.DeleteProduct) async throws -> Product {
        let router = ProductServiceRouter.deleteProduct(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
