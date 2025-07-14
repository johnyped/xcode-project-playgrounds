//
//  ReservableDateRangeServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Alamofire
import Foundation

enum ReservableDateRangeServiceRouter: AlamofireBaseRouterProtocol {
    case fetchReservableDateRanges(request: ReservableDateRangeServiceRequest.FetchReservableDateRanges)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchReservableDateRanges:
            return "/v4/reservable-date-ranges"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchReservableDateRanges:
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
        case .fetchReservableDateRanges(let request):
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