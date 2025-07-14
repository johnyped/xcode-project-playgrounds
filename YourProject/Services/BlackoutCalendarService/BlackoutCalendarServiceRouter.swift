//  BlackoutCalendarServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//
import Alamofire
import Foundation

enum BlackoutCalendarServiceRouter: AlamofireBaseRouterProtocol {
        
    case fetchByMonth(request: BlackoutCalendarServiceRequest.FetchByMonth)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchByMonth:
            return "/v4/blackout-calendar/month"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchByMonth:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchByMonth(let request):
            return request.parameters               
        }
    }
        
     var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
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
        let encoding: ParameterEncoding = (method == .get || method == .delete) ? URLEncoding.default : JSONEncoding.default
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return try encoding.encode(request, with: parameters)
    }
} 
