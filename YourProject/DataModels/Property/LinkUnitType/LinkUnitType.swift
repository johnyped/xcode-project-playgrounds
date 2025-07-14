//
//  LinkUnitType.swift
//  YourProject
//
//  Created by IntrodexMini on 3/7/2568 BE.
//

import Foundation

struct LinkUnitType: Codable {
    let id: Int
    let name: String
    let baseRate: Double
    let description: String?    
    let roomTypeIds: [Int]
    let hotelId: Int
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseRate = "base_rate"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case roomTypeIds = "room_type_ids"
        case hotelId = "hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        baseRate = try container.decode(String.self, forKey: .baseRate).tryToDouble()
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
        
        roomTypeIds = (try? container.decode([Int].self, forKey: .roomTypeIds)) ?? []
        hotelId = try container.decode(Int.self, forKey: .hotelId)
    }
    
    init(id: Int,
         name: String,
         baseRate: Double,
         description: String? = nil,         
         roomTypeIds: [Int] = [],
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.baseRate = baseRate
        self.description = description
        self.roomTypeIds = roomTypeIds
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(baseRate.description, forKey: .baseRate)
        try container.encodeIfPresent(description, forKey: .description)
                
        try container.encode(roomTypeIds, forKey: .roomTypeIds)
        try container.encode(hotelId, forKey: .hotelId)

        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

/*
 json response
 {
   "id": 1,
   "name": "link 1",
   "base_rate": "500.0",
   "description": null,
   "created_at": "2020-04-26T17:34:40.863+07:00",
   "updated_at": "2020-04-26T17:34:40.863+07:00",
   "room_type_ids": [],
   "hotel_id": 105
 }

 */
