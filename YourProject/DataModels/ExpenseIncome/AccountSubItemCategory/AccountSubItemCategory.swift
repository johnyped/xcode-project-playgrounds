//
//  AccountSubItemCategory.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import Foundation

struct AccountSubItemCategory: Codable {
    let id: Int
    let name: String
    let hotelId: Int
    let accountItemCategoryId: Int
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
        case accountItemCategoryId = "account_item_category_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        accountItemCategoryId = try container.decode(Int.self, forKey: .accountItemCategoryId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         name: String,
         hotelId: Int,
         accountItemCategoryId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.hotelId = hotelId
        self.accountItemCategoryId = accountItemCategoryId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

/*
 json response
 {
             "id": 1,
             "name": "ซ่อม",
             "created_at": "2020-05-13T08:48:29.084+07:00",
             "updated_at": "2020-06-02T07:11:41.983+07:00",
             "hotel_id": 105,
             "account_item_category_id": 1
         }
 */
