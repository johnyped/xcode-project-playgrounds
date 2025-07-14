//
//  CMRateCodes.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMRateCodes: Codable {
    let bookingcomRateCode: [CMRateCode]
    let agodacomRateCode: [CMRateCode]
    let ctripRateCode: [CMRateCode]
    let expediacomRateCode: [CMRateCode]
    let travelokacomRateCode: [CMRateCode]
    let traviaRateCode: [CMRateCode]
    
    init() {
        bookingcomRateCode = []
        agodacomRateCode = []
        ctripRateCode = []
        expediacomRateCode = []
        travelokacomRateCode = []
        traviaRateCode = []
    }
    
    init (bookingcomRateCode: [CMRateCode],
          agodacomRateCode: [CMRateCode],
          ctripRateCode: [CMRateCode],
          expediacomRateCode: [CMRateCode],
          travelokacomRateCode: [CMRateCode],
          traviaRateCode: [CMRateCode]) {
        self.bookingcomRateCode = bookingcomRateCode
        self.agodacomRateCode = agodacomRateCode
        self.ctripRateCode = ctripRateCode
        self.expediacomRateCode = expediacomRateCode
        self.travelokacomRateCode = travelokacomRateCode
        self.traviaRateCode = traviaRateCode
    }
    
    //decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bookingcomRateCode = try container.decode([CMRateCode].self, forKey: .bookingcomRateCode)
        agodacomRateCode = try container.decode([CMRateCode].self, forKey: .agodacomRateCode)
        ctripRateCode = try container.decode([CMRateCode].self, forKey: .ctripRateCode)
        expediacomRateCode = try container.decode([CMRateCode].self, forKey: .expediacomRateCode)
        travelokacomRateCode = try container.decode([CMRateCode].self, forKey: .travelokacomRateCode)
        traviaRateCode = try container.decode([CMRateCode].self, forKey: .traviaRateCode)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bookingcomRateCode, forKey: .bookingcomRateCode)
        try container.encode(agodacomRateCode, forKey: .agodacomRateCode)
        try container.encode(ctripRateCode, forKey: .ctripRateCode)
        try container.encode(expediacomRateCode, forKey: .expediacomRateCode)
        try container.encode(travelokacomRateCode, forKey: .travelokacomRateCode)
        try container.encode(traviaRateCode, forKey: .traviaRateCode)
    }
    
    enum CodingKeys: String, CodingKey {
        case bookingcomRateCode
        case agodacomRateCode
        case ctripRateCode
        case expediacomRateCode
        case travelokacomRateCode
        case traviaRateCode
    }
    
}

struct CMRateCode: Codable {
    let name: String
    let code: String
    
    init (name: String,
          code: String) {
        self.name = name
        self.code = code
    }
    
    //decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(code, forKey: .code)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case code
    }
}

/*
 json
 {
     "bookingcomRateCode" : [
         {
             "name" : "None Refund",
             "code" : "9705762"
         } , {
             "name" : "Standard",
             "code" : "20774025"
         }
     ],
     "agodacomRateCode": [],
     "ctripRateCode" : [],
     "expediacomRateCode" : [],
     "travelokacomRateCode" : [],
     "traviaRateCode" : []
 }
 */
