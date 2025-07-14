//  BlackoutServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//
import Alamofire
import Foundation

enum BlackoutServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByPeriod(request: BlackoutServiceRequest.FetchByPeriod)
    case fetchById(request: BlackoutServiceRequest.FetchById)
    case createBlackoutUnit(request: BlackoutServiceRequest.CreateBlackoutUnit)
    case updateBlackoutUnit(request: BlackoutServiceRequest.UpdateBlackoutUnit)
    case deleteBlackoutUnit(request: BlackoutServiceRequest.DeleteBlackoutUnit)
    case batchCreateBlackoutUnits(request: BlackoutServiceRequest.BatchCreateBlackoutUnits)
    case batchDeleteBlackoutUnits(request: BlackoutServiceRequest.BatchDeleteBlackoutUnits)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByPeriod:
            return "/v4/blackout-units/period"
        case .fetchById(let request):
            return "/v4/blackout-units/\(request.id)"
        case .createBlackoutUnit:
            return "/v4/blackout-units"
        case .updateBlackoutUnit(let request):
            return "/v4/blackout-units/\(request.id)"
        case .deleteBlackoutUnit(let request):
            return "/v4/blackout-units/\(request.id)"
        case .batchCreateBlackoutUnits:
            return "/v4/blackout-units/batch-create"
        case .batchDeleteBlackoutUnits:
            return "/v4/blackout-units/batch-delete"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByPeriod, .fetchById:
            return .get
        case .createBlackoutUnit, .batchCreateBlackoutUnits:
            return .post
        case .updateBlackoutUnit:
            return .put
        case .deleteBlackoutUnit, .batchDeleteBlackoutUnits:
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
        case .batchDeleteBlackoutUnits(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createBlackoutUnit(let request):
            return request.body
        case .updateBlackoutUnit(let request):
            return request.body
        case .batchCreateBlackoutUnits(let request):
            return request.body
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
