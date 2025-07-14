//
//  Company.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct Company: Codable {
    
    let id: Int
    let userId: Int?
    let hotelId: Int?
    let busineseType: BusinessType
    let contactId: Int?
    let name: String
    let address: Address
    let taxID: String
    let branchName: String
    let branchCode: String
    let taxIncluded: Bool
    let phone: String
    let fax: String
    let email: String
    let isHidden: Bool
    let logoUrl: String?
    let createdAt: Date
    let updatedAt: Date

    init(id: Int,
         userId: Int?,
         hotelId: Int?,
         busineseType: BusinessType,
         contactId: Int?,
         name: String,
         address: Address,
         taxID: String,
         taxIncluded: Bool,
         branchName: String,
         branchCode: String,
         phone: String,
         fax: String,
         email: String,
         isHidden: Bool,
         logoUrl: String?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.userId = userId
        self.hotelId = hotelId
        self.busineseType = busineseType
        self.contactId = contactId
        self.name = name
        self.address = address
        self.taxID = taxID
        self.taxIncluded = taxIncluded
        self.branchName = branchName
        self.branchCode = branchCode
        self.phone = phone
        self.fax = fax
        self.email = email
        self.isHidden = isHidden
        self.logoUrl = logoUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try? container.decode(Int.self, forKey: .userId)
        self.hotelId = try? container.decode(Int.self, forKey: .hotelId)
        self.busineseType = try container.decode(BusinessType.self, forKey: .busineseType)
        self.contactId = try? container.decode(Int.self, forKey: .contactId)
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.taxID = (try? container.decode(String.self, forKey: .taxID)) ?? ""
        self.branchName = (try? container.decode(String.self, forKey: .branchName)) ?? ""
        self.branchCode = (try? container.decode(String.self, forKey: .branchCode)) ?? ""
        self.phone = (try? container.decode(String.self, forKey: .phone)) ?? ""
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.fax = (try? container.decode(String.self, forKey: .fax)) ?? ""
        self.logoUrl = try? container.decode(String.self, forKey: .logoUrl)
        self.isHidden = (try? container.decode(Bool.self, forKey: .isHidden)) ?? false
        self.taxIncluded = (try? container.decode(Bool.self, forKey: .taxIncluded)) ?? false
        
        let _houseNumber = (try? container.decode(String.self, forKey: .address)) ?? ""
        let _district = (try? container.decode(String.self, forKey: .district)) ?? ""
        let _province = (try? container.decode(String.self, forKey: .province)) ?? ""
        let _countryCode = (try? container.decode(String.self, forKey: .country)) ?? ""
        let _zipCode = (try? container.decode(String.self, forKey: .zipCode)) ?? ""
        
        self.address = Address(houseNumber: _houseNumber,
                               district: _district,
                               province: _province,
                               zipCode: _zipCode,
                               countryCode: _countryCode)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        self.createdAt = try container.decode(String.self,
                                              forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        self.updatedAt = try container.decode(String.self,
                                              forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(busineseType.rawValue, forKey: .busineseType)
        try container.encode(name, forKey: .name)
        try container.encode(taxID, forKey: .taxID)
        try container.encode(branchName, forKey: .branchName)
        try container.encode(branchCode, forKey: .branchCode)
        try container.encode(phone, forKey: .phone)
        try container.encode(email, forKey: .email)
        try container.encode(fax, forKey: .fax)
        try container.encode(isHidden, forKey: .isHidden)
        try container.encode(taxIncluded, forKey: .taxIncluded)
        try container.encode(logoUrl, forKey: .logoUrl)
        
        try container.encode(address.houseNumber, forKey: .address)
        try container.encode(address.district, forKey: .district)
        try container.encode(address.province, forKey: .province)
        try container.encode(address.zipCode, forKey: .zipCode)
        try container.encode(address.countryCode, forKey: .country)
        
        try container.encode(contactId, forKey: .contactId)
        try container.encode(userId, forKey: .userId)
        try container.encode(hotelId, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat),
                             forKey: .updatedAt)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case hotelId = "hotel_id"
        case busineseType = "business_type"
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
        case isHidden = "hidden"
        case logoUrl = "company_logo"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxIncluded = "tax_included"
    }
    
}

extension Company {
    
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
    
}

/*
 json response
 {
             "id": 6,
             "business_type": "corporate",
             "name": "Aom 11 ",
             "contact_id": null,
             "address": "992/1",
             "district": "Bang Bua Thong",
             "province": "Nonthaburi",
             "zip_code": "11110",
             "country": "Thailand",
             "tax_id": "9999999999999",
             "branch_name": "สำนักงานใหญ่",
             "branch_code": "001",
             "phone": "0928228229",
             "email": "abc@email.com",
             "fax": "2222222222",
             "company_logo": null,
             "stamp_signature_image": null,
             "hidden": false,
             "tax_included": false,
             "created_at": "2022-07-24T15:33:08.572+07:00",
             "updated_at": "2023-09-10T15:32:21.595+07:00",
             "user_id": 38,
             "hotel_id": 105
         }
 */
