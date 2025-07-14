//
//  BankAccountServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Alamofire
import Foundation

enum BankAccountServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchBankAccounts(request: BankAccountServiceRequest.FetchBankAccounts)
    case fetchBankAccount(request: BankAccountServiceRequest.FetchBankAccount)
    case createBankAccount(request: BankAccountServiceRequest.CreateBankAccount)
    case updateBankAccount(request: BankAccountServiceRequest.UpdateBankAccount)
    case deleteBankAccount(request: BankAccountServiceRequest.DeleteBankAccount)
    case setDefaultBankAccount(request: BankAccountServiceRequest.SetDefaultBankAccount)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchBankAccounts:
            return "/v4/bank-accounts"
        case .fetchBankAccount(let request):
            return "/v4/bank-accounts/\(request.id)"
        case .createBankAccount:
            return "/v4/bank-accounts"
        case .updateBankAccount(let request):
            return "/v4/bank-accounts/\(request.id)"
        case .deleteBankAccount(let request):
            return "/v4/bank-accounts/\(request.id)"
        case .setDefaultBankAccount(let request):
            return "/v4/bank-accounts/\(request.id)/default"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchBankAccounts, .fetchBankAccount:
            return .get
        case .createBankAccount:
            return .post
        case .updateBankAccount:
            return .put
        case .deleteBankAccount:
            return .delete
        case .setDefaultBankAccount:
            return .post
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchBankAccounts(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createBankAccount(let request):
            return request.body
        case .updateBankAccount(let request):
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
        
        headers?.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request,
                                   with: parameters)
    }
} 
