//  CalendarEventServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import Foundation

struct CalendarEventServiceRequest {
    typealias FetchById = ByID
    typealias DeleteCalendarEvent = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByMonth: Encodable {
        let hotelId: Int
        let date: Date  // YYYY-MM format for month
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case date
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            let dateFormat = FormConfig.DateFormat.yyyyMM
            try container.encode(date.toDateString(dateFormat), forKey: .date)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct FetchByDay: Encodable {
        let hotelId: Int
        let date: Date
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case date
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(date.toDateString(dateFormat), forKey: .date)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct CreateCalendarEvent: Encodable {
        let hotelId: Int
        let date: Date
        let title: String
        let note: String? 
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             date: Date,
             title: String,
             note: String? = nil) {
            self.hotelId = hotelId
            self.date = date
            self.title = title
            self.note = note
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case date
            case title
            case note
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(date.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .date)
            try container.encode(title, forKey: .title)
            try container.encodeIfPresent(note, forKey: .note)
        }
    }
    
    struct UpdateCalendarEvent: Encodable {
        let id: Int
        let date: Date?
        let title: String?
        let note: String?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             date: Date?,
             title: String?,
             note: String?) {
            self.id = id
            self.date = date
            self.title = title
            self.note = note
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case date
            case title
            case note
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(date?.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .date)
            try container.encodeIfPresent(title, forKey: .title)
            try container.encodeIfPresent(note, forKey: .note)            
        }
    }
} 
