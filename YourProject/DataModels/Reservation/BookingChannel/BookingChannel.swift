//
//  BookingChannel.swift
//  YourProject
//
//  Created by IntrodexMini on 11/6/2568 BE.
//

import Foundation

struct BookingChannel: Codable {

    let id: Int
    let name: String
    let feeRate: Double
    let subChannels: [SubChannel]
    let createdAt: Date
    let updatedAt: Date

    init(id: Int,
     name: String, 
     feeRate: Double,
      subChannels: [SubChannel],
       createdAt: Date, 
       updatedAt: Date) {
        self.id = id
        self.name = name
        self.feeRate = feeRate
        self.subChannels = subChannels
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        feeRate = try container.decode(String.self, forKey: .feeRate).tryToDouble()
        subChannels = try container.decode([SubChannel].self, forKey: .subChannels)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(feeRate.toString(), forKey: .feeRate)
        try container.encode(subChannels, forKey: .subChannels)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension BookingChannel {
    struct SubChannel: Codable {
        let id: Int
        let name: String
        let feeRate: Double
        let createdAt: Date
        let updatedAt: Date
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case feeRate = "fee_rate"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
        
        init(id: Int, 
        name: String,
         feeRate: Double,
          createdAt: Date, 
          updatedAt: Date) {
            self.id = id
            self.name = name
            self.feeRate = feeRate
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            feeRate = try container.decode(String.self, forKey: .feeRate).tryToDouble()
            
            let dateFormat = FormConfig.DateFormat.datetimeISO
            createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
            updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(feeRate.toString(), forKey: .feeRate)
            
            let dateFormat = FormConfig.DateFormat.datetimeISO
            try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
            try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
        }
    }
}

extension BookingChannel {

     enum CodingKeys: String, CodingKey {
        case id
        case name
        case feeRate = "fee_rate"
        case subChannels = "sub_channels"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    enum FilterBy {
        case id(id: Int)
        case name(name: String)
    }
    
    enum SortBy {
        case id
        case name
        case createdAt
        case updatedAt
    }
}



/*
 json response
 {
         "id": 7,
         "name": "Online Travel Agent (OTA)",
         "fee_rate": "0.0",
         "created_at": "2017-01-18T11:33:19.931+07:00",
         "updated_at": "2017-01-18T11:33:19.931+07:00",
         "sub_channels": [
             {
                 "id": 35,
                 "name": "Beds24",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:33:10.466+07:00",
                 "updated_at": "2024-02-26T21:33:10.466+07:00"
             }
         ]
 }
 */
