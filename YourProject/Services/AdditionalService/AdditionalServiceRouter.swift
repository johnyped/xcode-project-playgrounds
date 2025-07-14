//
//  AdditionalServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum AdditionalServiceRouter: AlamofireBaseRouterProtocol {
    case fetchAdditionals(request: AdditionalServiceRequest.FetchAdditionals)
    case fetchAdditionalById(request: AdditionalServiceRequest.FetchById)
    case fetchAdditionalsByCreatedAt(request: AdditionalServiceRequest.FetchAdditionalsByCreatedAt)
    case fetchAdditionalsByDateIssue(request: AdditionalServiceRequest.FetchAdditionalsByDateIssue)
    
    case createAdditional(request: AdditionalServiceRequest.CreateAdditional)
    case updateAdditional(request: AdditionalServiceRequest.UpdateAdditional)
    case deleteAdditional(request: AdditionalServiceRequest.DeleteAdditional)
    
    case voidAdditional(request: AdditionalServiceRequest.VoidAdditional)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchAdditionals:
            return "/v4/additionals"
        case .fetchAdditionalById(let request):
            return "/v4/additionals/\(request.id)"
        case .fetchAdditionalsByCreatedAt:
            return "/v4/additionals/created-at"
        case .fetchAdditionalsByDateIssue:
            return "/v4/additionals/date-issue"
        case .createAdditional:
            return "/v4/additionals"
        case .updateAdditional(let request):
            return "/v4/additionals/\(request.id)"
        case .deleteAdditional(let request):
            return "/v4/additionals/\(request.id)"
        case .voidAdditional(let request):
            return "/v4/additionals/\(request.id)/void"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchAdditionals, .fetchAdditionalById, .fetchAdditionalsByCreatedAt, .fetchAdditionalsByDateIssue:
            return .get
        case .createAdditional, .voidAdditional:
            return .post
        case .updateAdditional:
            return .put
        case .deleteAdditional:
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
        case .fetchAdditionals(let request):
            return request.parameters
        case .fetchAdditionalsByCreatedAt(let request):
            return request.parameters
        case .fetchAdditionalsByDateIssue(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createAdditional(let request):
            return request.body
        case .updateAdditional(let request):
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
