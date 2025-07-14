//  AccountItemCategoryServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//
import Foundation

struct AccountItemCategoryServiceRequest {
    typealias FetchById = ByID
    typealias FetchSubCategories = ByID
    typealias DeleteAccountItemCategory = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case name = "NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByHotel: Encodable {
        let hotelId: Int
        let kind: AccountItemCategory.Kind?
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
            case kind
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            if let kind = kind {
                try container.encode(kind.rawValue, forKey: .kind)
            }
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
    
    struct CreateAccountItemCategory: Encodable {
        let hotelId: Int
        let name: String
        let kind: AccountItemCategory.Kind
        let iconRef: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(hotelId: Int,
             name: String,
             kind: AccountItemCategory.Kind,
             iconRef: Int?) {
            self.hotelId = hotelId
            self.name = name
            self.kind = kind
            self.iconRef = iconRef
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case kind
            case iconRef = "icon_ref"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(kind.rawValue, forKey: .kind)
            try container.encodeIfPresent(iconRef, forKey: .iconRef)
        }
    }
    
    struct UpdateAccountItemCategory: Encodable {
        let id: Int
        let name: String?
        let iconRef: Int?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        init(id: Int,
             name: String?,
             iconRef: Int?) {
            self.id = id
            self.name = name
            self.iconRef = iconRef
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case iconRef = "icon_ref"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            if let name {
                try container.encode(name, forKey: .name)
            }
            
            if let iconRef {
                try container.encode(iconRef, forKey: .iconRef)
            }
        }
    }
} 
