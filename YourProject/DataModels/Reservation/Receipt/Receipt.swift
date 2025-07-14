//
//  Receipt.swift
//  YourProject
//
//  Created by IntrodexMini on 16/6/2568 BE.
//

import Foundation

struct Receipt: Codable {
    let id: Int
    let status: Status    
    let number: String

    let vatIncluded: Bool
    let vatPercentage: Double
    let withholdingTaxIncluded: Bool
    let withholdingTaxPercentage: Double
    let occupiedTotalAmount: Double
    let additionalTotalAmount: Double
    let totalAmount: Double
    let amountBeforeVat: Double
    let vatAmount: Double
    let holdingTaxAmount: Double
    let totalReceiveAmount: Double
    let paidBeforeAmount: Double

    let paidDate: Date
    let currency: String
    let remark: String?
    let internalNote: String?    

    let voidReason: String?
    let voidedAt: Date?
    let cancelledAt: Date?
    let cancelReason: String?
    let paidAt: Date?
    
    let hotelId: Int
    let userId: Int
    let folioFormId: Int?
    let payerContactId: Int
    let receiverContactId: Int
    let financialRecordIds: [Int]
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case number

        case vatIncluded = "vat_included"
        case vatPercentage = "vat_percentage"
        case withholdingTaxIncluded = "withholding_tax_included"
        case withholdingTaxPercentage = "withholding_tax_percentage"
        case occupiedTotalAmount = "occupied_total_amount"
        case additionalTotalAmount = "additional_total_amount"
        case totalAmount = "total_amount"
        case amountBeforeVat = "amount_before_vat"
        case vatAmount = "vat_amount"
        case holdingTaxAmount = "holding_tax_amount"
        case totalReceiveAmount = "total_receive_amount"
        case paidBeforeAmount = "paid_before_amount"

        case paidDate = "paid_date"
        case currency
        case remark
        case internalNote = "internal_note"

        case voidReason = "void_reason"
        case voidedAt = "voided_at"
        case cancelledAt = "cancelled_at"
        case cancelReason = "cancel_reason"
        case paidAt = "paid_at"

        case hotelId = "hotel_id"
        case userId = "user_id"
        case folioFormId = "folio_form_id"
        case payerContactId = "payer_contact_id"
        case receiverContactId = "receiver_contact_id"
        case financialRecordIds = "financial_record_ids"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int,
         status: Status,
         number: String,
         vatIncluded: Bool,
         vatPercentage: Double,
         withholdingTaxIncluded: Bool,
         withholdingTaxPercentage: Double,
         occupiedTotalAmount: Double,
         additionalTotalAmount: Double,
         totalAmount: Double,
         amountBeforeVat: Double,
         vatAmount: Double,
         holdingTaxAmount: Double,
         totalReceiveAmount: Double,
         paidBeforeAmount: Double,
         paidDate: Date,
         currency: String,
         remark: String?,
         internalNote: String?,
         voidReason: String?,
         voidedAt: Date?,
         cancelledAt: Date?,
         cancelReason: String?,
         paidAt: Date?,
         hotelId: Int,
         userId: Int,
         folioFormId: Int?,
         payerContactId: Int,
         receiverContactId: Int,
         financialRecordIds: [Int],
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.status = status
        self.number = number
        self.vatIncluded = vatIncluded
        self.vatPercentage = vatPercentage
        self.withholdingTaxIncluded = withholdingTaxIncluded
        self.withholdingTaxPercentage = withholdingTaxPercentage
        self.occupiedTotalAmount = occupiedTotalAmount
        self.additionalTotalAmount = additionalTotalAmount
        self.totalAmount = totalAmount
        self.amountBeforeVat = amountBeforeVat
        self.vatAmount = vatAmount
        self.holdingTaxAmount = holdingTaxAmount
        self.totalReceiveAmount = totalReceiveAmount
        self.paidBeforeAmount = paidBeforeAmount
        self.paidDate = paidDate
        self.currency = currency
        self.remark = remark
        self.internalNote = internalNote
        self.voidReason = voidReason
        self.voidedAt = voidedAt
        self.cancelledAt = cancelledAt
        self.cancelReason = cancelReason
        self.paidAt = paidAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelId = hotelId
        self.userId = userId
        self.folioFormId = folioFormId
        self.payerContactId = payerContactId
        self.receiverContactId = receiverContactId
        self.financialRecordIds = financialRecordIds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(Status.self, forKey: .status)                
        let dateFormat = FormConfig.DateFormat.datetimeISO
        
        number = try container.decode(String.self, forKey: .number)
        vatIncluded = try container.decode(Bool.self, forKey: .vatIncluded)
        vatPercentage = try container.decode(String.self, forKey: .vatPercentage).tryToDouble()
        withholdingTaxIncluded = try container.decode(Bool.self, forKey: .withholdingTaxIncluded)
        withholdingTaxPercentage = try container.decode(String.self, forKey: .withholdingTaxPercentage).tryToDouble()
        occupiedTotalAmount = try container.decode(String.self, forKey: .occupiedTotalAmount).tryToDouble()
        additionalTotalAmount = try container.decode(String.self, forKey: .additionalTotalAmount).tryToDouble()
        totalAmount = try container.decode(String.self, forKey: .totalAmount).tryToDouble()
        amountBeforeVat = try container.decode(String.self, forKey: .amountBeforeVat).tryToDouble()
        vatAmount = try container.decode(String.self, forKey: .vatAmount).tryToDouble()
        holdingTaxAmount = try container.decode(String.self, forKey: .holdingTaxAmount).tryToDouble()
        totalReceiveAmount = try container.decode(String.self, forKey: .totalReceiveAmount).tryToDouble()
        paidBeforeAmount = try container.decode(String.self, forKey: .paidBeforeAmount).tryToDouble()
        
