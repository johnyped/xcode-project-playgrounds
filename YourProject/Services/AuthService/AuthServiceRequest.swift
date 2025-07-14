//
//  AuthServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//
import Foundation

struct AuthServiceRequest {
    struct EmailLogin: Encodable {
        let username: String
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case username
            case password
        }
    }
    
    struct AppleIdLogin: Encodable {
        let code: String
        let firstName: String?
        let lastName: String?
        let email: String?

        enum CodingKeys: String, CodingKey {
            case code
            case firstName = "first_name"
            case lastName = "last_name"
            case email
        }
    }
    
    struct TokenRefresh: Encodable {
        let token: String
        
        enum CodingKeys: String, CodingKey {
            case token = "refresh_token"
        }
    }

    struct ResendEmailConfirmation: Encodable {
        let email: String
    }

    struct PasswordReset: Encodable {
        let email: String
    }
    
    struct Signup: Encodable {
        let email: String
        let password: String
        let firstName: String?
        let lastName: String?
        let phoneNumber: String?
        let pinCode: String?
        
        enum CodingKeys: String, CodingKey {
            case email
            case password
            case firstName = "first_name"
            case lastName = "last_name"
            case phoneNumber = "phone_number"
            case pinCode = "pin_code"
        }
        
    }
}
