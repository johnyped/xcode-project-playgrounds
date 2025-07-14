//
//  Payee.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct Payee: Codable {
    let id: Int
    let name: String
    let memo: String
    let buyVatType: VatType
    let sellVatType: VatType
    let hotelId: Int
    let accountItemCategoryId: Int
    let accountSubItemCategoryId: Int?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case memo
        case buyVatType = "buy_vat_type"
        case sellVatType = "sell_vat_type"
        case hotelId = "hotel_id"
        case accountItemCategoryId = "account_item_category_id"
        case accountSubItemCategoryId = "account_sub_item_category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
    init(id: Int,
         name: String,
         memo: String,
         buyVatType: VatType,
         sellVatType: VatType,
         hotelId: Int,
         accountItemCategoryId: Int,
         accountSubItemCategoryId: Int? = nil,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.memo = memo
        self.buyVatType = buyVatType
        self.sellVatType = sellVatType
        self.hotelId = hotelId
        self.accountItemCategoryId = accountItemCategoryId
        self.accountSubItemCategoryId = accountSubItemCategoryId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        memo = (try? container.decode(String.self, forKey: .memo)) ?? ""
        buyVatType = try container.decode(VatType.self, forKey: .buyVatType)
        sellVatType = try container.decode(VatType.self, forKey: .sellVatType)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        accountItemCategoryId = try container.decode(Int.self, forKey: .accountItemCategoryId)
        accountSubItemCategoryId = try container.decodeIfPresent(Int.self, forKey: .accountSubItemCategoryId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(memo, forKey: .memo)
        try container.encode(buyVatType, forKey: .buyVatType)
        try container.encode(sellVatType, forKey: .sellVatType)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
        try container.encodeIfPresent(accountSubItemCategoryId, forKey: .accountSubItemCategoryId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension Payee {
    //no_vat 7_percent 10_percent
    enum VatType: String, Codable {
        case sevenPercent = "7_PERCENT"
        case noVat = "NO_VAT"
        case tenPercent = "10_PERCENT"
    }
}

/*
 {
 "id": 1,
 "name": "ค่าไฟ้า",
 "memo": "memo",
 "buy_vat_type": "7_PERCENT",
 "sell_vat_type": "7_PERCENT",
 "created_at": "2020-05-10T06:28:39.742+07:00",
 "updated_at": "2020-06-04T10:56:19.759+07:00",
 "hotel_id": 105,
 "account_item_category_id": 5,
 "account_sub_item_category_id": null
 }
 
 */
