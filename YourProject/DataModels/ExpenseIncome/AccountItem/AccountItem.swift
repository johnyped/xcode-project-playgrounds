//
//  AccountItem.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import Foundation

struct AccountItem: Codable {
    let id: Int
    let currency: String
    let memo: String?
    let date: Date
    let amount: Double
    let buyAmountBeforeVat: Double
    let buyAmountVat: Double
    let sellAmountBeforeVat: Double
    let sellAmountVat: Double    
    
    let documentIds: [Int]
    let financialRecordIds: [Int]
    let accountId: Int
    let payeeId: Int
    let accountItemCategoryId: Int
    let accountSubItemCategoryId: Int?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case currency
        case memo
        case amount
        case buyAmountBeforeVat = "buy_amount_before_vat"
        case buyAmountVat = "buy_amount_vat"
        case sellAmountBeforeVat = "sell_amount_before_vat"
        case sellAmountVat = "sell_amount_vat"
        case date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case documentIds = "document_ids"
        case financialRecordIds = "financial_record_ids"
        case accountId = "account_id"
        case payeeId = "payee_id"
        case accountItemCategoryId = "account_item_category_id"
        case accountSubItemCategoryId = "account_sub_item_category_id"
    }

    init(id: Int,
         currency: String,
         memo: String? = nil,
         date: Date,
         amount: Double,
         buyAmountBeforeVat: Double,
         buyAmountVat: Double,
         sellAmountBeforeVat: Double,
         sellAmountVat: Double,
         documentIds: [Int] = [],
         financialRecordIds: [Int] = [],
         accountId: Int,
         payeeId: Int,
         accountItemCategoryId: Int,
         accountSubItemCategoryId: Int? = nil,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.currency = currency
        self.memo = memo
        self.date = date
        self.amount = amount
        self.buyAmountBeforeVat = buyAmountBeforeVat
        self.buyAmountVat = buyAmountVat
        self.sellAmountBeforeVat = sellAmountBeforeVat
        self.sellAmountVat = sellAmountVat
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.documentIds = documentIds
        self.financialRecordIds = financialRecordIds
        self.accountId = accountId
        self.payeeId = payeeId
        self.accountItemCategoryId = accountItemCategoryId
        self.accountSubItemCategoryId = accountSubItemCategoryId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        currency = try container.decode(String.self, forKey: .currency)
        memo = try container.decodeIfPresent(String.self, forKey: .memo)
        amount = (try? container.decode(String.self, forKey: .amount).tryToDouble()) ?? 0
        buyAmountBeforeVat = (try? container.decode(String.self, forKey: .buyAmountBeforeVat).tryToDouble()) ?? 0
        buyAmountVat = (try? container.decode(String.self, forKey: .buyAmountVat).tryToDouble()) ?? 0
        sellAmountBeforeVat = (try? container.decode(String.self, forKey: .sellAmountBeforeVat).tryToDouble()) ?? 0
        sellAmountVat = (try? container.decode(String.self, forKey: .sellAmountVat).tryToDouble()) ?? 0
        
        documentIds = (try? container.decode([Int].self, forKey: .documentIds)) ?? []
        financialRecordIds = (try? container.decode([Int].self, forKey: .financialRecordIds)) ?? []
        
        accountId = try container.decode(Int.self, forKey: .accountId)
        payeeId = try container.decode(Int.self, forKey: .payeeId)
        accountItemCategoryId = try container.decode(Int.self, forKey: .accountItemCategoryId)
        accountSubItemCategoryId = try container.decode(Int.self, forKey: .accountSubItemCategoryId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        date = try container.decode(String.self, forKey: .date).tryToDate(dateFormat: dateFormat)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(currency, forKey: .currency)
        try container.encodeIfPresent(memo, forKey: .memo)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO        
        try container.encode(date.toDateString(dateFormat), forKey: .date)
        try container.encode(amount.toString(), forKey: .amount)
        try container.encode(buyAmountBeforeVat.toString(), forKey: .buyAmountBeforeVat)
        try container.encode(buyAmountVat.toString(), forKey: .buyAmountVat)
        try container.encode(sellAmountBeforeVat.toString(), forKey: .sellAmountBeforeVat)
        try container.encode(sellAmountVat.toString(), forKey: .sellAmountVat)
        
        try container.encode(documentIds, forKey: .documentIds)
        try container.encode(financialRecordIds, forKey: .financialRecordIds)
        try container.encode(accountId, forKey: .accountId)
        try container.encode(payeeId, forKey: .payeeId)
        try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
        try container.encode(accountSubItemCategoryId, forKey: .accountSubItemCategoryId)
        
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}


/*
 {
             "id": 12,
             "currency": "THB",
             "memo": null,
             "amount": "222.0",
             "buy_amount_before_vat": "222.0",
             "buy_amount_vat": "0.0",
             "sell_amount_before_vat": "222.0",
             "sell_amount_vat": "0.0",
             "date": "2020-06-05T08:41:43.056+07:00",
             "created_at": "2020-06-05T08:41:56.562+07:00",
             "updated_at": "2020-06-05T08:41:56.571+07:00",
             "document_ids": [],
             "financial_record_ids": [],
             "account_id": 1,
             "payee_id": 8,
             "account_item_category_id": 1,
             "account_sub_item_category_id": 1
         }
 */
