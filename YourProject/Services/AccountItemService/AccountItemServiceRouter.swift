//
//  AccountItemServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Alamofire
import Foundation

enum AccountItemServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByPeriod(request: AccountItemServiceRequest.FetchByPeriod)
    case fetchByKeyword(request: AccountItemServiceRequest.FetchByKeyword)
    
    case fetchById(request: AccountItemServiceRequest.FetchById)
    case createAccountItem(request: AccountItemServiceRequest.CreateAccountItem)
    case updateAccountItem(request: AccountItemServiceRequest.UpdateAccountItem)
    case deleteAccountItem(request: AccountItemServiceRequest.DeleteAccountItem)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByPeriod:
            return "/v4/account-items/period"
        case .fetchByKeyword:
            return "/v4/account-items/keyword"
        case .fetchById(let request):
            return "/v4/account-items/\(request.id)"
        case .createAccountItem:
            return "/v4/account-items"
        case .updateAccountItem(let request):
            return "/v4/account-items/\(request.id)"
        case .deleteAccountItem(let request):
            return "/v4/account-items/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByPeriod, .fetchByKeyword, .fetchById:
            return .get
        case .createAccountItem:
            return .post
        case .updateAccountItem:
            return .put
        case .deleteAccountItem:
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
        case .fetchByKeyword(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createAccountItem(let request):
            return request.body
        case .updateAccountItem(let request):
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