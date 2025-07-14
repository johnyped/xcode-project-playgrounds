//  FinancialRecordServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Alamofire
import Foundation

enum FinancialRecordServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByHotel(request: FinancialRecordServiceRequest.FetchByHotel)
    case fetchByPeriod(request: FinancialRecordServiceRequest.FetchByPeriod)
    case fetchByReservation(request: FinancialRecordServiceRequest.FetchByReservation)
    case fetchByCreatedAt(request: FinancialRecordServiceRequest.FetchByCreatedAt)
    case fetchByAccountItem(request: FinancialRecordServiceRequest.FetchByAccountItem)
    case fetchById(request: FinancialRecordServiceRequest.FetchById)
    case createFinancialRecord(request: FinancialRecordServiceRequest.CreateFinancialRecord)
    case updateFinancialRecord(request: FinancialRecordServiceRequest.UpdateFinancialRecord)
    case deleteFinancialRecord(request: FinancialRecordServiceRequest.DeleteFinancialRecord)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByHotel:
            return "/v4/financial-records"
        case .fetchByPeriod:
            return "/v4/financial-records/period"
        case .fetchByReservation:
            return "/v4/financial-records/reservation"
        case .fetchByCreatedAt:
            return "/v4/financial-records/created-at"
        case .fetchByAccountItem:
            return "/v4/financial-records/account-item"
        case .fetchById(let request):
            return "/v4/financial-records/\(request.id)"
        case .createFinancialRecord:
            return "/v4/financial-records"
        case .updateFinancialRecord(let request):
            return "/v4/financial-records/\(request.id)"
        case .deleteFinancialRecord(let request):
            return "/v4/financial-records/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByHotel, .fetchByPeriod, .fetchByReservation, .fetchByCreatedAt, .fetchByAccountItem, .fetchById:
            return .get
        case .createFinancialRecord:
            return .post
        case .updateFinancialRecord:
            return .put
        case .deleteFinancialRecord:
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
        case .fetchByPeriod(let request):
            return request.parameters
        case .fetchByReservation(let request):
            return request.parameters
        case .fetchByCreatedAt(let request):
            return request.parameters
        case .fetchByAccountItem(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createFinancialRecord(let request):
            return request.body
        case .updateFinancialRecord(let request):
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
