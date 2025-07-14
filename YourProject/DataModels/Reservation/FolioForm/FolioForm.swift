//
//  FolioForm.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation

struct FolioForm: Codable {
    let id: Int
    let status: Status
    let number: String
    let vatIncluded: Bool
    let vatPercentage: Int
    let occupiedTotalAmount: Double
    let additionalTotalAmount: Double
    let totalAmount: Double
    let amountBeforeVat: Double
    let vatAmount: Double
    let paidBeforeAmount: Double
    let remainAmount: Double
    let remark: String
    let internalNote: String
    let paymentInfo: String
    let groupRoomCharge: Bool
    let groupAdditionalItem: Bool
    let receiptIds: [Int]
    let hotelId: Int
    let hotelContactId: Int
    let customerContactId: Int
    let canceledAt: Date?
    let createdAt: Date
    let updatedAt: Date
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case canceledAt = "cancelled_at"
        case number
        case vatIncluded = "vat_included"
        case vatPercentage = "vat_percentage"
        case occupiedTotalAmount = "occupied_total_amount"
        case additionalTotalAmount = "additional_total_amount"
        case totalAmount = "total_amount"
        case amountBeforeVat = "amount_before_vat"
        case vatAmount = "vat_amount"
        case paidBeforeAmount = "paid_before_amount"
        case remainAmount = "remain_amount"
        case remark
        case internalNote = "internal_note"
        case paymentInfo = "payment_info"
        case groupRoomCharge = "group_room_charge"
        case groupAdditionalItem = "group_additional_item"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case receiptIds = "receipt_ids"
        case hotelId = "hotel_id"
        case hotelContactId = "hotel_contact_id"
        case customerContactId = "customer_contact_id"
    }
    
    init(id: Int,
         status: Status,
         number: String,
         vatIncluded: Bool,
         vatPercentage: Int,
         occupiedTotalAmount: Double,
         additionalTotalAmount: Double,
         totalAmount: Double,
         amountBeforeVat: Double,
         vatAmount: Double,
         paidBeforeAmount: Double,
         remainAmount: Double,
         remark: String,
         internalNote: String,
         paymentInfo: String,
         groupRoomCharge: Bool,
         groupAdditionalItem: Bool,
         receiptIds: [Int],
         hotelId: Int,
         hotelContactId: Int,
         customerContactId: Int,
         canceledAt: Date?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.status = status
        self.canceledAt = canceledAt
        self.number = number
        self.vatIncluded = vatIncluded
        self.vatPercentage = vatPercentage
        self.occupiedTotalAmount = occupiedTotalAmount
        self.additionalTotalAmount = additionalTotalAmount
        self.totalAmount = totalAmount
        self.amountBeforeVat = amountBeforeVat
        self.vatAmount = vatAmount
        self.paidBeforeAmount = paidBeforeAmount
        self.remainAmount = remainAmount
        self.remark = remark
        self.internalNote = internalNote
        self.paymentInfo = paymentInfo
        self.groupRoomCharge = groupRoomCharge
        self.groupAdditionalItem = groupAdditionalItem
        self.receiptIds = receiptIds
        self.hotelId = hotelId
        self.hotelContactId = hotelContactId
        self.customerContactId = customerContactId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(Status.self, forKey: .status)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        canceledAt = try container.decodeIfPresent(String.self, forKey: .canceledAt)?.tryToDate(dateFormat: dateFormat)
        
        number = try container.decode(String.self, forKey: .number)
        vatIncluded = try container.decode(Bool.self, forKey: .vatIncluded)
        vatPercentage = try container.decode(Int.self, forKey: .vatPercentage)
        occupiedTotalAmount = try container.decode(String.self, forKey: .occupiedTotalAmount).tryToDouble()
        additionalTotalAmount = try container.decode(String.self, forKey: .additionalTotalAmount).tryToDouble()
        totalAmount = try container.decode(String.self, forKey: .totalAmount).tryToDouble()
        amountBeforeVat = try container.decode(String.self, forKey: .amountBeforeVat).tryToDouble()
        vatAmount = try container.decode(String.self, forKey: .vatAmount).tryToDouble()
        paidBeforeAmount = try container.decode(String.self, forKey: .paidBeforeAmount).tryToDouble()
        remainAmount = try container.decode(String.self, forKey: .remainAmount).tryToDouble()
        remark = try container.decode(String.self, forKey: .remark)
        internalNote = try container.decode(String.self, forKey: .internalNote)
        paymentInfo = try container.decode(String.self, forKey: .paymentInfo)
        groupRoomCharge = try container.decode(Bool.self, forKey: .groupRoomCharge)
        groupAdditionalItem = try container.decode(Bool.self, forKey: .groupAdditionalItem)
        
        receiptIds = try container.decode([Int].self, forKey: .receiptIds)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        hotelContactId = try container.decode(Int.self, forKey: .hotelContactId)
        customerContactId = try container.decode(Int.self, forKey: .customerContactId)
        
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status.rawValue, forKey: .status)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encodeIfPresent(canceledAt?.toDateString(dateFormat), forKey: .canceledAt)
        
        try container.encode(number, forKey: .number)
        try container.encode(vatIncluded, forKey: .vatIncluded)
        try container.encode(vatPercentage, forKey: .vatPercentage)
        try container.encode(occupiedTotalAmount.toString(), forKey: .occupiedTotalAmount)
        try container.encode(additionalTotalAmount.toString(), forKey: .additionalTotalAmount)
        try container.encode(totalAmount.toString(), forKey: .totalAmount)
        try container.encode(amountBeforeVat.toString(), forKey: .amountBeforeVat)
        try container.encode(vatAmount.toString(), forKey: .vatAmount)
        try container.encode(paidBeforeAmount.toString(), forKey: .paidBeforeAmount)
        try container.encode(remainAmount.toString(), forKey: .remainAmount)
        try container.encode(remark, forKey: .remark)
        try container.encode(internalNote, forKey: .internalNote)
        try container.encode(paymentInfo, forKey: .paymentInfo)
        try container.encode(groupRoomCharge, forKey: .groupRoomCharge)
        try container.encode(groupAdditionalItem, forKey: .groupAdditionalItem)
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
        try container.encode(receiptIds, forKey: .receiptIds)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(hotelContactId, forKey: .hotelContactId)
        try container.encode(customerContactId, forKey: .customerContactId)
    }
}

