//
//  ProductServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct ProductServiceRequest {
    typealias FetchById = ByID
    typealias DeleteProduct = ByID

    struct ByID { let id: Int }

    enum SortedBy: String {
        case id = "ID"
        case name = "NAME"
        case sellingPrice = "SELLING_PRICE"
        case buyingPrice = "BUYING_PRICE"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }

    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let categoryId: Int?
        let query: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case categoryId = "category_id"
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
            if let categoryId = categoryId {
                try container.encode(categoryId, forKey: .categoryId)
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
    
    struct CreateProduct: Encodable {
        let hotelId: Int
        let name: String
        let description: String
        let barcode: String?
        let code: String?
        let categoryId: Int?
        let sellingPrice: Double
        let sellingVatOption: Product.VatOption
        let buyingPrice: Double
        let buyingVatOption: Product.VatOption
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case description
            case barcode
            case code
            case categoryId = "category_id"
            case sellingPrice = "selling_price"
            case sellingVatOption = "selling_vat_option"
            case buyingPrice = "buying_price"
            case buyingVatOption = "buying_vat_option"
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(description, forKey: .description)
            try container.encodeIfPresent(barcode, forKey: .barcode)
            try container.encodeIfPresent(code, forKey: .code)
            try container.encodeIfPresent(categoryId, forKey: .categoryId)
            try container.encode(sellingPrice.toString(), forKey: .sellingPrice)
            try container.encode(sellingVatOption, forKey: .sellingVatOption)
            try container.encode(buyingPrice.toString(), forKey: .buyingPrice)
            try container.encode(buyingVatOption, forKey: .buyingVatOption)
        }
    }
    
    struct UpdateProduct: Encodable {
        let id: Int
        let hotelId: Int
        let name: String
        let description: String
        let barcode: String?
        let code: String?
        let categoryId: Int?
        let sellingPrice: Double
        let sellingVatOption: Product.VatOption
        let buyingPrice: Double
        let buyingVatOption: Product.VatOption
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case description
            case barcode
            case code
            case categoryId = "category_id"
            case sellingPrice = "selling_price"
            case sellingVatOption = "selling_vat_option"
            case buyingPrice = "buying_price"
            case buyingVatOption = "buying_vat_option"
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(description, forKey: .description)
            try container.encodeIfPresent(barcode, forKey: .barcode)
            try container.encodeIfPresent(code, forKey: .code)
            try container.encodeIfPresent(categoryId, forKey: .categoryId)
            try container.encode(sellingPrice.toString(), forKey: .sellingPrice)
            try container.encode(sellingVatOption, forKey: .sellingVatOption)
            try container.encode(buyingPrice.toString(), forKey: .buyingPrice)
            try container.encode(buyingVatOption, forKey: .buyingVatOption)
        }
    }
} 
