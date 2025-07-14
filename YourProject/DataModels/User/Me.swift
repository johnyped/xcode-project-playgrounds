//
//  Me.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//


import Foundation

struct Me: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let role: Role?
    let idCard: String
    let logoImage: String?
    let signSignatureImage: String?
    let verifiedAt: String?
    let passwordChangedAt: String?
    let authProviders: [String]
    let staffId: Int?
    let images: [String]
    
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, email, role, images, staff
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case idCard = "id_card"
        case logoImage = "logo_image"
        case signSignatureImage = "sign_signature_image"
        case verifiedAt = "verified_at"
        case passwordChangedAt = "password_changed_at"
        case authProviders = "auth_providers"
        case staffId = "staff_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        role = try? container.decode(Role.self, forKey: .role)
        idCard = try container.decode(String.self, forKey: .idCard)
        logoImage = try container.decodeIfPresent(String.self, forKey: .logoImage)
        signSignatureImage = try container.decodeIfPresent(String.self, forKey: .signSignatureImage)
        verifiedAt = try container.decodeIfPresent(String.self, forKey: .verifiedAt)
        passwordChangedAt = try container.decodeIfPresent(String.self, forKey: .passwordChangedAt)        
        authProviders = try container.decode([String].self, forKey: .authProviders)
        images = try container.decode([String].self, forKey: .images)
        staffId = try container.decodeIfPresent(Int.self, forKey: .staffId)
        
        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }    

    init(id: Int,
         email: String,
         firstName: String,
         lastName: String,
         phoneNumber: String,
         role: Role?,
         idCard: String,
         logoImage: String?,
         signSignatureImage: String?,
         verifiedAt: String?,
         passwordChangedAt: String?,
         authProviders: [String],
         images: [String],
         staffId: Int?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.role = role
        self.idCard = idCard
        self.logoImage = logoImage
        self.signSignatureImage = signSignatureImage
        self.verifiedAt = verifiedAt
        self.passwordChangedAt = passwordChangedAt
        self.authProviders = authProviders
        self.images = images
        self.staffId = staffId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(role?.rawValue, forKey: .role)
        try container.encode(idCard, forKey: .idCard)
        try container.encodeIfPresent(logoImage, forKey: .logoImage)
        try container.encodeIfPresent(signSignatureImage, forKey: .signSignatureImage)
        try container.encodeIfPresent(verifiedAt, forKey: .verifiedAt)
        try container.encodeIfPresent(passwordChangedAt, forKey: .passwordChangedAt)        
        try container.encode(authProviders, forKey: .authProviders)
        try container.encode(images, forKey: .images)
        try container.encodeIfPresent(staffId, forKey: .staffId)
        
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

extension Me {
        
    enum Role: String, Codable {
        case user = "ROLE_USER"
        case admin = "ROLE_ADMIN"
        case superAdmin = "ROLE_SUPER_ADMIN"
        case supportSuperAdmin = "ROLE_SUPPORT_SUPER_ADMIN"
    }
}

/*
 {
 "id": 38,
 "email": "test1@email.com",
 "first_name": "John2",
 "last_name": "Doe2",
 "phone_number": "1234567890",
 "role": "ROLE_SUPPORT_SUPER_ADMIN",
 "id_card": "1232323232333",
 "logo_image": null,
 "sign_signature_image": null,
 "verified_at": null,
 "password_changed_at": "2023-11-28T06:11:43.011+07:00",
 "created_at": "2016-12-28T20:54:08.650+07:00",
 "updated_at": "2025-02-26T05:35:58.313+07:00",
 "auth_providers": [],
 "staff_id": null,
 "images": [],

 }
 */


