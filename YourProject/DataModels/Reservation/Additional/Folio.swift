//
//  Folio.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//
import Foundation

struct Folio: Codable {
   
    let id: Int
    let hotelId: Int
    let status: Status
    let name: String
    let amount: Double
    let amountBeforeVat: Double
    let vatAmount: Double
    let barcode: String?
    let code: String?
    let categoryId: Int?    
    let description: String
    let vatIncluded: Bool
    let createdAt: Date
    let updatedAt: Date
        
    private enum CodingKeys: String, CodingKey {
        case id
        case status
        case hotelId = "hotel_id"
        case name
        case amount
        case amountBeforeVat = "amount_before_vat"
        case vatAmount = "vat_amount"
        case barcode
        case code
        case categoryId = "category_id"
        case description
        case vatIncluded = "vat_included"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int,
         hotelId: Int,
         status: Status,
         name: String,
         amount: Double,
         amountBeforeVat: Double,
         vatAmount: Double,
         barcode: String? = nil,
         code: String? = nil,
         categoryId: Int? = nil,
         description: String,
         vatIncluded: Bool,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.status = status
        self.name = name
        self.amount = amount
        self.amountBeforeVat = amountBeforeVat
        self.vatAmount = vatAmount
        self.barcode = barcode
        self.code = code
        self.categoryId = categoryId
        self.description = description
        self.vatIncluded = vatIncluded
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        status = try container.decode(Status.self, forKey: .status)
        name = try container.decode(String.self, forKey: .name)
        amount = try container.decode(String.self, forKey: .amount).tryToDouble()
        amountBeforeVat = try container.decode(String.self, forKey: .amountBeforeVat).tryToDouble()
        vatAmount = try container.decode(String.self, forKey: .vatAmount).tryToDouble()
        barcode = try container.decodeIfPresent(String.self, forKey: .barcode)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        description = (try? container.decode(String.self, forKey: .description)) ?? ""
        vatIncluded = try container.decode(Bool.self, forKey: .vatIncluded)
        
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }

    //encode
    func encode(to encoder: Encoder) throws {
        let datetimeISO = FormConfig.DateFormat.datetimeISO
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(status, forKey: .status)
        try container.encode(name, forKey: .name)
        try container.encode(amount.toString(), forKey: .amount)
        try container.encode(amountBeforeVat.toString(), forKey: .amountBeforeVat)
        try container.encode(vatAmount.toString(), forKey: .vatAmount)
        try container.encode(barcode, forKey: .barcode)
        try container.encode(code, forKey: .code)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(description, forKey: .description)
        try container.encode(vatIncluded, forKey: .vatIncluded)
        try container.encode(createdAt.toDateString(datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(datetimeISO), forKey: .updatedAt)
    }

}

extension Folio {
    
    enum FilterBy {
        case id(id: Int)
        case name(name: String)
        case status(status: Status)
    }
    
    enum SortBy {
        case id
        case name
        case amount
        case createdAt
        case updatedAt
    }
    
    enum Status: String, Codable {
        case available = "AVAILABLE"
        case unavailable = "UNAVAILABLE"
    }
}

/*
 revise rev2
 {
             "id": 115,
             "name": "รับส่ง",
             "amount": "500.0",
             "amount_before_vat": "500.0",
             "vat_amount": "0.0",
             "barcode": null,
             "code": null,
             "category_id": null,
             "status": "AVAILABLE",
             "amount_vat_option": null,
             "description": "",
             "vat_included": false,
             "created_at": "2019-11-29T08:20:26.443+07:00",
             "updated_at": "2023-08-25T11:25:01.734+07:00",
             "hotel_id": 105
         
 */
