//  AccountSubItemCategoryServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//
import Alamofire
import Foundation

enum AccountSubItemCategoryServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: AccountSubItemCategoryServiceRequest.FetchByHotel)
    case fetchByAccountItemCategory(request: AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory)
    case fetchById(request: AccountSubItemCategoryServiceRequest.FetchById)
    case createAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory)
    case updateAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory)
    case deleteAccountSubItemCategory(request: AccountSubItemCategoryServiceRequest.DeleteAccountSubItemCategory)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/account-sub-item-categories"
        case .fetchByAccountItemCategory:
            return "/v4/account-sub-item-categories/account-item-categories"
        case .fetchById(let request):
            return "/v4/account-sub-item-categories/\(request.id)"
        case .createAccountSubItemCategory:
            return "/v4/account-sub-item-categories"
        case .updateAccountSubItemCategory(let request):
            return "/v4/account-sub-item-categories/\(request.id)"
        case .deleteAccountSubItemCategory(let request):
            return "/v4/account-sub-item-categories/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByAccountItemCategory, .fetchById:
            return .get
        case .createAccountSubItemCategory:
            return .post
        case .updateAccountSubItemCategory:
            return .put
        case .deleteAccountSubItemCategory:
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
        case .fetchByAccountItemCategory(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createAccountSubItemCategory(let request):
            return request.body
        case .updateAccountSubItemCategory(let request):
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