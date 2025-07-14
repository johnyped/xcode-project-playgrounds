//
//  ContactServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct ContactServiceRequest {
    typealias FetchById = ByID
    typealias DeleteContact = ByID

    struct ByID { let id: Int }

    enum SortedBy: String {
        case id = "ID"
        case companyName = "COMPANY_NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }

    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let businessType: Contact.BusinessType?
        let contactType: Contact.ContactType?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case businessType = "business_type"
            case contactType = "contact_type"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            if let page , page >= 1 {
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
            if let contactType {
                try container.encode(contactType.rawValue, forKey: .contactType)
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
    
    struct FetchByCompany: Encodable {
        let hotelId: Int
        let companyId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let businessType: Contact.BusinessType?
        let contactType: Contact.ContactType?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case companyId = "company_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case businessType = "business_type"
            case contactType = "contact_type"            
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(companyId, forKey: .companyId)
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
            if let contactType {
                try container.encode(contactType.rawValue, forKey: .contactType)
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
    
    struct FetchByCustomer: Encodable {
        let hotelId: Int
        let customerId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        let businessType: Contact.BusinessType?
        let contactType: Contact.ContactType?

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case customerId = "customer_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
            case businessType = "business_type"
            case contactType = "contact_type"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(customerId, forKey: .customerId)
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
            if let contactType {
                try container.encode(contactType.rawValue, forKey: .contactType)
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
    
    struct CreateContact: Encodable {
        let businessType: Contact.BusinessType
        let companyName: String
        let contactType: Contact.ContactType
        let contactId: Int?
        let address: String
        let branchName: String?
        let branchCode: String?
        let mobile: String?
        let email: String
        let phone: String
        let faxNumber: String?
        let taxId: String
        let website: String?
        let creditDate: String?
        let hotelId: Int
        let customerId: Int?
        let companyId: Int?
        
        enum CodingKeys: String, CodingKey {
            case businessType = "business_type"
            case companyName = "company_name"
            case contactType = "contact_type"
            case contactId = "contact_id"
            case address
            case branchName = "branch_name"
            case branchCode = "branch_code"
            case mobile
            case email
            case phone
            case faxNumber = "fax_number"
            case taxId = "tax_id"
            case website
            case creditDate = "credit_date"
            case hotelId = "hotel_id"
            case customerId = "customer_id"
            case companyId = "company_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(businessType.rawValue, forKey: .businessType)
            try container.encode(companyName, forKey: .companyName)
            try container.encode(contactType.rawValue, forKey: .contactType)
            try container.encodeIfPresent(contactId, forKey: .contactId)
            try container.encode(address, forKey: .address)
            try container.encodeIfPresent(branchName, forKey: .branchName)
            try container.encodeIfPresent(branchCode, forKey: .branchCode)
            try container.encodeIfPresent(mobile, forKey: .mobile)
            try container.encode(email, forKey: .email)
            try container.encode(phone, forKey: .phone)
            try container.encodeIfPresent(faxNumber, forKey: .faxNumber)
            try container.encode(taxId, forKey: .taxId)
            try container.encodeIfPresent(website, forKey: .website)
            try container.encodeIfPresent(creditDate, forKey: .creditDate)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(customerId, forKey: .customerId)
            try container.encodeIfPresent(companyId, forKey: .companyId)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
    
    struct UpdateContact: Encodable {
        let id: Int
        let businessType: Contact.BusinessType?
        let companyName: String?
        let contactType: Contact.ContactType?
        let contactId: Int?
        let address: String?
        let branchName: String?
        let branchCode: String?
        let mobile: String?
        let email: String?
        let phone: String?
        let faxNumber: String?
        let taxId: String?
        let website: String?
        let creditDate: String?
        let customerId: Int?
        let companyId: Int?
        
        enum CodingKeys: String, CodingKey {
            case businessType = "business_type"
            case companyName = "company_name"
            case contactType = "contact_type"
            case contactId = "contact_id"
            case address
            case branchName = "branch_name"
            case branchCode = "branch_code"
            case mobile
            case email
            case phone
            case faxNumber = "fax_number"
            case taxId = "tax_id"
            case website
            case creditDate = "credit_date"
            case customerId = "customer_id"
            case companyId = "company_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(businessType?.rawValue, forKey: .businessType)
            try container.encodeIfPresent(companyName, forKey: .companyName)
            try container.encodeIfPresent(contactType?.rawValue, forKey: .contactType)
            try container.encodeIfPresent(contactId, forKey: .contactId)
            try container.encodeIfPresent(address, forKey: .address)
            try container.encodeIfPresent(branchName, forKey: .branchName)
            try container.encodeIfPresent(branchCode, forKey: .branchCode)
            try container.encodeIfPresent(mobile, forKey: .mobile)
            try container.encodeIfPresent(email, forKey: .email)
            try container.encodeIfPresent(phone, forKey: .phone)
            try container.encodeIfPresent(faxNumber, forKey: .faxNumber)
            try container.encodeIfPresent(taxId, forKey: .taxId)
            try container.encodeIfPresent(website, forKey: .website)
            try container.encodeIfPresent(creditDate, forKey: .creditDate)
            try container.encodeIfPresent(customerId, forKey: .customerId)
            try container.encodeIfPresent(companyId, forKey: .companyId)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
} 
