//
//  GuestRegisterCardServiceRouter.swift
//  YourProject
//
//  Created by AI Assistant
//

import Alamofire
import Foundation

enum GuestRegisterCardServiceRouter: AlamofireBaseRouterProtocol {
    case fetchGuestRegisterCards(request: GuestRegisterCardServiceRequest.FetchGuestRegisterCards)
    case fetchByGuest(request: GuestRegisterCardServiceRequest.FetchByGuest)
    case fetchByReservation(request: GuestRegisterCardServiceRequest.FetchByReservation)
    case fetchByPeriod(request: GuestRegisterCardServiceRequest.FetchByPeriod)
    
    case fetchGuestRegisterCardById(request: GuestRegisterCardServiceRequest.FetchById)
    case updateGuestRegisterCard(request: GuestRegisterCardServiceRequest.UpdateGuestRegisterCard)
    case deleteGuestRegisterCard(request: GuestRegisterCardServiceRequest.DeleteGuestRegisterCard)
    
    case acceptPdpa(request: GuestRegisterCardServiceRequest.AcceptPdpa)
    case acceptRules(request: GuestRegisterCardServiceRequest.AcceptRules)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchGuestRegisterCards:
            return "/v4/guest-register-cards"
        case .fetchByGuest:
            return "/v4/guest-register-cards/guest"
        case .fetchByReservation:
            return "/v4/guest-register-cards/reservation"
        case .fetchByPeriod:
            return "/v4/guest-register-cards/period"
        case .fetchGuestRegisterCardById(let request):
            return "/v4/guest-register-cards/\(request.id)"
        case .updateGuestRegisterCard(let request):
            return "/v4/guest-register-cards/\(request.id)"
        case .deleteGuestRegisterCard(let request):
            return "/v4/guest-register-cards/\(request.id)"
        case .acceptPdpa(let request):
            return "/v4/guest-register-cards/\(request.id)/accept-pdpa"
        case .acceptRules(let request):
            return "/v4/guest-register-cards/\(request.id)/accept-rules"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchGuestRegisterCards, .fetchByGuest, .fetchByReservation, 
             .fetchByPeriod, .fetchGuestRegisterCardById:
            return .get
        case .updateGuestRegisterCard, .acceptPdpa, .acceptRules:
            return .put
        case .deleteGuestRegisterCard:
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
        case .fetchGuestRegisterCards(let request):
            return request.parameters
        case .fetchByGuest(let request):
            return request.parameters
        case .fetchByReservation(let request):
            return request.parameters
        case .fetchByPeriod(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .updateGuestRegisterCard(let request):
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
