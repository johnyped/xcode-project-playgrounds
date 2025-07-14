//
//  PDPAServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Alamofire
import Foundation

enum PDPAServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchPdpas(request: PDPAServiceRequest.FetchPdpas)
    case fetchPdpa(request: PDPAServiceRequest.FetchPdpa)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchPdpas(_):
            return "/v4/pdpa"
        case .fetchPdpa(let request):
            return "/v4/pdpa/\(request.id)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchPdpas, .fetchPdpa:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchPdpas(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
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
        
        headers?.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request,
                                   with: parameters)
    }
} 
