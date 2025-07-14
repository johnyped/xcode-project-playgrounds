//
//  AdditionalItem.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import Foundation

struct AdditionalItem: Codable {
    let id: Int
    let price: Double
    let quantity: Int
    let totalAmount: Double
    let itemableId: Int
    let itemableType: ItemType
    let additionalId: Int
    let createdAt: Date
    let updatedAt: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(String.self, forKey: .price).tryToDouble()
        quantity = try container.decode(Int.self, forKey: .quantity)
        totalAmount = try container.decode(String.self, forKey: .totalAmount).tryToDouble()
        itemableId = try container.decode(Int.self, forKey: .itemableId)
        itemableType = try container.decode(ItemType.self, forKey: .itemableType)
        additionalId = try container.decode(Int.self, forKey: .additionalId)
        
        let isoDate = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: isoDate)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: isoDate)        
    }
    
    init(id: Int,
         price: Double,
         quantity: Int,
         totalAmount: Double,
         itemableId: Int,
         itemableType: ItemType,
         additionalId: Int,
         createdAt: Date,
         updatedAt: Date
         ) {
        self.id = id
        self.price = price
        self.quantity = quantity
        self.totalAmount = totalAmount
        self.itemableId = itemableId
        self.itemableType = itemableType
        self.additionalId = additionalId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(price.toString(), forKey: .price)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(totalAmount.toString(), forKey: .totalAmount)
        try container.encode(itemableId, forKey: .itemableId)
        try container.encode(itemableType.rawValue, forKey: .itemableType)
        try container.encode(additionalId, forKey: .additionalId)
        let isoDate = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(isoDate), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(isoDate), forKey: .updatedAt)        
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, price, quantity
        case totalAmount = "total_amount"
        case itemableId = "itemable_id"
        case itemableType = "itemable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case additionalId = "additional_id"
    }
    
}

extension AdditionalItem {
    enum ItemType: String, Codable {
        case foilo = "FOLIO"
    }
}

/*
 {
   "id": 431,
   "price": "15.0",
   "quantity": 2,
   "total_amount": "30.0",
   "itemable_id": 134,
   "itemable_type": "FOLIO",
   "created_at": "2024-03-19T05:54:36.214+07:00",
   "updated_at": "2024-03-19T05:54:36.214+07:00",
   "additional_id": 261
 }
 */
