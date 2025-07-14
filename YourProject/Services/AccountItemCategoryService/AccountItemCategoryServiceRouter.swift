//  AccountItemCategoryServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//
import Alamofire
import Foundation

enum AccountItemCategoryServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: AccountItemCategoryServiceRequest.FetchByHotel)
    case fetchById(request: AccountItemCategoryServiceRequest.FetchById)
    case fetchSubCategories(request: AccountItemCategoryServiceRequest.FetchSubCategories)
    case createAccountItemCategory(request: AccountItemCategoryServiceRequest.CreateAccountItemCategory)
    case updateAccountItemCategory(request: AccountItemCategoryServiceRequest.UpdateAccountItemCategory)
    case deleteAccountItemCategory(request: AccountItemCategoryServiceRequest.DeleteAccountItemCategory)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/account-item-categories"
        case .fetchById(let request):
            return "/v4/account-item-categories/\(request.id)"
        case .fetchSubCategories(let request):
            return "/v4/account-item-categories/\(request.id)/sub-categories"
        case .createAccountItemCategory:
            return "/v4/account-item-categories"
        case .updateAccountItemCategory(let request):
            return "/v4/account-item-categories/\(request.id)"
        case .deleteAccountItemCategory(let request):
            return "/v4/account-item-categories/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchById, .fetchSubCategories:
            return .get
        case .createAccountItemCategory:
            return .post
        case .updateAccountItemCategory:
            return .put
        case .deleteAccountItemCategory:
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
        case .createAccountItemCategory(let request):
            return request.body
        case .updateAccountItemCategory(let request):
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