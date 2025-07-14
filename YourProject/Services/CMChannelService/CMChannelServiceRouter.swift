//  CMChannelServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//
import Alamofire
import Foundation

enum CMChannelServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: CMChannelServiceRequest.FetchByHotel)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/cm-channels"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel:
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
        case .fetchByHotel(let request):
            return request.parameters
        }
    }

    var body: Data? {
        return nil
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