//
//  ProductUnit.swift
//  YourProject
//
//  Created by IntrodexMini on 18/6/2568 BE.
//

import Foundation

struct ProductUnit: Codable {
    let id: Int
    let hotelId: Int
    let unit: String
    let kind: Kind
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case unit
        case kind        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        unit = try container.decode(String.self, forKey: .unit)
        kind = try container.decode(Kind.self, forKey: .kind)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         unit: String,
         kind: Kind,
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.unit = unit
        self.kind = kind
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(unit, forKey: .unit)
        try container.encode(kind.rawValue, forKey: .kind)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension ProductUnit {
    enum Kind: String, Codable {
        case product = "PRODUCT"
        case service = "SERVICE"
    }
}

/*
 {
     "id": 1,
     "unit": "pc",
     "kind": "PRODUCT",
     "created_at": "2025-06-18T13:36:40.901+07:00",
     "updated_at": "2025-06-18T13:36:40.901+07:00",
     "hotel_id": 105
 }
 */
