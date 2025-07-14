//
//  Staff.swift
//  YourProject
//
//  Created by IntrodexMac on 10/5/2568 BE.
//

import Foundation

struct Staff: Codable {
    let id: Int
    let status: Status
    let role: Role
    let userId: Int
    let username: String
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    let idCard: String?
    let email: String?
    let logoImage: String?
    let signSignatureImage: String?
    let hotelId: Int
    
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case role
        case userId = "user_id"
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case idCard = "id_card"
        case email
        case logoImage = "logo_image"
        case signSignatureImage = "sign_signature_image"
        case hotelId = "hotel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(Status.self, forKey: .status)
        role = try container.decode(Role.self, forKey: .role)
        
        userId = try container.decode(Int.self, forKey: .userId)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        idCard = try container.decodeIfPresent(String.self, forKey: .idCard)
        logoImage = try container.decodeIfPresent(String.self, forKey: .logoImage)
        signSignatureImage = try container.decodeIfPresent(String.self, forKey: .signSignatureImage)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         status: Status,
         role: Role,
         userId: Int,
         username: String,
         email: String?,
         firstName: String?,
         lastName: String?,
         phoneNumber: String?,
         idCard: String?,
         logoImage: String?,
         signSignatureImage: String?,
         hotelId: Int,
         createdAt: Date = Date(),
         updatedAt: Date = Date()) {
        self.id = id
        self.status = status
        self.role = role
        self.userId = userId
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName        
        self.phoneNumber = phoneNumber
        self.idCard = idCard
        self.logoImage = logoImage
        self.signSignatureImage = signSignatureImage
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
        try container.encode(role, forKey: .role)
        
        try container.encode(userId, forKey: .userId)
        try container.encode(username, forKey: .username)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(idCard, forKey: .idCard)
        try container.encodeIfPresent(logoImage, forKey: .logoImage)
        try container.encodeIfPresent(signSignatureImage, forKey: .signSignatureImage)
        try container.encode(hotelId, forKey: .hotelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension Staff {
    enum Status: String, Codable, CaseIterable {
        case active = "ACTIVE"
        case inactive = "INACTIVE"
        
        var description: String {
            switch self {
            case .active:
                return "Active"
            case .inactive:
                return "Inactive"
            }
        }
    }
    
    enum Role: String, Codable, CaseIterable {
        case frontDesk = "FRONT_DESK"
        case manager = "MANAGER"
        case accountant = "ACCOUNTANT"
        case maid = "MAID"
        
        var description: String {
            switch self {
            case .frontDesk:
                return "Front Desk"
            case .manager:
                return "Manager"
            case .accountant:
                return "Accountant"
            case .maid:
                return "Maid"
            }
        }
    }
}

/*
 json response
 {
         "id": 36,
         "status": "ACTIVE",
         "role": "FRONT_DESK",
         "created_at": "2021-11-16T13:17:05.109+07:00",
         "updated_at": "2021-11-16T13:17:05.109+07:00",
         "user_id": 127,
         "email": "demo_staff123@email.com",
         "first_name": "rrr",
         "last_name": "fff",
         "phone_number": "[[rpr[e",
         "id_card": "3434434",
         "logo_image": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/65f988f3-b52c-47dc-8e82-5bddf1c47b8b/F9FD7BD0-356A-407C-892B-946C9EBAB000.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250704%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250704T102920Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d20a28c3aeca8615d7fc9114cfe68ee47e9415e1f5b2fc9aa670fe0cb1b3dac3",
         "sign_signature_image": null,
         "username": "demo_staff123@email.com",
         "hotel_id": 105
 }
 */
