//
//  GuestServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum GuestServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchGuestsByHotel(request: GuestServiceRequest.FetchGuests)
    case fetchGuestsByQuery(request: GuestServiceRequest.FetchGuestsQuery)
    case fetchGuestsByCompany(request: GuestServiceRequest.FetchGuestsCompany)
    case fetchGuestsByReservation(request: GuestServiceRequest.FetchGuestsReservation)
    case fetchGuestsByDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset)
    case fetchGuest(request: GuestServiceRequest.FetchGuest)
    case createGuest(request: GuestServiceRequest.CreateGuest)
    case updateGuest(request: GuestServiceRequest.UpdateGuest)
    case deleteGuest(request: GuestServiceRequest.DeleteGuest)
    case hideGuest(id: Int)
    case unhideGuest(id: Int)
    case removeGuestCompany(id: Int)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchGuestsByHotel:
            return "/v4/guests"
        case .fetchGuestsByQuery:
            return "/v4/guests/query"
        case .fetchGuestsByCompany:
            return "/v4/guests/company"
        case .fetchGuestsByReservation:
            return "/v4/guests/reservation"
        case .fetchGuestsByDatetimeOffset:
            return "/v4/guests/datetime-offset"
        case .fetchGuest(let request):
            return "/v4/guests/\(request.id)"
        case .createGuest(_):
            return "/v4/guests"
        case .updateGuest(let request):
            return "/v4/guests/\(request.id)"
        case .deleteGuest(let request):
            return "/v4/guests/\(request.id)"
        case .hideGuest(let id):
            return "/v4/guests/\(id)/hide"
        case .unhideGuest(let id):
            return "/v4/guests/\(id)/unhide"
        case .removeGuestCompany(let id):
            return "/v4/guests/\(id)/remove_company"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchGuestsByHotel, .fetchGuestsByQuery, .fetchGuestsByCompany, .fetchGuestsByReservation, .fetchGuestsByDatetimeOffset, .fetchGuest:
            return .get
        case .createGuest:
            return .post
        case .updateGuest:
            return .put
        case .deleteGuest:
            return .delete
        case .hideGuest, .unhideGuest:
            return .post
        case .removeGuestCompany:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchGuestsByHotel(let request):
            return request.parameters
        case .fetchGuestsByQuery(let request):
            return request.parameters
        case .fetchGuestsByCompany(let request):
            return request.parameters
        case .fetchGuestsByReservation(let request):
            return request.parameters
        case .fetchGuestsByDatetimeOffset(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createGuest(let request):
            return request.body
        case .updateGuest(let request):
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
