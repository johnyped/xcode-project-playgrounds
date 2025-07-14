//  ReservationItemServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Alamofire
import Foundation

enum ReservationItemServiceRouter: AlamofireBaseRouterProtocol {
    case fetchByReservation(request: ReservationItemServiceRequest.FetchByReservation)
    case fetchById(request: ReservationItemServiceRequest.FetchById)
    case updateReservationItem(request: ReservationItemServiceRequest.UpdateReservationItem)
    case deleteReservationItem(request: ReservationItemServiceRequest.DeleteReservationItem)
    case replaceReservationItems(request: ReservationItemServiceRequest.ReplaceReservationItems)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByReservation:
            return "/v4/reservation-items"
        case .fetchById(let request):
            return "/v4/reservation-items/\(request.id)"
        case .updateReservationItem(let request):
            return "/v4/reservation-items/\(request.id)"
        case .deleteReservationItem(let request):
            return "/v4/reservation-items/\(request.id)"
        case .replaceReservationItems:
            return "/v4/reservation-items/replace"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByReservation, .fetchById:
            return .get
        case .replaceReservationItems, .updateReservationItem:
            return .put
        case .deleteReservationItem:
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
        case .fetchByReservation(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .updateReservationItem(let request):
            return request.body
        case .replaceReservationItems(let request):
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
