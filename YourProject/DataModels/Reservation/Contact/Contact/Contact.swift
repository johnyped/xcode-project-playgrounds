//
//  Contact.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import Foundation

struct Contact: Codable {
    let id: Int
    let businessType: BusinessType
    let companyName: String
    let contactType: ContactType
    let contactId: Int?
    let address: String
    let branchName: String
    let branchCode: String
    let mobile: String
    let email: String
    let phone: String
    let faxNumber: String
    let taxId: String
    let website: String
    let creditDate: String
    let hotelId: Int
    let customerId: Int?
    let companyId: Int?
    let createdAt: Date
    let updatedAt: Date
    
    // decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        businessType = try container.decode(BusinessType.self, forKey: .businessType)
        companyName = try container.decode(String.self, forKey: .companyName)
        contactType = try container.decode(ContactType.self, forKey: .contactType)
        contactId = try container.decode(Int?.self, forKey: .contactId)
        address = try container.decode(String.self, forKey: .address)
        branchName = try container.decodeIfPresent(String.self, forKey: .branchName) ?? ""
        branchCode = try container.decodeIfPresent(String.self, forKey: .branchCode) ?? ""
        mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
        faxNumber = try container.decodeIfPresent(String.self, forKey: .faxNumber) ?? ""
        taxId = try container.decode(String.self, forKey: .taxId)
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? ""
        creditDate = try container.decodeIfPresent(String.self, forKey: .creditDate) ?? ""
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        customerId = try container.decode(Int?.self, forKey: .customerId)
        companyId = try container.decode(Int?.self, forKey: .companyId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self,
                                         forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self,
                                         forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         businessType: BusinessType,
         companyName: String,
         contactType: ContactType,
         contactId: Int?,
         address: String,
         branchName: String,
         branchCode: String,
         mobile: String?,
         email: String,
         phone: String,
         faxNumber: String?,
         taxId: String,
         website: String?,
         creditDate: String?,
         hotelId: Int,
         customerId: Int?,
         companyId: Int?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.businessType = businessType
        self.companyName = companyName
        self.contactType = contactType
        self.contactId = contactId
        self.address = address
        self.branchName = branchName
        self.branchCode = branchCode
        self.mobile = mobile ?? ""
        self.email = email
        self.phone = phone
        self.faxNumber = faxNumber ?? ""
        self.taxId = taxId
        self.website = website ?? ""
        self.creditDate = creditDate ?? ""
        self.hotelId = hotelId
        self.customerId = customerId
        self.companyId = companyId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    // encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(businessType.rawValue, forKey: .businessType)
        try container.encode(companyName, forKey: .companyName)
        try container.encode(contactType.rawValue, forKey: .contactType)
        try container.encode(contactId, forKey: .contactId)
        try container.encode(address, forKey: .address)
        try container.encode(branchName, forKey: .branchName)
        try container.encode(branchCode, forKey: .branchCode)
        try container.encode(mobile, forKey: .mobile)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(faxNumber, forKey: .faxNumber)
        try container.encode(taxId, forKey: .taxId)
        try container.encode(website, forKey: .website)
        try container.encode(creditDate, forKey: .creditDate)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(customerId, forKey: .customerId)
        try container.encode(companyId, forKey: .companyId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat),
                             forKey: .updatedAt)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
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
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

extension Contact {

    enum BusinessType: String, Codable {
        case corporate = "CORPORATE"
        case individual = "INDIVIDUAL"
        
        var description: String {
            switch self {
            case .corporate:
                return "Corporate"
            case .individual:
                return "Individual"
            }
            
        }
    }
    
    enum ContactType: String, Codable {
        case client = "CLIENT"
        case host = "HOST"
        case supplier = "SUPPLIER"
        case supplierAndClient = "SUPPLIER_AND_CLIENT"
        
        var description: String {
            switch self {
            case .client:
                return "Client"
            case .host:
                return "Host"
            case .supplier:
                return "Supplier"
            case .supplierAndClient:
                return "Supplier and Client"
            }
        }
    }
    
}

/*
 json response
 {
 "id": 18,
 "business_type": "individual",
 "company_name": "นายสมชาย ชาติทหาร",
 "contact_type": "client",
 "contact_id": null,
 "address": "พระโขนง กรุงเทพฯ",
 "branch_name": "",
 "branch_code": "",
 "mobile": null,
 "email": "abc@email.com",
 "phone": "0829282728",
 "fax_number": null,
 "tax_id": "1234567890123",
 "website": null,
 "credit_date": null,
 "created_at": "2023-06-17T22:05:26.238+07:00",
 "updated_at": "2023-08-01T11:29:05.664+07:00",
 "hotel_id": 105,
 "customer_id": null,
 "company_id": null
 }
 */
