//
//  CMRateServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Alamofire
import Foundation

enum CMRateServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByPeriod(request: CMRateServiceRequest.FetchByPeriod)
    case fetchByHotel(request: CMRateServiceRequest.FetchByHotel)
    case fetchByRoomType(request: CMRateServiceRequest.FetchByRoomType)
    case fetchById(request: CMRateServiceRequest.FetchById)
    case createCMRate(request: CMRateServiceRequest.CreateCMRate)
    case updateCMRate(request: CMRateServiceRequest.UpdateCMRate)
    case deleteCMRate(request: CMRateServiceRequest.DeleteCMRate)
    case changeUnitable(request: CMRateServiceRequest.ChangeUnitableRequest)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByPeriod:
            return "/v4/cm-rates/period"
        case .fetchByHotel:
            return "/v4/cm-rates"
        case .fetchByRoomType:
            return "/v4/cm-rates/room-type"
        case .fetchById(let request):
            return "/v4/cm-rates/\(request.id)"
        case .createCMRate:
            return "/v4/cm-rates"
        case .updateCMRate(let request):
            return "/v4/cm-rates/\(request.id)"
        case .deleteCMRate(let request):
            return "/v4/cm-rates/\(request.id)"
        case .changeUnitable(let request):
            return "/v4/cm-rates/\(request.id)/change-unitable"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByPeriod, .fetchByHotel, .fetchByRoomType, .fetchById:
            return .get
        case .createCMRate:
            return .post
        case .updateCMRate, .changeUnitable:
            return .put
        case .deleteCMRate:
            return .delete
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchByPeriod(let request):
            return request.parameters
        case .fetchByHotel(let request):
            return request.parameters
        case .fetchByRoomType(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createCMRate(let request):
            return request.body
        case .updateCMRate(let request):
            return request.body
        case .changeUnitable(let request):
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