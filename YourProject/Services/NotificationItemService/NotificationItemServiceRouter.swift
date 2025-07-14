//
//  NotificationItemServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Alamofire
import Foundation

enum NotificationItemServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchNotifications(request: NotificationItemServiceRequest.FetchNotifications)
    case fetchNotification(request: NotificationItemServiceRequest.FetchNotification)
    case deleteNotification(request: NotificationItemServiceRequest.DeleteNotification)
    case markNotificationAsRead(request: NotificationItemServiceRequest.MarkNotificationAsRead)
    case fetchNotificationCount(request: NotificationItemServiceRequest.FetchNotificationCount)
    case markAllNotificationsAsRead(request: NotificationItemServiceRequest.MarkAllNotificationsAsRead)
    case deleteAllNotifications(request: NotificationItemServiceRequest.DeleteAllNotifications)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchNotifications:
            return "/v4/notifications"
        case .fetchNotification(let request):
            return "/v4/notifications/\(request.id)"
        case .deleteNotification(let request):
            return "/v4/notifications/\(request.id)"
        case .markNotificationAsRead(let request):
            return "/v4/notifications/\(request.id)/read"
        case .fetchNotificationCount:
            return "/v4/notifications/count"
        case .markAllNotificationsAsRead:
            return "/v4/notifications/read-all"
        case .deleteAllNotifications:
            return "/v4/notifications/delete-all"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchNotifications, .fetchNotification, .fetchNotificationCount:
            return .get
        case .deleteNotification, .deleteAllNotifications:
            return .delete
        case .markNotificationAsRead, .markAllNotificationsAsRead:
            return .put
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchNotifications(let request):
            return request.parameters
        case .fetchNotificationCount(let request):
            return request.parameters
        case .deleteAllNotifications(let request):
            return request.parameters
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .markAllNotificationsAsRead(let request):
            return request.body
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = (method == .get || method == .delete) ? URLEncoding.default : JSONEncoding.default
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
