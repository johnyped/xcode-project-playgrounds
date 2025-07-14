//
//  CategoryServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct CategoryServiceRequest {
    // MARK: - Type Aliases
    typealias FetchById = ByID
    typealias DeleteCategory = ByID
    
    struct ByID { let id: Int }
    
    // MARK: - Enums
    enum SortedBy: String {
        case id = "ID"
        case name = "NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    // MARK: - Request Structures
    struct FetchCategories: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let kind: Category.Kind?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case kind
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
            if let kind = kind {
                try container.encode(kind.rawValue, forKey: .kind)
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
    
    struct CreateCategory: Encodable {
        let hotelId: Int
        let name: String
        let kind: Category.Kind
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case kind
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(kind.rawValue, forKey: .kind)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct UpdateCategory: Encodable {
        let id: Int
        let name: String?
        let kind: Category.Kind?
        
        enum CodingKeys: String, CodingKey {
            case name
            case kind
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let name = name {
                try container.encode(name, forKey: .name)
            }
            if let kind = kind {
                try container.encode(kind.rawValue, forKey: .kind)
            }
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
} 
