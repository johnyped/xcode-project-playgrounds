//
//  Creator.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//

import Foundation

struct Creator: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let logoImage: String?
    let staffId: Int?
    let role: Role?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case logoImage = "logo_image"
        case staffId = "staff_id"
        case role
    }
    
    init(id: Int,
         email: String,
         firstName: String,
         lastName: String,
         logoImage: String? = nil,
         staffId: Int? = nil,
         role: Role? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.logoImage = logoImage
        self.staffId = staffId
        self.role = role
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        email = (try? container.decode(String.self, forKey: .email)) ?? ""
        firstName = (try? container.decode(String.self, forKey: .firstName)) ?? ""
        lastName = (try? container.decode(String.self, forKey: .lastName)) ?? ""
        logoImage = try container.decodeIfPresent(String.self, forKey: .logoImage)
        staffId = try container.decodeIfPresent(Int.self, forKey: .staffId)
        role = try container.decodeIfPresent(Role.self, forKey: .role)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(logoImage, forKey: .logoImage)
        try container.encode(staffId, forKey: .staffId)
        try container.encodeIfPresent(role?.rawValue, forKey: .role)
    }
}

extension Creator {
    enum Role: String, Codable {
        case user = "ROLE_USER"
        case admin = "ROLE_ADMIN"
        case superAdmin = "ROLE_SUPER_ADMIN"
        case supportSuperAdmin = "ROLE_SUPPORT_SUPER_ADMIN"
    }
}

/*
 json response
 
 {
     "id": 38,
     "email": "test1@email.com",
     "first_name": "John2",
     "last_name": "Doe2",
     "logo_image": null,
     "staff_id": null,
     "role": "ROLE_SUPPORT_SUPER_ADMIN"
 }
 */
