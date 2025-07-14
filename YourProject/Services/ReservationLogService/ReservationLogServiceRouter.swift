//  ReservationLogServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import Alamofire
import Foundation

enum ReservationLogServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByReservation(request: ReservationLogServiceRequest.FetchByReservation)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByReservation:
            return "/v4/reservation-logs"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByReservation:
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
        case .fetchByReservation(let request):
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
