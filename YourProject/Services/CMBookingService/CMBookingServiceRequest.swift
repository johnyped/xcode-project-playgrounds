//  CMBookingServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMBookingServiceRequest {
    typealias FetchById = ByID
    typealias Acknowledge = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByHotel: Encodable {
        let hotelId: Int
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
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }

        init(hotelId: Int,
             page: Int? = nil,
             perPage: PerPage? = nil,
             sortedBy: SortedBy? = nil,
             sortedOrder: ServiceSortedOrder? = nil) {
            self.hotelId = hotelId
            self.page = page
            self.perPage = perPage
            self.sortedBy = sortedBy
            self.sortedOrder = sortedOrder
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
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
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let period: PeriodDate
        let includedAcknowledged: Bool?
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
            case startAt = "start_at"
            case endAt = "end_at"
            case includedAcknowledged = "included_acknowledged"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }

        init(hotelId: Int,
             period: PeriodDate,
             includedAcknowledged: Bool? = nil,
             page: Int? = nil,
             perPage: PerPage? = nil,
             sortedBy: SortedBy? = nil,
             sortedOrder: ServiceSortedOrder? = nil) {
            self.hotelId = hotelId
            self.period = period
            self.includedAcknowledged = includedAcknowledged
            self.page = page
            self.perPage = perPage
            self.sortedBy = sortedBy
            self.sortedOrder = sortedOrder
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateformat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(period.start.toDateString(dateformat), forKey: .startAt)
            try container.encode(period.end.toDateString(dateformat), forKey: .endAt)
            try container.encodeIfPresent(includedAcknowledged, forKey: .includedAcknowledged)
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
    
    struct FetchByStatus: Encodable {
        let hotelId: Int
        let status: CMBookingRaw.Status
        let includedAcknowledged: Bool?
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
            case status
            case includedAcknowledged = "included_acknowledged"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }

        init(hotelId: Int,
             status: CMBookingRaw.Status,
             includedAcknowledged: Bool? = nil,
             page: Int? = nil,
             perPage: PerPage? = nil,
             sortedBy: SortedBy? = nil,
             sortedOrder: ServiceSortedOrder? = nil) {
            self.hotelId = hotelId
            self.status = status
            self.includedAcknowledged = includedAcknowledged
            self.page = page
            self.perPage = perPage
            self.sortedBy = sortedBy
            self.sortedOrder = sortedOrder
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(status.rawValue, forKey: .status)
            try container.encodeIfPresent(includedAcknowledged, forKey: .includedAcknowledged)
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
    
    struct FetchByKeyword: Encodable {
        let hotelId: Int
        let keyword: String
        let includedAcknowledged: Bool?
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
            case keyword
            case includedAcknowledged = "included_acknowledged"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        init(hotelId: Int,
             keyword: String,
             includedAcknowledged: Bool? = nil,
             page: Int? = nil,
             perPage: PerPage? = nil,
             sortedBy: SortedBy? = nil,
             sortedOrder: ServiceSortedOrder? = nil) {
            self.hotelId = hotelId
            self.keyword = keyword
            self.includedAcknowledged = includedAcknowledged
            self.page = page
            self.perPage = perPage
            self.sortedBy = sortedBy
            self.sortedOrder = sortedOrder
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(keyword, forKey: .keyword)
            try container.encodeIfPresent(includedAcknowledged, forKey: .includedAcknowledged)
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
    
    struct FetchByBatchIds: Encodable {
        let hotelId: Int
        let ids: [Int]
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case ids
        }
        
        init(hotelId: Int,
             ids: [Int]) {
            self.hotelId = hotelId
            self.ids = ids
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(ids.map { String($0) }.joined(separator: ","), forKey: .ids)
        }
    }
    
    struct BatchAcknowledge: Encodable {
        let hotelId: Int
        let ids: [Int]
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
         ids: [Int]) {
            self.hotelId = hotelId
            self.ids = ids
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case ids = "cm_booking_ids"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(ids, forKey: .ids)
        }
    }
    
    struct Sync: Encodable {
        let hotelId: Int
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int) {
            self.hotelId = hotelId
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
        }
    }
} 
