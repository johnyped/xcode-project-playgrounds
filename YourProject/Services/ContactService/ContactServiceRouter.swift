//
//  ContactServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum ContactServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: ContactServiceRequest.FetchByHotel)
    case fetchByCompany(request: ContactServiceRequest.FetchByCompany)
    case fetchByCustomer(request: ContactServiceRequest.FetchByCustomer)
    
    case fetchById(request: ContactServiceRequest.FetchById)
    case createContact(request: ContactServiceRequest.CreateContact)
    case updateContact(request: ContactServiceRequest.UpdateContact)
    case deleteContact(request: ContactServiceRequest.DeleteContact)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/contacts"
        case .fetchByCompany:
            return "/v4/contacts/company"
        case .fetchByCustomer:
            return "/v4/contacts/customer"
        case .fetchById(let request):
            return "/v4/contacts/\(request.id)"
        case .createContact:
            return "/v4/contacts"
        case .updateContact(let request):
            return "/v4/contacts/\(request.id)"
        case .deleteContact(let request):
            return "/v4/contacts/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByCompany, .fetchByCustomer, .fetchById:
            return .get
        case .createContact:
            return .post
        case .updateContact:
            return .put
        case .deleteContact:
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
        case .fetchByCompany(let request):
            return request.parameters
        case .fetchByCustomer(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createContact(let request):
            return request.body
        case .updateContact(let request):
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
