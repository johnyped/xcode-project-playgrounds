//  BlackoutServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//
import Foundation

struct BlackoutServiceRequest {
    typealias FetchById = ByID
    typealias DeleteBlackoutUnit = ByID
    
    struct ByID { let id: Int }
        
    enum SortedBy: String {
        case id = "ID"
        case startDate = "START_DATE"
        case endDate = "END_DATE"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let period: PeriodDate
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
            case startDate = "start_date"
            case endDate = "end_date"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(period.start.toDateString(dateFormat), forKey: .startDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endDate)
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
    
    struct CreateBlackoutUnit: Encodable {
        let hotelId: Int
        let unitableId: Int
        let unitableType: BlackoutUnit.UnitableType
        let period: PeriodDate
        let removesDate: Date?
        let note: String?
        let emoji: String?
        let quantity: Int?
        let isDailyChunk: Bool?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             unitableId: Int,
             unitableType: BlackoutUnit.UnitableType,
             period: PeriodDate,
             removesDate: Date? = nil,
             note: String?,
             emoji: String?,
             quantity: Int = 1,
             isDailyChunk: Bool = false) {  
            self.hotelId = hotelId
            self.unitableId = unitableId
            self.unitableType = unitableType
            self.period = period
            self.removesDate = removesDate
            self.note = note
            self.emoji = emoji
            self.quantity = quantity
            self.isDailyChunk = isDailyChunk
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case unitableId = "unitable_id"
            case unitableType = "unitable_type"
            case startDate = "start_date"
            case endDate = "end_date"
            case removesDate = "removes_date"
            case note
            case emoji
            case quantity
            case isDailyChunk = "is_daily_chunk"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(unitableId, forKey: .unitableId)
            try container.encode(unitableType.rawValue, forKey: .unitableType)
            try container.encode(period.start.toDateString(dateFormat), forKey: .startDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endDate)
            try container.encodeIfPresent(removesDate?.toDateString(dateFormat), forKey: .removesDate)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(emoji, forKey: .emoji)
            try container.encodeIfPresent(quantity, forKey: .quantity)
            try container.encodeIfPresent(isDailyChunk, forKey: .isDailyChunk)
        }
    }
    
    struct UpdateBlackoutUnit: Encodable {
        let id: Int
        let note: String?
        let emoji: String?
        let removesDate: Date?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,           
             note: String?,
             emoji: String?,
             removesDate: Date?) {
            self.id = id
            self.note = note
            self.emoji = emoji
            self.removesDate = removesDate
        }
        
        enum CodingKeys: String, CodingKey {
            case note
            case emoji
            case removesDate = "removes_date"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(emoji, forKey: .emoji)
            try container.encodeIfPresent(removesDate?.toDateString(dateFormat), forKey: .removesDate)
        }
    }
    
    struct BatchCreateBlackoutUnits: Encodable {
        let hotelId: Int
        let blackoutUnits: [BatchBlackoutUnit]
        let isDailyChunk: Bool?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
         blackoutUnits: [BatchBlackoutUnit],
         isDailyChunk: Bool? = nil) {
            self.hotelId = hotelId
            self.blackoutUnits = blackoutUnits
            self.isDailyChunk = isDailyChunk
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case blackoutUnits = "blackout_units"
            case isDailyChunk = "is_daily_chunk"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(blackoutUnits, forKey: .blackoutUnits)
            try container.encodeIfPresent(isDailyChunk, forKey: .isDailyChunk)
        }

    }
    
    struct BatchDeleteBlackoutUnits: Encodable {
        let hotelId: Int
        let ids: [Int]
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        init(hotelId: Int, ids: [Int]) {
            self.hotelId = hotelId
            self.ids = ids
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case ids = "blackout_unit_ids"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(ids, forKey: .ids)
        }
    }
} 

extension BlackoutServiceRequest {
    struct BatchBlackoutUnit: Encodable { 
        let unitableId: Int
        let unitableType: BlackoutUnit.UnitableType
        let period: PeriodDate
        let removesDate: Date?
        let note: String?
        let emoji: String?
        let quantity: Int?

        init(unitableId: Int,
             unitableType: BlackoutUnit.UnitableType,
             period: PeriodDate,
             removesDate: Date? = nil,
             note: String? = nil,
             emoji: String? = nil,
             quantity: Int? = nil) {
            self.unitableId = unitableId
            self.unitableType = unitableType
            self.period = period
            self.removesDate = removesDate
            self.note = note
            self.emoji = emoji
            self.quantity = quantity
        }

        enum CodingKeys: String, CodingKey {
            case unitableId = "unitable_id"
            case unitableType = "unitable_type"
            case startDate = "start_date"
            case endDate = "end_date"
            case removesDate = "removes_date"
            case note
            case emoji
            case quantity
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(unitableId, forKey: .unitableId)
            try container.encode(unitableType.rawValue, forKey: .unitableType)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(period.start.toDateString(dateFormat), forKey: .startDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endDate)
            try container.encodeIfPresent(removesDate?.toDateString(dateFormat), forKey: .removesDate)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(emoji, forKey: .emoji)
            try container.encodeIfPresent(quantity, forKey: .quantity)
        }
    }
}
