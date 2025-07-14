//  CMBookingServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Alamofire
import Foundation

enum CMBookingServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: CMBookingServiceRequest.FetchByHotel)
    case fetchByPeriod(request: CMBookingServiceRequest.FetchByPeriod)
    case fetchByStatus(request: CMBookingServiceRequest.FetchByStatus)
    case fetchByKeyword(request: CMBookingServiceRequest.FetchByKeyword)
    case fetchByBatchIds(request: CMBookingServiceRequest.FetchByBatchIds)
    case fetchById(request: CMBookingServiceRequest.FetchById)
    
    case acknowledge(request: CMBookingServiceRequest.Acknowledge)
    case batchAcknowledge(request: CMBookingServiceRequest.BatchAcknowledge)
    case sync(request: CMBookingServiceRequest.Sync)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/cm-bookings"
        case .fetchByPeriod:
            return "/v4/cm-bookings/period"
        case .fetchByStatus:
            return "/v4/cm-bookings/status"
        case .fetchByKeyword:
            return "/v4/cm-bookings/keyword"
        case .fetchByBatchIds:
            return "/v4/cm-bookings/batch"
        case .fetchById(let request):
            return "/v4/cm-bookings/\(request.id)"
        case .acknowledge(let request):
            return "/v4/cm-bookings/\(request.id)/acknowledge"
        case .batchAcknowledge:
            return "/v4/cm-bookings/batch-acknowledge"
        case .sync:
            return "/v4/cm-bookings/sync"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByPeriod, .fetchByStatus, .fetchByKeyword, .fetchByBatchIds, .fetchById:
            return .get
        case .acknowledge, .batchAcknowledge, .sync:
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
        case .fetchByHotel(let request):
            return request.parameters
        case .fetchByPeriod(let request):
            return request.parameters
        case .fetchByStatus(let request):
            return request.parameters
        case .fetchByKeyword(let request):
            return request.parameters
        case .fetchByBatchIds(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .batchAcknowledge(let request):
            return request.body
        case .sync(let request):
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
