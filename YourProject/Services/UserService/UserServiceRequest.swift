//
//  UserServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//
import Foundation


struct UserServiceRequest {
    struct FetchUsers: Encodable {
        // Query parameters can be added here if needed
    }
    
    struct FetchUser: Encodable {
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as id is used in the URL path
        }
    }
    
    struct CreateUser: Encodable {
        let name: String
        let email: String
        let password: String
        let role: String?
        let phoneNumber: String?
        let address: String?
        let profileImage: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case email
            case password
            case role
            case phoneNumber = "phone_number"
            case address
            case profileImage = "profile_image"
        }
    }
    
    struct UpdateUser: Encodable {
        let id: Int
        let name: String?
        let email: String?
        let password: String?
        let role: String?
        let phoneNumber: String?
        let address: String?
        let profileImage: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case email
            case password
            case role
            case phoneNumber = "phone_number"
            case address
            case profileImage = "profile_image"
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct DeleteUser: Encodable {
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as id is used in the URL path
        }
    }
    
    struct ChangeEmail: Encodable {
        let currentPassword: String
        let newEmail: String
        let newEmailConfirmation: String
        
        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newEmail = "new_email"
            case newEmailConfirmation = "new_email_confirmation"
        }
    }
    
    struct FetchNotificationSettings: Encodable {
        // No parameters needed for this GET request
    }
    
    struct FetchUserDevices: Encodable {
        // No parameters needed for this GET request
    }
    
    struct ResendEmailLoginCode: Encodable {
        let code: String
        
        func asParameters() -> [String: Any] {
            return ["code": code]
        }
    }
    
    struct EmailLoginLink: Encodable {
        let code: String
        let password: String
        let confirmPassword: String
        
        enum CodingKeys: String, CodingKey {
            case code
            case password
            case confirmPassword = "confirm_password"
        }
        
        func asParameters() -> [String: Any] {
            return [
                "code": code,
                "password": password,
                "confirm_password": confirmPassword
            ]
        }
    }
    
    struct SendEmailLoginCode: Encodable {
        let email: String
        
        func asParameters() -> [String: Any] {
            return ["email": email]
        }
    }
    
    struct AppleLoginLink: Encodable {
        let code: String
        
        func asParameters() -> [String: Any] {
            return ["code": code]
        }
    }
    
    struct FetchUserCompanies: Encodable {
        let userId: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // userId is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as userId is used in the URL path
        }
    }
    
    struct ChangePassword: Encodable {
        let userId: Int
        let currentPassword: String
        let newPassword: String
        let newPasswordConfirmation: String
        
        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newPassword = "new_password"
            case newPasswordConfirmation = "new_password_confirmation"
            // userId is not encoded as it's used in the URL path
        }
    }
    
    struct UpdateUserProfile: Encodable {
        let userId: Int
        let firstName: String?
        let lastName: String?
        let phoneNumber: String?
        let pinCode: String?
        let idCard: String?
        let lineAccessToken: String?
        let notificationLanguage: String?
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case phoneNumber = "phone_number"
            case pinCode = "pin_code"
            case idCard = "id_card"
            case lineAccessToken = "line_access_token"
            case notificationLanguage = "notification_language"
            // userId is not encoded as it's used in the URL path
        }
    }
    
    struct FetchUserDetail: Encodable {
        let userId: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // userId is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as userId is used in the URL path
        }
    }
} 