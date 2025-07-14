//
//  NotificationItemServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct NotificationItemServiceRequest {
    
    typealias FetchNotification = ByID
    typealias DeleteNotification = ByID
    typealias MarkNotificationAsRead = ByID
    
    struct ByID {
        let id: Int
    }
    
    struct FetchNotifications: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
    }
    
    struct FetchNotificationCount: Encodable {
        let hotelId: Int?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
    }
    
    struct MarkAllNotificationsAsRead: Encodable {
        let hotelId: Int?
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
        }
    }
    
    struct DeleteAllNotifications: Encodable {
        let hotelId: Int?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
    }
} 
