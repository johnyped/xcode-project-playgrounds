//
//  NotificationSetting.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct NotificationSettings: Codable {
    let notificationLanguage: String
    let registeredLineAccessToken: Bool
    let pushNotification: NotificationConfig
    let lineNotification: NotificationConfig
    
    enum CodingKeys: String, CodingKey {
        case notificationLanguage = "notification_language"
        case registeredLineAccessToken = "registered_line_access_token"
        case pushNotification = "push_notification"
        case lineNotification = "line_notification"
    }
        
}

extension NotificationSettings {
    struct NotificationConfig: Codable {
        let cmBooking: MessageConfig
        let hmsReservation: MessageConfig
        let broadcastMessage: BroadcastConfig
        
        enum CodingKeys: String, CodingKey {
            case cmBooking = "cm_booking"
            case hmsReservation = "hms_reservation"
            case broadcastMessage = "broadcast_message"
        }
    }
    
    struct MessageConfig: Codable {
        let newMessage: Bool
        let updatedMessage: Bool
        let cancelledMessage: Bool
        
        enum CodingKeys: String, CodingKey {
            case newMessage = "new_message"
            case updatedMessage = "updated_message"
            case cancelledMessage = "cancelled_message"
        }
    }
    
    struct BroadcastConfig: Codable {
        let adminMessage: Bool
        let systemMessage: Bool
        let operatorMessage: Bool
        
        enum CodingKeys: String, CodingKey {
            case adminMessage = "admin_message"
            case systemMessage = "system_message"
            case operatorMessage = "operator_message"
        }
    }
}
/*
 {
     "notification_language": "th",
     "registered_line_access_token": true,
     "push_notification": {
         "cm_booking": {
             "new_message": true,
             "updated_message": true,
             "cancelled_message": true
         },
         "hms_reservation": {
             "new_message": true,
             "updated_message": true,
             "cancelled_message": true
         },
         "broadcast_message": {
             "admin_message": true,
             "system_message": true,
             "operator_message": true
         }
     },
     "line_notification": {
         "cm_booking": {
             "new_message": true,
             "updated_message": true,
             "cancelled_message": true
         },
         "hms_reservation": {
             "new_message": true,
             "updated_message": true,
             "cancelled_message": true
         },
         "broadcast_message": {
             "admin_message": true,
             "system_message": true,
             "operator_message": true
         }
     }
 }
 */
