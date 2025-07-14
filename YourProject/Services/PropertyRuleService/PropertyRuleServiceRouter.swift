//
//  PropertyRuleServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Alamofire
import Foundation

enum PropertyRuleServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchPropertyRuleContent(request: PropertyRuleServiceRequest.FetchPropertyRuleContent)
    case fetchPropertyRulePdfURLs(request: PropertyRuleServiceRequest.FetchPropertyRulePdfURLs)
    case fetchPropertyRuleHTMLURLs(request: PropertyRuleServiceRequest.FetchPropertyRuleHTMLURLs)
    case updatePropertyRuleContent(request: PropertyRuleServiceRequest.UpdatePropertyRuleContent)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchPropertyRuleContent(_):
            return "/v4/property-rules"
        case .fetchPropertyRulePdfURLs(_):
            return "/v4/property-rules"
        case .fetchPropertyRuleHTMLURLs(_):
            return "/v4/property-rules"
        case .updatePropertyRuleContent(_):
            return "/v4/property-rules"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchPropertyRuleContent, .fetchPropertyRulePdfURLs, .fetchPropertyRuleHTMLURLs:
            return .get
        case .updatePropertyRuleContent:
            return .put
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchPropertyRuleContent(let request):
            return request.parameters
        case .fetchPropertyRulePdfURLs(let request):
            return request.parameters
        case .fetchPropertyRuleHTMLURLs(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .updatePropertyRuleContent(let request):
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
        
        headers?.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request,
                                   with: parameters)
    }
} 
