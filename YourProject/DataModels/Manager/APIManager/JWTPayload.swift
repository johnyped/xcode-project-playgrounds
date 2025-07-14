//
//  JWTPayload.swift
//  YourProject
//
//  Created by IntrodexMini on 22/2/2568 BE.
//
import Foundation

struct JWTPayload: Codable {
    let userId: Int
    let clientId: String?
    let staffRole: String?
    let accessibleHotelsIds: [Int]
    let packageExpiresAt: String?
    let jti: String
    let iat: Int
    let exp: Int
    let sub: String
    let authMethod: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case clientId = "client_id"
        case staffRole = "staff_role"
        case accessibleHotelsIds = "accessible_hotels_ids"
        case packageExpiresAt = "package_expires_at"
        case jti
        case iat
        case exp
        case sub
        case authMethod = "auth_method"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int.self, forKey: .userId)
        clientId = try container.decodeIfPresent(String.self, forKey: .clientId)
        staffRole = try container.decodeIfPresent(String.self, forKey: .staffRole)
        accessibleHotelsIds = try container.decode([Int].self, forKey: .accessibleHotelsIds)
        packageExpiresAt = try container.decodeIfPresent(String.self, forKey: .packageExpiresAt)
        jti = try container.decode(String.self, forKey: .jti)
        iat = try container.decode(Int.self, forKey: .iat)
        exp = try container.decode(Int.self, forKey: .exp)
        sub = try container.decode(String.self, forKey: .sub)
        authMethod = try container.decode(String.self, forKey: .authMethod)
    }
    
    init(jwtToken: String) throws {
        let segments = jwtToken.components(separatedBy: ".")
        guard segments.count == 3,
              let payloadData = Self.base64UrlDecode(segments[1]) else {
            throw NSError(domain: "JWTDecoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JWT format"])
        }
        
        self = try JSONDecoder().decode(JWTPayload.self, from: payloadData)
    }
    
    private static func base64UrlDecode(_ base64UrlString: String) -> Data? {
        var base64 = base64UrlString
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Add padding if needed
        while base64.count % 4 != 0 {
            base64 += "="
        }
        
        return Data(base64Encoded: base64)
    }
}
