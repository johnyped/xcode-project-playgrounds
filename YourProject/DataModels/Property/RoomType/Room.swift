//
//  Room.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation

enum UnitReservableType: String, Codable {
    case room = "ROOM"
}

struct Room: Codable {
    let id: Int
    let roomTypeId: Int
    let code: String
    let order: Int    
    let status: Status
    let needCleaning: Bool            
    let createdAt: Date
    let updatedAt: Date

    init(id: Int,
         roomTypeId: Int,
         code: String,
         order: Int,
         status: Status,
         needCleaning: Bool,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.roomTypeId = roomTypeId    
        self.code = code
        self.order = order
        self.status = status
        self.needCleaning = needCleaning        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

     //decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.roomTypeId = try container.decode(Int.self, forKey: .roomTypeId)
        self.code = try container.decode(String.self, forKey: .code)
        self.order = try container.decode(Int.self, forKey: .order)
        self.status = try container.decode(Status.self, forKey: .status)
        self.needCleaning = try container.decode(Bool.self, forKey: .needCleaning)                
        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)        
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(roomTypeId, forKey: .roomTypeId)
        try container.encode(code, forKey: .code)
        try container.encode(order, forKey: .order)
        try container.encode(status, forKey: .status)
        try container.encode(needCleaning, forKey: .needCleaning)        
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

extension Room {
    
    enum FilterBy {
        case id(id: Int)
        case roomTypeId(id: Int)
        case status(status: Status)
    }
    
    enum SortBy {
        case id
        case code
        case order
        case createdAt
        case updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case order
        case status
        case needCleaning = "need_cleaning"
        case roomTypeId = "room_type_id"        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    enum Status: String, Codable {
        case available = "AVAILABLE"
        case unavailable = "UNAVAILABLE"
        //case needCleaning = "need_cleaning"
    }
}

/*
 {
   "id": 644,
   "code": "5",
   "status": "AVAILABLE",
   "need_cleaning": true,
   "data": {},
   "order": 0,
   "created_at": "2022-01-11T00:50:21.937+07:00",
   "updated_at": "2023-06-24T15:40:31.474+07:00",
   "room_type_id": 180,
   "images": []
 }
*/
