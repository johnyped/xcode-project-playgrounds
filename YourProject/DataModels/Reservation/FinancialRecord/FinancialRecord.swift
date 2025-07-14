//
//  FinancialRecord.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import Foundation

struct FinancialRecord: Codable {
    static let defaultPaymentMethod = PaymentMethods.shared.first
    
    internal let dateFormat = "dd MMM yyyy HH:mm"
    
    let id: Int
    let name: String
    let paymentMethod: String
    let note: String?
    let timestamp: Date
    let amount: Double
    let recordableId: Int
    let recordableType: RecordType
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    let bankAccountId: Int?
    
    var cashFlowType: CashFlowType {
        if amount >= 0 {
            return .income
        }
        return .expense
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case paymentMethod = "payment_method"
        case note
        case timestamp
        case amount
        case recordableId = "recordable_id"
        case recordableType = "recordable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
        case bankAccount = "bank_account"
    }
    
    init(id: Int,
         name: String,
         paymentMethod: String,
         note: String?,
         timestamp: Date,
         amount: Double,
         recordableId: Int,
         recordableType: RecordType,
         createdAt: Date,
         updatedAt: Date,
         hotelId: Int,
         bankAccountId: Int?) {
        self.id = id
        self.name = name
        self.paymentMethod = paymentMethod
        self.note = note
        self.timestamp = timestamp
        self.amount = amount
        self.recordableId = recordableId
        self.recordableType = recordableType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelId = hotelId
        self.bankAccountId = bankAccountId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateTimeISO = FormConfig.DateFormat.datetimeISO
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        paymentMethod = try container.decode(String.self, forKey: .paymentMethod)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        amount = try container.decode(String.self, forKey: .amount).tryToDouble()
        recordableId = try container.decode(Int.self, forKey: .recordableId)
        recordableType = try container.decode(RecordType.self, forKey: .recordableType)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        bankAccountId = try container.decodeIfPresent(Int.self, forKey: .bankAccount)
        timestamp = try container.decode(String.self, forKey: .timestamp).tryToDate(dateFormat: dateTimeISO)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateTimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateTimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(paymentMethod, forKey: .paymentMethod)
        try container.encode(note, forKey: .note)
        try container.encode(amount.toString(), forKey: .amount)
        try container.encode(recordableId, forKey: .recordableId)
        try container.encode(recordableType.rawValue, forKey: .recordableType)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(bankAccountId, forKey: .bankAccount)
        try container.encode(timestamp.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .timestamp)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

extension FinancialRecord {
    
    enum CashFlowType {
        case income
        case expense
    }

    
    enum RecordType: String, Codable {
        case reservation = "RESERVATION"
        case accountItem = "ACCOUNT_ITEM"
        case additional = "ADDITIONAL" 
    }
    
}

/*
 new response
 {
             "id": 440,
             "name": "PAYMENT",
             "payment_method": "Bank Transfer",
             "note": null,
             "timestamp": "2024-04-21T13:33:54.748+07:00",
             "amount": "2111.0",
             "recordable_id": 1067,
             "recordable_type": "RESERVATION",
             "created_at": "2024-04-21T13:33:54.756+07:00",
             "updated_at": "2024-04-21T13:33:54.756+07:00",
             "hotel_id": 105,
             "bank_account_id": null
         }
 */
