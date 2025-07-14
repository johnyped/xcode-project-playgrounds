//
//  CompanyServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct CompanyServiceRequest {
    typealias FetchById = ByID
    typealias DeleteCompany = ByID
    typealias HideCompany = ByID
    typealias UnhideCompany = ByID

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
        let query: String?
        let onlyHidden: Bool?
        let businessType: Company.BusinessType?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case query
            case onlyHidden = "only_hidden"
            case businessType = "business_type"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
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
            if let query {
                try container.encode(query, forKey: .query)
            }
            if let onlyHidden {
                try container.encode(onlyHidden, forKey: .onlyHidden)
            }
            if let businessType {
                try container.encode(businessType.rawValue, forKey: .businessType)
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
    
    struct FetchByGuest: Encodable {
        let guestId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let businessType: Company.BusinessType?

        enum CodingKeys: String, CodingKey {
            case guestId = "guest_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case businessType = "business_type"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(guestId, forKey: .guestId)
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
            if let businessType {
                try container.encode(businessType.rawValue, forKey: .businessType)
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
    
    struct CreateCompany: Encodable {
        let userId: Int?
        let hotelId: Int
        let businessType: Company.BusinessType
        let contactId: Int?
        let name: String
        let address: String
        let district: String
        let province: String
        let zipCode: String
        let country: String
        let taxID: String
        let branchName: String
        let branchCode: String
        let phone: String
        let fax: String?
        let email: String
        let taxIncluded: Bool
        let logoUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case hotelId = "hotel_id"
            case businessType = "business_type"
            case contactId = "contact_id"
            case name
            case address
            case district
            case province
            case zipCode = "zip_code"
            case country
            case taxID = "tax_id"
            case branchName = "branch_name"
            case branchCode = "branch_code"
            case phone
            case fax
            case email
            case taxIncluded = "tax_included"
            case logoUrl = "company_logo"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(userId, forKey: .userId)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(businessType.rawValue, forKey: .businessType)
            try container.encodeIfPresent(contactId, forKey: .contactId)
            try container.encode(name, forKey: .name)
            try container.encode(address, forKey: .address)
            try container.encode(district, forKey: .district)
            try container.encode(province, forKey: .province)
            try container.encode(zipCode, forKey: .zipCode)
            try container.encode(country, forKey: .country)
            try container.encode(taxID, forKey: .taxID)
            try container.encode(branchName, forKey: .branchName)
            try container.encode(branchCode, forKey: .branchCode)
            try container.encode(phone, forKey: .phone)
            try container.encodeIfPresent(fax, forKey: .fax)
            try container.encode(email, forKey: .email)
            try container.encode(taxIncluded, forKey: .taxIncluded)
            try container.encodeIfPresent(logoUrl, forKey: .logoUrl)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct UpdateCompany: Encodable {
        let id: Int
        let userId: Int?
        let businessType: Company.BusinessType?
        let contactId: Int?
        let name: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let country: String?
        let taxID: String?
        let branchName: String?
        let branchCode: String?
        let phone: String?
        let fax: String?
        let email: String?
        let taxIncluded: Bool?
        let logoUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case businessType = "business_type"
            case contactId = "contact_id"
            case name
            case address
            case district
            case province
            case zipCode = "zip_code"
            case country
            case taxID = "tax_id"
            case branchName = "branch_name"
            case branchCode = "branch_code"
            case phone
            case fax
            case email
            case taxIncluded = "tax_included"
            case logoUrl = "company_logo"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(userId, forKey: .userId)
            try container.encodeIfPresent(businessType?.rawValue, forKey: .businessType)
            try container.encodeIfPresent(contactId, forKey: .contactId)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(address, forKey: .address)
            try container.encodeIfPresent(district, forKey: .district)
            try container.encodeIfPresent(province, forKey: .province)
            try container.encodeIfPresent(zipCode, forKey: .zipCode)
            try container.encodeIfPresent(country, forKey: .country)
            try container.encodeIfPresent(taxID, forKey: .taxID)
            try container.encodeIfPresent(branchName, forKey: .branchName)
            try container.encodeIfPresent(branchCode, forKey: .branchCode)
            try container.encodeIfPresent(phone, forKey: .phone)
            try container.encodeIfPresent(fax, forKey: .fax)
            try container.encodeIfPresent(email, forKey: .email)
            try container.encodeIfPresent(taxIncluded, forKey: .taxIncluded)
            try container.encodeIfPresent(logoUrl, forKey: .logoUrl)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
} 
