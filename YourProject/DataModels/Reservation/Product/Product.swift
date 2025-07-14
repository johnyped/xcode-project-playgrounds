//
//  Product.swift
//  YourProject
//
//  Created by IntrodexMini on 18/6/2568 BE.
//
import Foundation

struct Product: Codable {
    let id: Int
    let hotelId: Int
    let name: String
    let description: String
    let barcode: String?
    let code: String?
    let categoryId: Int?
    let sellingPrice: Double
    let sellingVatOption: VatOption
    let buyingPrice: Double
    let buyingVatOption: VatOption
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case name
        case description
        case barcode
        case code
        case categoryId = "category_id"
        case sellingPrice = "selling_price"
        case sellingVatOption = "selling_vat_option"
        case buyingPrice = "buying_price"
        case buyingVatOption = "buying_vat_option"        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        barcode = try container.decodeIfPresent(String.self, forKey: .barcode)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        sellingPrice = try container.decode(String.self, forKey: .sellingPrice).tryToDouble()
        sellingVatOption = try container.decode(VatOption.self, forKey: .sellingVatOption)
        buyingPrice = try container.decode(String.self, forKey: .buyingPrice).tryToDouble()
        buyingVatOption = try container.decode(VatOption.self, forKey: .buyingVatOption)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         hotelId: Int,
         name: String,
         description: String = "",
         barcode: String? = "",
         code: String? = "",
         categoryId: Int? = nil,
         sellingPrice: Double,
         sellingVatOption: VatOption,
         buyingPrice: Double,
         buyingVatOption: VatOption,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.hotelId = hotelId
        self.name = name
        self.description = description
        self.barcode = barcode
        self.code = code
        self.categoryId = categoryId
        self.sellingPrice = sellingPrice
        self.sellingVatOption = sellingVatOption
        self.buyingPrice = buyingPrice
        self.buyingVatOption = buyingVatOption
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(barcode, forKey: .barcode)
        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(categoryId, forKey: .categoryId)
        try container.encode(sellingPrice.toString(), forKey: .sellingPrice)
        try container.encode(sellingVatOption, forKey: .sellingVatOption)
        try container.encode(buyingPrice.toString(), forKey: .buyingPrice)
        try container.encode(buyingVatOption, forKey: .buyingVatOption)
        try container.encode(hotelId, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension Product {
    enum VatOption: String, Codable {
        case includedVat = "INCLUDED_VAT"
        case excludedVat = "EXCLUDED_VAT"
    }
}


/*
 {
             "id": 2,
             "name": "Product",
             "description": "Description",
             "barcode": "",
             "code": "",
             "category_id": null,
             "selling_price": "11.11",
             "selling_vat_option": "EXCLUDED_VAT",
             "buying_price": "22.22",
             "buying_vat_option": "INCLUDED_VAT",
             "created_at": "2025-06-18T11:18:16.296+07:00",
             "updated_at": "2025-06-18T11:18:16.296+07:00",
             "hotel_id": 105
         }
 */
