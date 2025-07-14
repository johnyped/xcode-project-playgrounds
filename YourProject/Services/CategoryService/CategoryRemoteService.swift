//
//  CategoryRemoteService.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation
import Alamofire
import Mockable

@Mockable
protocol CategoryServiceProtocol: AnyObject {
    func fetchCategories(request: CategoryServiceRequest.FetchCategories) async throws -> Paginator<Category>
    
    func fetchCategoryById(request: CategoryServiceRequest.FetchById) async throws -> Category
    func createCategory(request: CategoryServiceRequest.CreateCategory) async throws -> Category
    func updateCategory(request: CategoryServiceRequest.UpdateCategory) async throws -> Category
    func deleteCategory(request: CategoryServiceRequest.DeleteCategory) async throws
}

class CategoryRemoteService: CategoryServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchCategories(request: CategoryServiceRequest.FetchCategories) async throws -> Paginator<Category> {
        let router = CategoryServiceRouter.fetchCategories(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchCategoryById(request: CategoryServiceRequest.FetchById) async throws -> Category {
        let router = CategoryServiceRouter.fetchCategoryById(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createCategory(request: CategoryServiceRequest.CreateCategory) async throws -> Category {
        let router = CategoryServiceRouter.createCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateCategory(request: CategoryServiceRequest.UpdateCategory) async throws -> Category {
        let router = CategoryServiceRouter.updateCategory(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteCategory(request: CategoryServiceRequest.DeleteCategory) async throws {
        let router = CategoryServiceRouter.deleteCategory(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
} 
