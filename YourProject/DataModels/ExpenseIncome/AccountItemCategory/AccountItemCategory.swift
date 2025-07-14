//
//  AccountItemCategory.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import Foundation

struct AccountItemCategory: Codable {
    let id: Int
    let name: String
    let kind: Kind
    let iconRef: Int
    let hotelId: Int
    let accountSubItemCategoryIds: [Int]
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case kind
        case iconRef = "icon_ref"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case accountSubItemCategoryIds = "account_sub_item_category_ids"
        case hotelId = "hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        kind = try container.decode(Kind.self, forKey: .kind)
        iconRef = try container.decode(Int.self, forKey: .iconRef)
        accountSubItemCategoryIds = (try? container.decode([Int].self, forKey: .accountSubItemCategoryIds)) ?? []
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         name: String,
         kind: Kind,
         iconRef: Int,
         accountSubItemCategoryIds: [Int] = [],
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.kind = kind
        self.iconRef = iconRef
        self.accountSubItemCategoryIds = accountSubItemCategoryIds
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(kind, forKey: .kind)
        try container.encode(iconRef, forKey: .iconRef)
        try container.encode(accountSubItemCategoryIds, forKey: .accountSubItemCategoryIds)
        try container.encode(hotelId, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension AccountItemCategory {
    
    enum Kind: String, Codable, CaseIterable {
        case expense = "EXPENSE"
        case income = "INCOME"
        
        var description: String {
            switch self {
            case .expense:
                return "Expense"
            case .income:
                return "Income"
            }
        }
    }
}

/*
 {
     "id": 1,
     "name": "ปะปา",
     "kind": "EXPENSE",
     "icon_ref": 5,
     "created_at": "2020-05-10T05:39:56.850+07:00",
     "updated_at": "2020-06-14T18:10:55.081+07:00",
     "account_sub_item_category_ids": [
         1
     ],
     "hotel_id": 105
 }
 */
