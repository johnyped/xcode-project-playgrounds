//
//  ProductUnitServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct ProductUnitServiceRequest {
    typealias FetchById = ByID
    typealias DeleteProductUnit = ByID

    struct ByID { let id: Int }

    enum SortedBy: String {
        case id = "ID"
        case unit = "UNIT"
        case kind = "KIND"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }

    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let kind: ProductUnit.Kind?
        let query: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case kind
            case query = "q"
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
            if let query = query {
                try container.encode(query, forKey: .query)
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
    
    struct CreateProductUnit: Encodable {
        let hotelId: Int
        let unit: String
        let kind: ProductUnit.Kind
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case unit
            case kind
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(unit, forKey: .unit)
            try container.encode(kind.rawValue, forKey: .kind)
        }
    }
    
    struct UpdateProductUnit: Encodable {
        let id: Int
        let hotelId: Int
        let unit: String
        let kind: ProductUnit.Kind
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case unit
            case kind
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(unit, forKey: .unit)
            try container.encode(kind.rawValue, forKey: .kind)
        }
    }
} 
