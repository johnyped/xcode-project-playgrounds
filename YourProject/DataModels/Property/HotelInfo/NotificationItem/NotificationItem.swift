//
//  NotificationItem.swift
//  YourProject
//
//  Created by IntrodexMac on 11/6/2568 BE.
//

import Foundation

struct NotificationItem: Codable {
    let id: Int
    let notificationType: NotificationType
    let checkInDate: Date
    let checkOutDate: Date
    let notifiableId: Int
    let notifiableType: ItemKind
    let readed: Bool
    let readedAt: Date?
    let channelId: Int?
    let subChannelId: Int?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case notificationType = "notification_type"
        case checkInDate = "check_in_date"
        case checkOutDate = "check_out_date"
        case notifiableId = "notifiable_id"
        case notifiableType = "notifiable_type"
        case readed
        case readedAt = "readed_at"
        case channelId = "channel_id"
        case subChannelId = "sub_channel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int,
    notificationType: NotificationType,
     checkInDate: Date,
      checkOutDate: Date, 
      notifiableId: Int,
       notifiableType: ItemKind, 
       readed: Bool, 
       readedAt: Date?,
        channelId: Int?,
         subChannelId: Int?, 
         createdAt: Date,
          updatedAt: Date) {
        self.id = id
        self.notificationType = notificationType
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.notifiableId = notifiableId
        self.notifiableType = notifiableType
        self.readed = readed
        self.readedAt = readedAt
        self.channelId = channelId
        self.subChannelId = subChannelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        notificationType = try container.decode(NotificationType.self, forKey: .notificationType)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        checkInDate = try container.decode(String.self, forKey: .checkInDate).tryToDate(dateFormat: dateFormat)
        checkOutDate = try container.decode(String.self, forKey: .checkOutDate).tryToDate(dateFormat: dateFormat)
        
        notifiableId = try container.decode(Int.self, forKey: .notifiableId)
        notifiableType = try container.decode(ItemKind.self, forKey: .notifiableType)
        readed = try container.decode(Bool.self, forKey: .readed)
        
        let isoFormat = FormConfig.DateFormat.datetimeISO
        readedAt = try container.decodeIfPresent(String.self, forKey: .readedAt)?.tryToDate(dateFormat: isoFormat)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        subChannelId = try container.decodeIfPresent(Int.self, forKey: .subChannelId)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: isoFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: isoFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(notificationType.rawValue, forKey: .notificationType)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        try container.encodeIfPresent(checkInDate.toDateString(dateFormat), forKey: .checkInDate)
        try container.encodeIfPresent(checkOutDate.toDateString(dateFormat), forKey: .checkOutDate)
        
        try container.encode(notifiableId, forKey: .notifiableId)
        try container.encode(notifiableType.rawValue, forKey: .notifiableType)
        try container.encode(readed, forKey: .readed)
        
        let isoFormat = FormConfig.DateFormat.datetimeISO
        try container.encodeIfPresent(readedAt?.toDateString(isoFormat), forKey: .readedAt)
        try container.encodeIfPresent(channelId, forKey: .channelId)
        try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
        try container.encode(createdAt.toDateString(isoFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(isoFormat), forKey: .updatedAt)
    }
}

extension NotificationItem {
    
    public enum NotificationType: String, Decodable {
        case newCmBooking = "NEW_CM_BOOKING"
        case updatedCmBooking = "CM_BOOKING_WAS_UPDATED"
        case cancelledCmBooking = "CM_BOOKING_WAS_CANCELLED"
        
        case newHmsReservation = "NEW_HMS_RESERVATION"
        case updatedHmsReservation = "HMS_RESERVATION_WAS_UPDATED"
        case cancelledHmsReservation = "HMS_RESERVATION_WAS_CANCELLED"

        case adminBroadcastMessage = "ADMIN_BROADCAST_MESSAGE"
        case systemBroadcastMessage = "SYSTEM_BROADCAST_MESSAGE"
        case operatorBroadcastMessage = "OPERATOR_BROADCAST_MESSAGE"        
    }
    
    enum ItemKind: String, Decodable {
        case reservation = "RESERVATION"
        case cmBooking = "CM_BOOKING"        
        case broadcastMessage = "BROADCAST_MESSAGE"
    }
}


/*
 {
   "id": 3560,
   "notification_type": "NEW_CM_BOOKING",
   "check_in_date": "2024-05-31",
   "check_out_date": "2024-06-01",
   "notifiable_id": 83,
   "notifiable_type": "CM_BOOKING",
   "channel_id": null,
   "sub_channel_id": null,
   "readed": true,
   "readed_at": "2025-06-12T09:13:21.297Z",
   "created_at": "2024-05-23T08:32:02.592+07:00",
   "updated_at": "2024-06-03T15:43:19.014+07:00"
 }

 */