        paidDate = try container.decode(String.self, forKey: .paidDate).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        currency = try container.decode(String.self, forKey: .currency)
        remark = try container.decodeIfPresent(String.self, forKey: .remark)
        internalNote = try container.decodeIfPresent(String.self, forKey: .internalNote)
                        
        voidReason = try container.decodeIfPresent(String.self, forKey: .voidReason)
        voidedAt = try container.decodeIfPresent(String.self, forKey: .voidedAt)?.tryToDate(dateFormat: dateFormat)
        cancelledAt = try container.decodeIfPresent(String.self, forKey: .cancelledAt)?.tryToDate(dateFormat: dateFormat)
        cancelReason = try container.decodeIfPresent(String.self, forKey: .cancelReason)
        paidAt = try container.decodeIfPresent(String.self, forKey: .paidAt)?.tryToDate(dateFormat: dateFormat)        

        hotelId = try container.decode(Int.self, forKey: .hotelId)
        userId = try container.decode(Int.self, forKey: .userId)
        folioFormId = try container.decodeIfPresent(Int.self, forKey: .folioFormId)
        payerContactId = try container.decode(Int.self, forKey: .payerContactId)
        receiverContactId = try container.decode(Int.self, forKey: .receiverContactId)
        financialRecordIds = try container.decode([Int].self, forKey: .financialRecordIds)

        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)        
        
        let dateFormat = FormConfig.DateFormat.datetimeISO        
        
        try container.encode(number, forKey: .number)
        try container.encode(vatIncluded, forKey: .vatIncluded)
        try container.encode(vatPercentage.toString(), forKey: .vatPercentage)
        try container.encode(withholdingTaxIncluded, forKey: .withholdingTaxIncluded)
        try container.encode(withholdingTaxPercentage.toString(), forKey: .withholdingTaxPercentage)
        try container.encode(occupiedTotalAmount.toString(), forKey: .occupiedTotalAmount)
        try container.encode(additionalTotalAmount.toString(), forKey: .additionalTotalAmount)
        try container.encode(totalAmount.toString(), forKey: .totalAmount)
        try container.encode(amountBeforeVat.toString(), forKey: .amountBeforeVat)
        try container.encode(vatAmount.toString(), forKey: .vatAmount)
        try container.encode(holdingTaxAmount.toString(), forKey: .holdingTaxAmount)
        try container.encode(totalReceiveAmount.toString(), forKey: .totalReceiveAmount)
        try container.encode(paidBeforeAmount.toString(), forKey: .paidBeforeAmount)
        
        try container.encode(paidDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .paidDate)
        try container.encode(currency, forKey: .currency)
        try container.encodeIfPresent(remark, forKey: .remark)
        try container.encodeIfPresent(internalNote, forKey: .internalNote)
        
        try container.encodeIfPresent(voidReason, forKey: .voidReason)
        try container.encodeIfPresent(voidedAt?.toDateString(dateFormat), forKey: .voidedAt)
        try container.encodeIfPresent(cancelledAt?.toDateString(dateFormat), forKey: .cancelledAt)
        try container.encodeIfPresent(cancelReason, forKey: .cancelReason)
        try container.encodeIfPresent(paidAt?.toDateString(dateFormat), forKey: .paidAt)

        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(userId, forKey: .userId)
        try container.encodeIfPresent(folioFormId, forKey: .folioFormId)
        try container.encode(payerContactId, forKey: .payerContactId)
        try container.encode(receiverContactId, forKey: .receiverContactId)
        try container.encode(financialRecordIds, forKey: .financialRecordIds)

        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
    
}

extension Receipt {
    enum Status: String, Codable {
        case paid = "PAID"
        case void = "VOID"
        case cancelled = "CANCELLED"
        
        var description: String {
            switch self {
            case .paid:
                return "Paid"
            case .void:
                return "Voided"
            case .cancelled:
                return "Cancelled"
            }
        }
        
    }
}

/*
 {
     "id": 3,
     "status": "PAID",
     "void_reason": null,
     "voided_at": null,
     "cancelled_at": null,
     "cancel_reason": null,
     "paid_at": null,
     "number": "RI20221100001",
     "vat_included": true,
     "vat_percentage": "7.0",
     "withholding_tax_included": true,
     "withholding_tax_percentage": "3.0",
     "occupied_total_amount": "500.0",
     "additional_total_amount": "0.0",
     "total_amount": "500.0",
     "amount_before_vat": "467.29",
     "vat_amount": "32.71",
     "holding_tax_amount": "14.02",
     "total_receive_amount": "500.0",
     "paid_before_amount": "0.0",
     "paid_date": "2022-11-22",
     "currency": "THB",
     "remark": null,
     "internal_note": null,
     "created_at": "2022-11-23T00:32:36.664+07:00",
     "updated_at": "2023-07-31T12:29:27.040+07:00",
     "hotel_id": 105,
     "user_id": 38,
     "folio_form_id": null,
     "payer_contact_id": 4,
     "receiver_contact_id": 4,
     "financial_record_ids": [1,2,3]
 }
*/
