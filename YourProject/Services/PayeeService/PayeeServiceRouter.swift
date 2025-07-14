//
//  PayeeServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Alamofire
import Foundation

enum PayeeServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: PayeeServiceRequest.FetchByHotel)
    case fetchById(request: PayeeServiceRequest.FetchById)
    case createPayee(request: PayeeServiceRequest.CreatePayee)
    case updatePayee(request: PayeeServiceRequest.UpdatePayee)
    case deletePayee(request: PayeeServiceRequest.DeletePayee)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/payees"
        case .fetchById(let request):
            return "/v4/payees/\(request.id)"
        case .createPayee:
            return "/v4/payees"
        case .updatePayee(let request):
            return "/v4/payees/\(request.id)"
        case .deletePayee(let request):
            return "/v4/payees/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchById:
            return .get
        case .createPayee:
            return .post
        case .updatePayee:
            return .put
        case .deletePayee:
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
        case .fetchByHotel(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createPayee(let request):
            return request.body
        case .updatePayee(let request):
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