//
//  CategoryServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum CategoryServiceRouter: AlamofireBaseRouterProtocol {
    case fetchCategories(request: CategoryServiceRequest.FetchCategories)
    
    case fetchCategoryById(request: CategoryServiceRequest.FetchById)
    case createCategory(request: CategoryServiceRequest.CreateCategory)
    case updateCategory(request: CategoryServiceRequest.UpdateCategory)
    case deleteCategory(request: CategoryServiceRequest.DeleteCategory)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchCategories, .createCategory:
            return "/v4/categories"
        case .fetchCategoryById(let request):
            return "/v4/categories/\(request.id)"
        case .updateCategory(let request):
            return "/v4/categories/\(request.id)"
        case .deleteCategory(let request):
            return "/v4/categories/\(request.id)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchCategories, .fetchCategoryById:
            return .get
        case .createCategory:
            return .post
        case .updateCategory:
            return .put
        case .deleteCategory:
            return .delete
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchCategories(let request):
            return request.parameters
        
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var body: Data? {
        switch self {
        case .createCategory(let request):
            return request.body
        case .updateCategory(let request):
            return request.body
        case .fetchCategories, .fetchCategoryById, .deleteCategory:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return try encoding.encode(request, with: parameters)
    }
}
