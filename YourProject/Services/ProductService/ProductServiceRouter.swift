//
//  ProductServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum ProductServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: ProductServiceRequest.FetchByHotel)
    
    case fetchById(request: ProductServiceRequest.FetchById)
    
    case createProduct(request: ProductServiceRequest.CreateProduct)
    case updateProduct(request: ProductServiceRequest.UpdateProduct)
    case deleteProduct(request: ProductServiceRequest.DeleteProduct)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/products"
        case .fetchById(let request):
            return "/v4/products/\(request.id)"
        case .createProduct:
            return "/v4/products"
        case .updateProduct(let request):
            return "/v4/products/\(request.id)"
        case .deleteProduct(let request):
            return "/v4/products/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchById:
            return .get
        case .createProduct:
            return .post
        case .updateProduct:
            return .put
        case .deleteProduct:
            return .delete
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchByHotel(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createProduct(let request):
            return request.body
        case .updateProduct(let request):
            return request.body
        default:
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
