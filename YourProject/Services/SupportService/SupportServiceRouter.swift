//
//  SupportServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum SupportServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchMinAppVersion
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchMinAppVersion:
            return "v4/supports/version"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchMinAppVersion:
            return .get
        }
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var body: Data? {
        nil
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
