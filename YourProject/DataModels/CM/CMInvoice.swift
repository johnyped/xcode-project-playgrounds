//
//  CMInvoice.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMInvoice: Codable {
       
    let id: String
    let description: String
    let status: String
    let qty: Int
    let price: Double
    let tax: Double
    let invoiceeID: String
    
    // dont know meaning
    var type: String
    var type2: String
    
    init(id: String,
         description: String,
         status: String,
         qty: Int,
         price: Double,
         tax: Double,
         invoiceeID: String,
         type: String,
         type2: String) {
        self.id = id
        self.description = description
        self.status = status
        self.qty = qty
        self.price = price
        self.tax = tax
        self.invoiceeID = invoiceeID
        self.type = type
        self.type2 = type2
    }
    
    //decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.status = try container.decode(String.self, forKey: .status)
        self.qty = try container.decode(String.self, forKey: .qty).trytoInt()
        self.price = try container.decode(String.self, forKey: .price).tryToDouble()
        self.tax = try container.decode(String.self, forKey: .tax).tryToDouble()
        self.invoiceeID = try container.decode(String.self, forKey: .invoiceeID)
        self.type = try container.decode(String.self, forKey: .type)
        self.type2 = try container.decode(String.self, forKey: .type2)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(status, forKey: .status)
        try container.encode(qty.toString(), forKey: .qty)
        try container.encode(price.toString(), forKey: .price)
        try container.encode(tax.toString(), forKey: .tax)
        try container.encode(invoiceeID, forKey: .invoiceeID)
        try container.encode(type, forKey: .type)
        try container.encode(type2, forKey: .type2)
    }
    //enum
    enum CodingKeys: String, CodingKey {
        case id = "invoiceId"
        case description
        case status
        case qty
        case price
        case tax = "vatRate"
        case invoiceeID = "invoiceeId"
        case type
        case type2
    }
    
}


// JSON
//    "invoiceId":"28630534",
//    "description":"ห้องเตียงคู่ Friday, 14 August, 2020 - Saturday, 15 August, 2020",
//    "status":"",
//    "qty":"1",
//    "price":"338.69",
//    "vatRate":"0.00",
//    "type":"8",
//    "type2":"0",
//    "invoiceeId":""
