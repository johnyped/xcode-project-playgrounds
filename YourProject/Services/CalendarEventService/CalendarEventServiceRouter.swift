//  CalendarEventServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import Alamofire
import Foundation

enum CalendarEventServiceRouter: AlamofireBaseRouterProtocol {    
    case fetchByDay(request: CalendarEventServiceRequest.FetchByDay)
    case fetchByMonth(request: CalendarEventServiceRequest.FetchByMonth)
    case fetchById(request: CalendarEventServiceRequest.FetchById)
    case createCalendarEvent(request: CalendarEventServiceRequest.CreateCalendarEvent)
    case updateCalendarEvent(request: CalendarEventServiceRequest.UpdateCalendarEvent)
    case deleteCalendarEvent(request: CalendarEventServiceRequest.DeleteCalendarEvent)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .fetchByDay:
            return "/v4/calendar-events/day"
        case .fetchByMonth:
            return "/v4/calendar-events/month"
        case .fetchById(let request):
            return "/v4/calendar-events/\(request.id)"
        case .createCalendarEvent:
            return "/v4/calendar-events"
        case .updateCalendarEvent(let request):
            return "/v4/calendar-events/\(request.id)"
        case .deleteCalendarEvent(let request):
            return "/v4/calendar-events/\(request.id)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchByDay, .fetchByMonth, .fetchById:
            return .get
        case .createCalendarEvent:
            return .post
        case .updateCalendarEvent:
            return .put
        case .deleteCalendarEvent:
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
        case .fetchByDay(let request):
            return request.parameters
        case .fetchByMonth(let request):
            return request.parameters
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .createCalendarEvent(let request):
            return request.body
        case .updateCalendarEvent(let request):
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
