//
//  BlackoutUnit.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//
import Foundation

struct BlackoutUnit: Codable {
    let id: Int
    let hotelId: Int
    let unitableId: Int
    let unitableType: UnitableType
    let startDate: Date
    let endDate: Date
    let removesDate: Date?
    let note: String?
    let emoji: String?
    let quantity: Int    
    
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case unitableId = "unitable_id"
        case unitableType = "unitable_type"
        case startDate = "start_date"
        case endDate = "end_date"
        case removesDate = "removes_date"
        case note
        case emoji
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int,
         hotelId: Int,
         unitableId: Int,
         unitableType: UnitableType,
         startDate: Date,
         endDate: Date,
         removesDate: Date?,
         note: String?,
         emoji: String?,
         quantity: Int,
         createdAt: Date,
         updatedAt: Date,
         ) {
        self.id = id
        self.hotelId = hotelId
        self.unitableId = unitableId
        self.unitableType = unitableType
        self.startDate = startDate
        self.endDate = endDate
        self.removesDate = removesDate
        self.note = note
        self.emoji = emoji
        self.quantity = quantity
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        unitableId = try container.decode(Int.self, forKey: .unitableId)
        unitableType = try container.decode(UnitableType.self, forKey: .unitableType)
        
        let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
        startDate = try container.decode(String.self, forKey: .startDate).tryToDate(dateFormat: yyyyMMdd)
        endDate = try container.decode(String.self, forKey: .endDate).tryToDate(dateFormat: yyyyMMdd)
        if let removesDateString = try container.decodeIfPresent(String.self, forKey: .removesDate) {
            removesDate = try? removesDateString.tryToDate(dateFormat: yyyyMMdd)
        } else {
            removesDate = nil
        }   
        note = try container.decodeIfPresent(String.self, forKey: .note)
        emoji = try container.decodeIfPresent(String.self, forKey: .emoji)
        quantity = try container.decode(Int.self, forKey: .quantity)

        let datetimeISO = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: datetimeISO)
        
    }
}

extension BlackoutUnit {
    enum UnitableType: String, Codable {
        case room = "ROOM"
        case roomType = "ROOM_TYPE"
    }
}
/*
 {
     "id": 172,
     "unitable_id": 620,
     "unitable_type": "ROOM",
     "start_date": "2024-05-29",
     "end_date": "2024-05-30",
     "removes_date": null,
     "note": "",
     "emoji": null,
     "quantity": 1,
     "created_at": "2024-05-29T06:49:07.734+07:00",
     "updated_at": "2024-05-29T06:49:07.734+07:00",
     "hotel_id": 105
 }
 */

