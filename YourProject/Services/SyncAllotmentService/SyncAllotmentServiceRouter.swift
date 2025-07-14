//  SyncAllotmentServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//
import Alamofire
import Foundation

enum SyncAllotmentServiceRouter: AlamofireBaseRouterProtocol {    
    case fetchById(request: SyncAllotmentServiceRequest.FetchById)
    case createSyncAllotment(request: SyncAllotmentServiceRequest.CreateSyncAllotment)    

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchById(let request):
            return "/v4/sync-allotments/\(request.id)"
        case .createSyncAllotment:
            return "/v4/sync-allotments"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchById:
            return .get
        case .createSyncAllotment:
            return .post            
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createSyncAllotment(let request):
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