//
//  Category.swift
//  YourProject
//
//  Created by IntrodexMini on 17/6/2568 BE.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let kind: Kind
    let hotelId: Int
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case kind
        case hotelId = "hotel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int,
         name: String,
         kind: Kind,
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.kind = kind
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        kind = try container.decode(Kind.self, forKey: .kind)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(kind.rawValue, forKey: .kind)
        try container.encode(hotelId, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension Category {
    enum Kind: String, Codable, CaseIterable {
        case product = "PRODUCT"
        case service = "FOLIOS"
        
        var description: String {
            switch self {
            case .product:
                return "Product"
            case .service:
                return "Service"
            }
        }
    }
}

/*
 {
             "id": 1,
             "name": "cate a ",
             "kind": "product",
             "created_at": "2020-07-03T08:15:57.891+07:00",
             "updated_at": "2020-07-03T08:15:57.891+07:00",
             "hotel_id": 105
         }
 */
