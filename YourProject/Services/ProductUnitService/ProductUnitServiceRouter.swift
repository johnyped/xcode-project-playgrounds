//
//  ProductUnitServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum ProductUnitServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: ProductUnitServiceRequest.FetchByHotel)
    
    case fetchById(request: ProductUnitServiceRequest.FetchById)
    case createProductUnit(request: ProductUnitServiceRequest.CreateProductUnit)
    case updateProductUnit(request: ProductUnitServiceRequest.UpdateProductUnit)
    case deleteProductUnit(request: ProductUnitServiceRequest.DeleteProductUnit)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/product-units"
        case .fetchById(let request):
            return "/v4/product-units/\(request.id)"
        case .createProductUnit:
            return "/v4/product-units"
        case .updateProductUnit(let request):
            return "/v4/product-units/\(request.id)"
        case .deleteProductUnit(let request):
            return "/v4/product-units/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchById:
            return .get
        case .createProductUnit:
            return .post
        case .updateProductUnit:
            return .put
        case .deleteProductUnit:
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
        case .createProductUnit(let request):
            return request.body
        case .updateProductUnit(let request):
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
