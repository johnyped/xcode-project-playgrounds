//
//  AccountItemServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct AccountItemServiceRequest {
    typealias FetchById = ByID
    typealias DeleteAccountItem = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let accountId: Int
        let periodDate: PeriodDate
        let accountItemCategoryId: Int?
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
            case accountId = "account_id"
            case startDatetime = "start_datetime"
            case endDatetime = "end_datetime"
            case accountItemCategoryId = "account_item_category_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let isoDateFormat = FormConfig.DateFormat.datetimeISO
            
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(accountId, forKey: .accountId)
            try container.encode(periodDate.start.toDateString(isoDateFormat), forKey: .startDatetime)
            try container.encode(periodDate.end.toDateString(isoDateFormat), forKey: .endDatetime)
            try container.encodeIfPresent(accountItemCategoryId, forKey: .accountItemCategoryId)
            
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
        let query: String
        let hotelId: Int
        let accountId: Int
        let accountItemCategoryId: Int?
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
            case query = "q"
            case hotelId = "hotel_id"
            case accountId = "account_id"
            case accountItemCategoryId = "account_item_category_id"
            case startDatetime = "start_datetime"
            case endDatetime = "end_datetime"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let isoDateFormat = FormConfig.DateFormat.datetimeISO
            
            try container.encode(query, forKey: .query)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(accountId, forKey: .accountId)
            try container.encodeIfPresent(accountItemCategoryId, forKey: .accountItemCategoryId)
            
            try container.encode(periodDate.start.toDateString(isoDateFormat), forKey: .startDatetime)
            try container.encode(periodDate.end.toDateString(isoDateFormat), forKey: .endDatetime)

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
    
    struct CreateAccountItem: Encodable {
        let currency: String
        let memo: String?
        let date: Date
        let amount: Double
        let accountId: Int
        let payeeId: Int
        let accountItemCategoryId: Int
        let accountSubItemCategoryId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(currency: String,
             memo: String? = nil,
             date: Date,
             amount: Double,
             accountId: Int,
             payeeId: Int,
             accountItemCategoryId: Int,
             accountSubItemCategoryId: Int? = nil) {
            self.currency = currency
            self.memo = memo
            self.date = date
            self.amount = amount
            self.accountId = accountId
            self.payeeId = payeeId
            self.accountItemCategoryId = accountItemCategoryId
            self.accountSubItemCategoryId = accountSubItemCategoryId
        }
        
        enum CodingKeys: String, CodingKey {
            case currency
            case memo
            case date
            case amount
            case accountId = "account_id"
            case payeeId = "payee_id"
            case accountItemCategoryId = "account_item_category_id"
            case accountSubItemCategoryId = "account_sub_item_category_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let isoDateFormat = FormConfig.DateFormat.datetimeISO
            
            try container.encode(currency, forKey: .currency)
            try container.encodeIfPresent(memo, forKey: .memo)
            try container.encode(date.toDateString(isoDateFormat), forKey: .date)
            try container.encode(amount.toString(), forKey: .amount)
            try container.encode(accountId, forKey: .accountId)
            try container.encode(payeeId, forKey: .payeeId)
            try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
            try container.encodeIfPresent(accountSubItemCategoryId, forKey: .accountSubItemCategoryId)
        }
    }
    
    struct UpdateAccountItem: Encodable {
        let id: Int
        let currency: String?
        let memo: String?
        let date: Date?
        let amount: Double?        
        let accountId: Int?
        let payeeId: Int?
        let accountItemCategoryId: Int?
        let accountSubItemCategoryId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             currency: String? = nil,
             memo: String? = nil,
             date: Date? = nil,
             amount: Double? = nil,             
             accountId: Int? = nil,
             payeeId: Int? = nil,
             accountItemCategoryId: Int? = nil,
             accountSubItemCategoryId: Int? = nil) {
            self.id = id
            self.currency = currency
            self.memo = memo
            self.date = date
            self.amount = amount
            self.accountId = accountId
            self.payeeId = payeeId
            self.accountItemCategoryId = accountItemCategoryId
            self.accountSubItemCategoryId = accountSubItemCategoryId
        }
        
        enum CodingKeys: String, CodingKey {
            case currency
            case memo
            case date
            case amount
            case accountId = "account_id"
            case payeeId = "payee_id"
            case accountItemCategoryId = "account_item_category_id"
            case accountSubItemCategoryId = "account_sub_item_category_id"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let isoDateFormat = FormConfig.DateFormat.datetimeISO
            
            try container.encodeIfPresent(currency, forKey: .currency)
            try container.encodeIfPresent(memo, forKey: .memo)
            
            if let date = date {
                try container.encode(date.toDateString(isoDateFormat), forKey: .date)
            }
            if let amount = amount {
                try container.encode(amount.toString(), forKey: .amount)
            }
            
            try container.encodeIfPresent(accountId, forKey: .accountId)
            try container.encodeIfPresent(payeeId, forKey: .payeeId)
            try container.encodeIfPresent(accountItemCategoryId, forKey: .accountItemCategoryId)
            try container.encodeIfPresent(accountSubItemCategoryId, forKey: .accountSubItemCategoryId)
        }
    }
} 