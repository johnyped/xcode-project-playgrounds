//
//  FolioServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct FolioServiceRequest {
    typealias FetchFolio = ByID
    typealias DeleteFolio = ByID

    struct ByID { let id: Int }
    
    enum SortedBy: String, Codable {
        case id = "ID"
        case name = "NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    enum VatOption: String, Codable {
        
        case excludedVat = "EXCLUDED_VAT"
        case includedVat = "INCLUDED_VAT"
        case zeroVat = "ZERO_VAT"
        case noVat = "NO_VAT"
    }
    
    struct FetchFolios: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let status: Folio.Status?
        let vatOption: VatOption?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case status
            case vatOption = "vat_option"
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
            if let status = status {
                try container.encode(status.rawValue, forKey: .status)
            }
            if let vatOption = vatOption {
                try container.encode(vatOption.rawValue, forKey: .vatOption)
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
    
    struct FetchFoliosByCategory: Encodable {
        let hotelId: Int
        let categoryId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case categoryId = "category_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(categoryId, forKey: .categoryId)
        }
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct CreateFolio: Encodable {
        let hotelId: Int
        let name: String
        let amount: Double
        let description: String?
        let categoryId: Int?
        let amountVatOption: VatOption
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case amount
            case description
            case categoryId = "category_id"
            case amountVatOption = "amount_vat_option"
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode("\(amount)", forKey: .amount)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(categoryId, forKey: .categoryId)
            try container.encode(amountVatOption.rawValue, forKey: .amountVatOption)
        }
    }
    
    struct UpdateFolio: Encodable {
        let id: Int
        let name: String?
        let amount: Double?
        let description: String?
        let categoryId: Int?
        let amountVatOption: VatOption?
        
        enum CodingKeys: String, CodingKey {
            case name
            case amount
            case description
            case categoryId = "category_id"
            case amountVatOption = "amount_vat_option"
            // id is not encoded as it's used in the URL path
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(name, forKey: .name)
            if let amount = amount {
                try container.encode("\(amount)", forKey: .amount)
            }
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(categoryId, forKey: .categoryId)
            try container.encodeIfPresent(amountVatOption?.rawValue, forKey: .amountVatOption)
        }
    }
} 
