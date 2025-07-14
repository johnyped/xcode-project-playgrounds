//
//  AccountServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation
import Alamofire

enum AccountServiceRouter: AlamofireBaseRouterProtocol {
    
    // MARK: - Fetch Cases
    case fetchAccounts(request: AccountServiceRequest.FetchAccounts)
    case fetchAccount(request: AccountServiceRequest.FetchById)
    case fetchAccountBalance(request: AccountServiceRequest.FetchAccountBalance)
    
    // MARK: - CRUD Cases
    case createAccount(request: AccountServiceRequest.CreateAccount)
    case updateAccount(request: AccountServiceRequest.UpdateAccount)
    case deleteAccount(request: AccountServiceRequest.DeleteAccount)
    
    // MARK: - Additional Cases
    case setAccountAsDefault(request: AccountServiceRequest.SetAsDefault)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchAccounts:
            return "/v4/accounts"
        case .fetchAccount(let request):
            return "/v4/accounts/\(request.id)"
        case .fetchAccountBalance(let request):
            return "/v4/accounts/\(request.id)/balance"
        case .createAccount:
            return "/v4/accounts"
        case .updateAccount(let request):
            return "/v4/accounts/\(request.id)"
        case .deleteAccount(let request):
            return "/v4/accounts/\(request.id)"
        case .setAccountAsDefault(let request):
            return "/v4/accounts/\(request.id)/default"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchAccounts, .fetchAccount, .fetchAccountBalance:
            return .get
        case .createAccount, .setAccountAsDefault:
            return .post
        case .updateAccount:
            return .put
        case .deleteAccount:
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
        case .fetchAccounts(let request):
            return request.parameters
        case .fetchAccountBalance(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createAccount(let request):
            return request.body
        case .updateAccount(let request):
            return request.body
        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = URLEncoding.default
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return try encoding.encode(request, with: parameters)
    }
}
