//
//  ReservationServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum ReservationServiceRouter: AlamofireBaseRouterProtocol {
    
    // MARK: - Fetch Cases
    case fetchReservations(request: ReservationServiceRequest.FetchReservations)
    case fetchReservationsByFlags(request: ReservationServiceRequest.FetchReservationsByFlags)
    case fetchReservationsByGuest(request: ReservationServiceRequest.FetchReservationsByGuest)
    case fetchReservationsByCompany(request: ReservationServiceRequest.FetchReservationsByCompany)
    case fetchReservationsByPeriod(request: ReservationServiceRequest.FetchReservationsByPeriod)
    case fetchReservationsByCreatedAt(request: ReservationServiceRequest.FetchReservationsByCreatedAt)
    case fetchReservationsByTags(request: ReservationServiceRequest.FetchReservationsByTags)
    case fetchReservationsByKeyword(request: ReservationServiceRequest.FetchReservationsByKeyword)
    case fetchReservationsByBatchIds(request: ReservationServiceRequest.FetchReservationsByBatchIds)
    case fetchReservationByUid(request: ReservationServiceRequest.FetchReservationByUid)
    case fetchReservation(request: ReservationServiceRequest.FetchById)
    
    // MARK: - CM Cases
    case fetchReservationByCMBooking(request: ReservationServiceRequest.FetchReservationByCMBooking)
    case createReservationByCMBooking(request: ReservationServiceRequest.CreateReservationByCMBooking)
    
    // MARK: - CRUD Cases
    case createReservation(request: ReservationServiceRequest.CreateReservation)
    case updateReservation(request: ReservationServiceRequest.UpdateReservation)
    
    // MARK: - Status Change Cases
    case checkIn(request: ReservationServiceRequest.CheckIn)
    case checkOut(request: ReservationServiceRequest.CheckOut)
    case cancel(request: ReservationServiceRequest.Cancel)
    case noShow(request: ReservationServiceRequest.NoShow)
    
    // MARK: - Guest Management Cases
    case getFirstGuest(request: ReservationServiceRequest.SetFirstGuest)
    case dropGuest(request: ReservationServiceRequest.DropGuest)
    case appendGuest(request: ReservationServiceRequest.AppendGuest)
    case replaceGuests(request: ReservationServiceRequest.ReplaceGuests)
    
    // MARK: - Additional Cases
    case getConfirmation(request: ReservationServiceRequest.FetchConfirmation)
    case createConfirmation(request: ReservationServiceRequest.CreateConfirmation)
    
    case splitReservation(request: ReservationServiceRequest.SplitReservation)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        // Basic fetch endpoints
        case .fetchReservations:
            return "/v4/reservations"
        case .fetchReservationsByFlags:
            return "/v4/reservations/flags"
        case .fetchReservationsByGuest:
            return "/v4/reservations/guest"
        case .fetchReservationsByCompany:
            return "/v4/reservations/company"
        case .fetchReservationsByPeriod:
            return "/v4/reservations/period"
        case .fetchReservationsByCreatedAt:
            return "/v4/reservations/created-at"
        case .fetchReservationsByTags:
            return "/v4/reservations/tags"
        case .fetchReservationsByKeyword:
            return "/v4/reservations/keyword"
        case .fetchReservationsByBatchIds:
            return "/v4/reservations/batch-ids"
        case .fetchReservationByUid:
            return "/v4/reservations/uid"
        case .fetchReservation(let request):
            return "/v4/reservations/\(request.id)"
            
        // CM endpoints
        case .fetchReservationByCMBooking:
            return "/v4/reservations/cm-booking"
        case .createReservationByCMBooking:
            return "/v4/reservations/cm-bookings"
            
        // CRUD endpoints
        case .createReservation:
            return "/v4/reservations"
        case .updateReservation(let request):
            return "/v4/reservations/\(request.id)"
            
        // Status change endpoints
        case .checkIn(let request):
            return "/v4/reservations/\(request.id)/check-in"
        case .checkOut(let request):
            return "/v4/reservations/\(request.id)/check-out"
        case .cancel(let request):
            return "/v4/reservations/\(request.id)/cancel"
        case .noShow(let request):
            return "/v4/reservations/\(request.id)/no-show"
            
        // Guest management endpoints
        case .getFirstGuest(let request):
            return "/v4/reservations/\(request.id)/first-guest"
        case .dropGuest(let request):
            return "/v4/reservations/\(request.id)/drop-guest"
        case .appendGuest(let request):
            return "/v4/reservations/\(request.id)/append-guest"
        case .replaceGuests(let request):
            return "/v4/reservations/\(request.id)/replace-guests"
            
        // Additional endpoints
        case .getConfirmation(let request):
            return "/v4/reservations/\(request.id)/confirmation"
        case .createConfirmation(let request):
            return "/v4/reservations/\(request.id)/confirmation"
        case .splitReservation(let request):
            return "/v4/reservations/\(request.id)/split"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        // GET methods
        case .fetchReservations, .fetchReservationsByFlags, .fetchReservationsByGuest,
             .fetchReservationsByCompany, .fetchReservationsByPeriod, .fetchReservationsByCreatedAt,
             .fetchReservationsByTags, .fetchReservationsByKeyword, .fetchReservationsByBatchIds,
             .fetchReservationByUid, .fetchReservation, .fetchReservationByCMBooking, .getFirstGuest,
             .getConfirmation:
            return .get
            
        // POST methods
        case .createReservationByCMBooking, .createReservation, .checkIn, .checkOut,
             .cancel, .noShow, .appendGuest, .createConfirmation, .splitReservation:
            return .post
            
        // PUT methods
        case .updateReservation, .replaceGuests:
            return .put
            
        // DELETE methods
        case .dropGuest:
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
        case .fetchReservations(let request):
            return request.parameters
        case .fetchReservationsByFlags(let request):
            return request.parameters
        case .fetchReservationsByGuest(let request):
            return request.parameters
        case .fetchReservationsByCompany(let request):
            return request.parameters
        case .fetchReservationsByPeriod(let request):
            return request.parameters
        case .fetchReservationsByCreatedAt(let request):
            return request.parameters
        case .fetchReservationsByTags(let request):
            return request.parameters
        case .fetchReservationsByKeyword(let request):
            return request.parameters
        case .fetchReservationsByBatchIds(let request):
            return request.parameters
        case .fetchReservationByUid(let request):
            return request.parameters
        case .fetchReservationByCMBooking(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createReservationByCMBooking(let request):
            return request.body
        case .createReservation(let request):
            return request.body
        case .updateReservation(let request):
            return request.body
        case .dropGuest(let request):
            return request.body
        case .appendGuest(let request):
            return request.body
        case .replaceGuests(let request):
            return request.body
        case .createConfirmation(let request):
            return request.body
        case .splitReservation(let request):
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
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request, with: parameters)
    }
} 
