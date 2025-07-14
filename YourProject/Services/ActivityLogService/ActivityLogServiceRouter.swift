//  ActivityLogServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//
import Alamofire
import Foundation

enum ActivityLogServiceRouter: AlamofireBaseRouterProtocol {
    case fetchCreatorByFinancialRecord(request: ActivityLogServiceRequest.FetchCreatorByFinancialRecord)
    case fetchCreatorByReservation(request: ActivityLogServiceRequest.FetchCreatorByReservation)
    case fetchCreatorByAdditional(request: ActivityLogServiceRequest.FetchCreatorByAdditional)
    case fetchCreatorByAccount(request: ActivityLogServiceRequest.FetchCreatorByAccount)
    case fetchCreatorByAccountItem(request: ActivityLogServiceRequest.FetchCreatorByAccountItem)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchCreatorByFinancialRecord:
            return "/v4/activity-logs/creator/financial-record"
        case .fetchCreatorByReservation:
            return "/v4/activity-logs/creator/reservation"
        case .fetchCreatorByAdditional:
            return "/v4/activity-logs/creator/additional"
        case .fetchCreatorByAccount:
            return "/v4/activity-logs/creator/account"
        case .fetchCreatorByAccountItem:
            return "/v4/activity-logs/creator/account-item"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchCreatorByFinancialRecord, .fetchCreatorByReservation, .fetchCreatorByAdditional, .fetchCreatorByAccount, .fetchCreatorByAccountItem:
            return .get
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchCreatorByFinancialRecord(let request):
            return request.parameters
        case .fetchCreatorByReservation(let request):
            return request.parameters
        case .fetchCreatorByAdditional(let request):
            return request.parameters
        case .fetchCreatorByAccount(let request):
            return request.parameters
        case .fetchCreatorByAccountItem(let request):
            return request.parameters
        }
    }

    var body: Data? {
        return nil
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