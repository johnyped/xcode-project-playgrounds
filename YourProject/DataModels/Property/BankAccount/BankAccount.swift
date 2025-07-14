//
//  BankAccount.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import Foundation

struct BankAccount: Codable {
    let id: Int
    let bankNumber: String
    let bankName: String
    let bankBranch: String
    let accountName: String
    let isDefault: Bool
    let hotelId: Int
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case bankNumber = "bank_number"
        case bankName = "bank_name"
        case bankBranch = "bank_branch"
        case accountName = "account_name"
        case isDefault = "is_default"
        case hotelId = "hotel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        bankNumber = try container.decode(String.self, forKey: .bankNumber)
        bankName = try container.decode(String.self, forKey: .bankName)
        bankBranch = try container.decode(String.self, forKey: .bankBranch)
        accountName = try container.decode(String.self, forKey: .accountName)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         bankNumber: String,
         bankName: String,
         bankBranch: String,
         accountName: String,
         isDefault: Bool,
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.bankNumber = bankNumber
        self.bankName = bankName
        self.bankBranch = bankBranch
        self.accountName = accountName
        self.isDefault = isDefault
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(bankNumber, forKey: .bankNumber)
        try container.encode(bankName, forKey: .bankName)
        try container.encode(bankBranch, forKey: .bankBranch)
        try container.encode(accountName, forKey: .accountName)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(hotelId, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

/*
 json response
 {
            "id": 2,
            "bank_number": "3202999102",
            "bank_name": "กสิกรไทย",
            "bank_branch": "สยามพารากอน",
            "account_name": "นายสมชาย ชาติทหาร",
            "is_default": false,
            "created_at": "2023-03-02T22:50:34.406+07:00",
            "updated_at": "2023-06-17T21:10:08.255+07:00",
            "hotel_id": 105
        }
 */

