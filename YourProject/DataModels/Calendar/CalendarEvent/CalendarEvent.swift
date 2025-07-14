//
//  CalendarEvent.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import Foundation

struct CalendarEvent: Codable {
    let id: Int
    let hotelId: Int
    let title: String
    let note: String
    let date: Date
    let createdAt: Date
    let updatedAt: Date
    
    lazy var dateText: String = {
        date.toDateString(FormConfig.DateFormat.yyyyMMdd)
    }()
    
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case title
        case note
        case date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        title = try container.decode(String.self, forKey: .title)
        note = (try? container.decode(String.self, forKey: .note)) ?? ""
        date = try container.decode(String.self, forKey: .date).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        
        let dateTimeFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateTimeFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateTimeFormat)
    }
    
    init(id: Int,
         hotelId: Int,
         title: String,
         note: String = "",
         date: Date,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.hotelId = hotelId
        self.title = title
        self.note = note
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(title, forKey: .title)
        try container.encode(note, forKey: .note)
        try container.encode(date.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .date)
        
        let dateTimeFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateTimeFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateTimeFormat), forKey: .updatedAt)
    }
}

/* example json
{
    "id": 2,
    "hotel_id": 105,
    "title": "Demo",
    "note": " note",
    "date": "2025-07-07",
    "created_at": "2025-07-07T13:18:51.571+07:00",
    "updated_at": "2025-07-07T13:18:51.571+07:00"
}
*/
