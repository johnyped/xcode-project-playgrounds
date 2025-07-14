//
//  AccountServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct AccountServiceRequest {
    // MARK: - Type Aliases for simple requests
    typealias FetchById = ByID
    typealias DeleteAccount = ByID
    typealias SetAsDefault = ByID
    
    struct ByID { let id: Int }
    
    // MARK: - Sorting Enums
    enum SortedBy: String {
        case id = "ID"        
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    // MARK: - Fetch Accounts Request
    struct FetchAccounts: Encodable {
        let hotelId: Int
        let kind: Account.Kind?        
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case kind
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
         func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            if let kind {
                try container.encode(kind.rawValue, forKey: .kind)
            }
            if let page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
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
    
    // MARK: - Fetch Account Balance Request
    struct FetchAccountBalance: Encodable {
        let id: Int
        let limitDatetime: Date?

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            if let limitDatetime {
                let dateFormat = FormConfig.DateFormat.datetimeISO
                try container.encode(limitDatetime.toDateString(dateFormat), forKey: .limitDatetime)
            }
        }

        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }

        enum CodingKeys: String, CodingKey {
            case id
            case limitDatetime = "limit_datetime"
        }
    }
    
    // MARK: - Create Account Request
    struct CreateAccount: Encodable {
        let name: String
        let startBalance: Double
        let kind: Account.Kind
        let currency: String
        let openDate: Date
        let isDefault: Bool?
        let colorRef: Int?
        let iconRef: Int?
        let hotelId: Int
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case startBalance = "start_balance"
            case kind
            case currency
            case openDate = "open_date"
            case isDefault = "is_default"
            case colorRef = "color_ref"
            case iconRef = "icon_ref"
            case hotelId = "hotel_id"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encode(startBalance.toString(), forKey: .startBalance)
            try container.encode(kind.rawValue, forKey: .kind)
            try container.encode(currency, forKey: .currency)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(openDate.toDateString(dateFormat), forKey: .openDate)
            if let isDefault {
                try container.encode(isDefault, forKey: .isDefault)
            }
            if let colorRef {
                try container.encode(colorRef, forKey: .colorRef)
            }
            if let iconRef {
                try container.encode(iconRef, forKey: .iconRef)
            }
            try container.encode(hotelId, forKey: .hotelId)
        }
    }
    
    // MARK: - Update Account Request
    struct UpdateAccount: Encodable {
        let id: Int
        let name: String?        
        let kind: Account.Kind?        
        let colorRef: Int?
        let iconRef: Int?
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case kind            
            case colorRef = "color_ref"
            case iconRef = "icon_ref"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)            
            if let name {
                try container.encode(name, forKey: .name)
            }
            if let kind {
                try container.encode(kind.rawValue, forKey: .kind)
            }
            if let colorRef {
                try container.encode(colorRef, forKey: .colorRef)
            }
            if let iconRef {
                try container.encode(iconRef, forKey: .iconRef)
            }
        }
    }
} 