extension FolioForm {
    enum Status: String, Codable {
        case active = "ACTIVE"
        case cancelled = "CANCELLED"
        
        var title: String {
            switch self {
            case .active:
                return "Active"
            case .cancelled:
                return "Cancelled"
            }
        }
    }
}

// MARK: PreviewEmailInfo
extension FolioForm {
   
}

/*
 {
   "id": 1,
   "status": "CANCELLED",
   "cancelled_at": "2023-06-10T14:35:57.177+07:00",
   "number": "F20230600001",
   "vat_included": false,
   "vat_percentage": 7,
   "occupied_total_amount": "1500.0",
   "additional_total_amount": "0.0",
   "total_amount": "1500.0",
   "amount_before_vat": "0.0",
   "vat_amount": "0.0",
   "paid_before_amount": "0.0",
   "remain_amount": "1500.0",
   "remark": "testrrrsss",
   "internal_note": "testrrrwww",
   "payment_info": "2, 2 (111-1-11111-2)",
   "group_room_charge": true,
   "group_additional_item": false,
   "created_at": "2023-06-09T13:31:11.727+07:00",
   "updated_at": "2023-09-12T17:39:27.760+07:00",
   "receipt_ids": [],
   "hotel_id": 105,
   "hotel_contact_id": 8,
   "customer_contact_id": 6
 }

 */
