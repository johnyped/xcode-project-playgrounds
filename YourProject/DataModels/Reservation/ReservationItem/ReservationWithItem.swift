//
//  ReservationWithItem.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//
import Foundation

struct ReservationWithItem: Codable {
    let reservation: Reservation
    let items: ReservationItems
    
    // roomIDs
    var uniqueUnitIDs: Set<Int> {
        items.roomIDs        
    }
    
}

extension ReservationWithItem {
    enum FilterBy {
        case id(id: Int)
        case ids(ids: [Int])
        case keyword(q: String)
        case guestId(id: Int)
        case roomId(id: Int)
        case status(status: Reservation.Status)
        case statuses(statuses: [Reservation.Status])
        
        case date(date: Date)
        case checkInDate(date: Date)
        case staythroughDate(date: Date)
        case checkOutDate(date: Date)
        
        case arrivalToday(date: Date)
        case departureToday(date: Date)
        case overCheckIn(date: Date)
        case beforeCheckIn(date: Date)
        case channel(id: Int, subChannelId: Int?)
        case channels(channels: (id: Int, subChannelId: Int?))
        
    }
    
    enum SortBy {
        case id
        case contactNameAlphabet
        case status
        case totalCost
        case totalPaid
        case remainCost
        case nightCount
        case checkInDate
        case checkOutDate
        case createdAt
        case updatedAt
    }
}
