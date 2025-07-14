//
//  CMSyncAllotment.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import Foundation

struct CMSyncAllotment: Codable {
    let id: Int
    let hotelId: Int
    let status: Status
    let startDate: Date
    let endDate: Date
    let result: [String: Any]?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case startDate = "start_date"
        case endDate = "end_date"
        case result
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode basic properties
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(Status.self, forKey: .status)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        startDate = try container.decode(String.self, forKey: .startDate).tryToDate(dateFormat)
        endDate = try container.decode(String.self, forKey: .endDate).tryToDate(dateFormat)
        
        let isoDateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(isoDateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(isoDateFormat)
        
        // Handle result as optional - skip decoding [String: Any] for now
        result = nil
    }
    
    init(id: Int,
         status: Status,
         startDate: Date,
         endDate: Date,
         result: [String: Any]? = nil,
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.status = status
        self.startDate = startDate
        self.endDate = endDate
        self.result = result
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
        try container.encode(hotelId, forKey: .hotelId)
        
        // Encode dates using DateFormatter
        let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
        try container.encode(startDate.toDateString(yyyyMMdd), forKey: .startDate)
        try container.encode(endDate.toDateString(yyyyMMdd), forKey: .endDate)
        
        // Encode ISO datetime
        let isoFormatter = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(isoFormatter), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(isoFormatter), forKey: .updatedAt)
        
        // Skip encoding result for now as [String: Any] is not directly Codable
    }
}

extension CMSyncAllotment {
    
    enum Status: String, Codable, CaseIterable {
        case pending = "PENDING"
        case done = "DONE"
    }
}

/*
{
    "id": 13,
    "status": "DONE",
    "start_date": "2025-07-09",
    "end_date": "2026-07-09",
    "result": {
        "179": {
            "success": "items updated: 0"
        },
        "180": {
            "success": "items updated: 0"
        }
    },
    "created_at": "2025-07-09T16:22:03.296+07:00",
    "updated_at": "2025-07-09T16:22:12.400+07:00",
    "hotel_id": 105
}
 */
