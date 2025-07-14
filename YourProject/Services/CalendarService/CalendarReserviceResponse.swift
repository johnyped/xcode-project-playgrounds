//
//  CalendarReserviceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//
import Foundation

struct CalendarReserviceResponse {
    
    struct CalendarMonth: Codable {
        let month: String
        let reservedItems: [ReservedItem]
        
        init(month: String, reservedItems: [ReservedItem]) {
            self.month = month
            self.reservedItems = reservedItems
        }

        enum CodingKeys: String, CodingKey {
            case month
            case reservedItems = "reserved_items"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            month = try container.decode(String.self, forKey: .month)
            reservedItems = try container.decode([ReservedItem].self, forKey: .reservedItems)
        }
    }

}

extension CalendarReserviceResponse {
    
    struct ReservedItem: Codable {
        let reservationId: Int
        let status: ReservationStatus
        let checkInDate: Date
        let checkOutDate: Date
        let reservedType: ReservedType
        let reservedTypeId: Int
        let reservedUnitId: Int?
        let emoji: String?
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
            case status
            case checkInDate = "check_in_date"
            case checkOutDate = "check_out_date"
            case reservedType = "reserved_type"
            case reservedTypeId = "reserved_type_id"
            case reservedUnitId = "reserved_unit_id"
            case emoji
        }

        init(reservationId: Int,
             status: ReservationStatus,
             checkInDate: Date,
             checkOutDate: Date,
             reservedType: ReservedType,
             reservedTypeId: Int,
             reservedUnitId: Int?,
             emoji: String?) {
            self.reservationId = reservationId
            self.status = status
            self.checkInDate = checkInDate
            self.checkOutDate = checkOutDate
            self.reservedType = reservedType
            self.reservedTypeId = reservedTypeId
            self.reservedUnitId = reservedUnitId
            self.emoji = emoji
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            reservationId = try container.decode(Int.self, forKey: .reservationId)
            status = try container.decode(ReservationStatus.self, forKey: .status)
            checkInDate = try container.decode(String.self, forKey: .checkInDate).tryToDate(dateFormat: "yyyy-MM-dd")
            checkOutDate = try container.decode(String.self, forKey: .checkOutDate).tryToDate(dateFormat: "yyyy-MM-dd")
            reservedType = try container.decode(ReservedType.self, forKey: .reservedType)
            reservedTypeId = try container.decode(Int.self, forKey: .reservedTypeId)
            reservedUnitId = try? container.decodeIfPresent(Int.self, forKey: .reservedUnitId)
            emoji = try container.decodeIfPresent(String.self, forKey: .emoji)
        }
    }

    enum ReservedType: String, Codable {
        case roomType = "ROOM_TYPE"
        case room = "ROOM"
        case linkUnitType = "LINK_UNIT_TYPE"
    }

    enum ReservationStatus: String, Codable {
        case created = "CREATED"
        case confirmed = "CONFIRMED"
        case checkedIn = "CHECKED_IN"
        case checkedOut = "CHECKED_OUT"
        case canceled = "CANCELED"
        case noShow = "NO_SHOW"
    }
}
