//  FinancialRecordServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation

struct FinancialRecordServiceRequest {
    typealias FetchById = ByID
    typealias DeleteFinancialRecord = ByID
    
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
    
    struct FetchByReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
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
            case reservationId = "reservation_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
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
        }
        
        
    }
    
    struct FetchByCreatedAt: Encodable {
        let hotelId: Int
        let periodDate: PeriodDate
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
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            let isoDateFormat = FormConfig.DateFormat.datetimeISO
            
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(periodDate.start.toDateString(isoDateFormat), forKey: .startAt)
            try container.encode(periodDate.end.toDateString(isoDateFormat), forKey: .endAt)
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
    
    struct FetchByAccountItem: Encodable {
        let hotelId: Int
        let accountItemId: Int
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
            case accountItemId = "account_item_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(accountItemId, forKey: .accountItemId)
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
    
    struct CreateFinancialRecord: Encodable {
        let hotelId: Int
        let name: String
        let paymentMethod: String
        let note: String?
        let timestamp: Date
        let amount: Double
        let recordableId: Int
        let recordableType: FinancialRecord.RecordType
        let bankAccountId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             name: String,
             paymentMethod: String,
             note: String?,
             timestamp: Date,
             amount: Double,
             recordableId: Int,
             recordableType: FinancialRecord.RecordType,
             bankAccountId: Int?) {
            self.hotelId = hotelId
            self.name = name
            self.paymentMethod = paymentMethod
            self.note = note
            self.timestamp = timestamp
            self.amount = amount
            self.recordableId = recordableId
            self.recordableType = recordableType
            self.bankAccountId = bankAccountId
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case paymentMethod = "payment_method"
            case note
            case timestamp
            case amount
            case recordableId = "recordable_id"
            case recordableType = "recordable_type"
            case bankAccountId = "bank_account_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(paymentMethod, forKey: .paymentMethod)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encode(timestamp.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .timestamp)
            try container.encode(amount.toString(), forKey: .amount)
            try container.encode(recordableId, forKey: .recordableId)
            try container.encode(recordableType.rawValue, forKey: .recordableType)
            try container.encodeIfPresent(bankAccountId, forKey: .bankAccountId)
        }
    }
    
    struct UpdateFinancialRecord: Encodable {
        let id: Int
        let name: String?
        let paymentMethod: String?
        let note: String?
        let timestamp: Date?
        let amount: Double?
        let recordableId: Int?
        let recordableType: FinancialRecord.RecordType?
        let bankAccountId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             name: String?,
             paymentMethod: String?,
             note: String?,
             timestamp: Date?,
             amount: Double?,
             recordableId: Int?,
             recordableType: FinancialRecord.RecordType?,
             bankAccountId: Int?) {
            self.id = id
            self.name = name
            self.paymentMethod = paymentMethod
            self.note = note
            self.timestamp = timestamp
            self.amount = amount
            self.recordableId = recordableId
            self.recordableType = recordableType
            self.bankAccountId = bankAccountId
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case paymentMethod = "payment_method"
            case note
            case timestamp
            case amount
            case recordableId = "recordable_id"
            case recordableType = "recordable_type"
            case bankAccountId = "bank_account_id"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(paymentMethod, forKey: .paymentMethod)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(timestamp?.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .timestamp)
            try container.encodeIfPresent(recordableId, forKey: .recordableId)
            
            if let amount {
                try container.encode(amount.toString(), forKey: .amount)
            }
            
            if let recordableType {
                try container.encodeIfPresent(recordableType.rawValue, forKey: .recordableType)
            }
            
            try container.encodeIfPresent(bankAccountId, forKey: .bankAccountId)
        }
        
    }
    
}
