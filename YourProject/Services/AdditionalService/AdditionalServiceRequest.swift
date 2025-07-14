//
//  AdditionalServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct AdditionalServiceRequest {
    // MARK: - Type Aliases
    typealias FetchById = ByID
    typealias DeleteAdditional = ByID
    typealias VoidAdditional = ByID    
    
    struct ByID { let id: Int }
    
    // MARK: - Enums    
    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
        case dateIssue = "DATE_ISSUE"
        case status = "STATUS"
    }
    
    // MARK: - Request Structures
    struct FetchAdditionals: Encodable {
        let hotelId: Int
        let reservationId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let status: Additional.Status?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case status
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(reservationId, forKey: .reservationId)
            
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
            if let status = status {
                try container.encode(status.rawValue, forKey: .status)
            }
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchAdditionalsByCreatedAt: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let periodDate: PeriodDate
        let status: Additional.Status?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case startAt = "start_at"
            case endAt = "end_at"
            case status
        }
        
        func encode(to encoder: Encoder) throws {
            let isoFormatter = FormConfig.DateFormat.datetimeISO
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
            if let status = status {
                try container.encode(status.rawValue, forKey: .status)
            }
            
            try container.encode(periodDate.start.toDateString(isoFormatter), forKey: .startAt)
            try container.encode(periodDate.end.toDateString(isoFormatter), forKey: .endAt)
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchAdditionalsByDateIssue: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let periodDate: PeriodDate
        let status: Additional.Status?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case startAt = "start_at"
            case endAt = "end_at"
            case status
        }
        
        func encode(to encoder: Encoder) throws {
            let isoFormatter = FormConfig.DateFormat.datetimeISO
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
            if let status = status {
                try container.encode(status.rawValue, forKey: .status)
            }
            try container.encode(periodDate.start.toDateString(isoFormatter), forKey: .startAt)
            try container.encode(periodDate.end.toDateString(isoFormatter), forKey: .endAt)
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct CreateAdditional: Encodable {
        let hotelId: Int
        let reservationId: Int
        let note: String?
        let dateIssue: Date
        let additionalItems: [Item]
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case note
            case dateIssue = "date_issue"
            case additionalItems = "additional_items"
        }
        
        func encode(to encoder: Encoder) throws {
            let isoFormatter = FormConfig.DateFormat.datetimeISO
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(reservationId, forKey: .reservationId)
            if let note {
                try container.encode(note, forKey: .note)
            }
            try container.encode(dateIssue.toDateString(isoFormatter), forKey: .dateIssue)
            try container.encode(additionalItems, forKey: .additionalItems)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct Item: Encodable {
        let price: Double
        let quantity: Int
        let itemableId: Int
        let itemableType: AdditionalItem.ItemType
        
        var totalAmount: Double {
            Double(quantity) * price
        }
        
        enum CodingKeys: String, CodingKey {
            case price
            case quantity
            case itemableId = "itemable_id"
            case itemableType = "itemable_type"
            case totalAmount = "total_amount"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(price.toString(), forKey: .price)
            try container.encode(quantity, forKey: .quantity)
            try container.encode(itemableId, forKey: .itemableId)
            try container.encode(itemableType.rawValue, forKey: .itemableType)
            try container.encode(totalAmount.toString(), forKey: .totalAmount)
        }
        
        /*
         "itemable_id" : itemID,
         "itemable_type" : itemKind.rawValue,
         "quantity" : qty,
         "price" : price,
         "total_amount" : totalAmount
         */
    }
    
    struct UpdateAdditional: Encodable {
        let id: Int
        let status: String?
        let note: String?
        let dateIssue: Date?
        let additionalItems: [Item]?
        
        enum CodingKeys: String, CodingKey {
            case status
            case note
            case dateIssue = "date_issue"
            case additionalItems = "additional_items"
        }
        
        func encode(to encoder: Encoder) throws {
            let isoFormatter = FormConfig.DateFormat.datetimeISO
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let status = status {
                try container.encode(status, forKey: .status)
            }
            if let note = note {
                try container.encode(note, forKey: .note)
            }
            if let dateIssue = dateIssue {
                try container.encode(dateIssue.toDateString(isoFormatter), forKey: .dateIssue)
            }
            if let additionalItems = additionalItems {
                try container.encode(additionalItems, forKey: .additionalItems)
            }
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
} 
