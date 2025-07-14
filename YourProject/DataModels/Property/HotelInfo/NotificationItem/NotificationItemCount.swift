//
//  NotificationItemCount.swift
//  YourProject
//
//  Created by IntrodexMac on 11/6/2568 BE.
//
import Foundation

struct NotificationItemCount: Codable {
    let reservations: ItemCount
    let cmBookings: ItemCount
    
    enum CodingKeys: String, CodingKey {
        case reservations
        case cmBookings = "cm_bookings"
    }
    
    struct ItemCount: Codable {
        let unread: Int
        let readed: Int
        let total: Int
    }
}

/*
 {
     "reservations": {
         "unread": 0,
         "readed": 2,
         "total": 2
     },
     "cm_bookings": {
         "unread": 1,
         "readed": 2,
         "total": 3
     }
 }
 */
