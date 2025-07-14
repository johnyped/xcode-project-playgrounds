//
//  CMCalendarServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import Alamofire
import Foundation

enum CMCalendarServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByMonth(request: CMCalendarServiceRequest.FetchByMonth)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByMonth:
            return "/v4/cm-calendar/month"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByMonth:
            return .get
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchByMonth(let request):
            return request.parameters
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
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return try encoding.encode(request, with: parameters)
    }
} 
