//  AccountSubItemCategoryServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//
import Foundation

struct AccountSubItemCategoryServiceRequest {
    typealias FetchById = ByID
    typealias DeleteAccountSubItemCategory = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case name = "NAME"
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
    
    struct FetchByAccountItemCategory: Encodable {
        let hotelId: Int
        let accountItemCategoryId: Int
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case accountItemCategoryId = "account_item_category_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
        }
    }
    
    struct CreateAccountSubItemCategory: Encodable {
        let hotelId: Int
        let name: String
        let accountItemCategoryId: Int
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             name: String,
             accountItemCategoryId: Int) {
            self.hotelId = hotelId
            self.name = name
            self.accountItemCategoryId = accountItemCategoryId
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case accountItemCategoryId = "account_item_category_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
        }
    }
    
    struct UpdateAccountSubItemCategory: Encodable {
        let id: Int
        let name: String?
        let accountItemCategoryId: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             name: String?,
             accountItemCategoryId: Int?) {
            self.id = id
            self.name = name
            self.accountItemCategoryId = accountItemCategoryId
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case accountItemCategoryId = "account_item_category_id"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            if let name = name {
                try container.encode(name, forKey: .name)
            }
            
            if let accountItemCategoryId = accountItemCategoryId {
                try container.encode(accountItemCategoryId, forKey: .accountItemCategoryId)
            }
        }
    }
} 
