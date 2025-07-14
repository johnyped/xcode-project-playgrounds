//
//  CompanyServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum CompanyServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: CompanyServiceRequest.FetchByHotel)
    case fetchByGuest(request: CompanyServiceRequest.FetchByGuest)
    case fetchById(request: CompanyServiceRequest.FetchById)
    case createCompany(request: CompanyServiceRequest.CreateCompany)
    case updateCompany(request: CompanyServiceRequest.UpdateCompany)
    case hideCompany(request: CompanyServiceRequest.HideCompany)
    case unhideCompany(request: CompanyServiceRequest.UnhideCompany)
    case deleteCompany(request: CompanyServiceRequest.DeleteCompany)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/companies"
        case .fetchByGuest:
            return "/v4/companies/guest"
        case .fetchById(let request):
            return "/v4/companies/\(request.id)"
        case .createCompany:
            return "/v4/companies"
        case .updateCompany(let request):
            return "/v4/companies/\(request.id)"
        case .hideCompany(let request):
            return "/v4/companies/\(request.id)/hide"
        case .unhideCompany(let request):
            return "/v4/companies/\(request.id)/unhide"
        case .deleteCompany(let request):
            return "/v4/companies/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByGuest, .fetchById:
            return .get
        case .createCompany, .hideCompany, .unhideCompany:
            return .post
        case .updateCompany:
            return .put
        case .deleteCompany:
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
        case .fetchByGuest(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createCompany(let request):
            return request.body
        case .updateCompany(let request):
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
