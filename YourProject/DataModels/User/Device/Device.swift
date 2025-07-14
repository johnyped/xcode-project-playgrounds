//
//  Device.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

struct Device: Codable {
    let id: Int
    let uuid: String
    let token: String
    let userId: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case token
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
