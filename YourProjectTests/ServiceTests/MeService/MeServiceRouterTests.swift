//
//  MeServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class MeServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchProfileRequest() throws {
        // Given
        let router = MeServiceRouter.fetchProfile
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/profile")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testUpdateProfileRequest() throws {
        // Given
        let request = MeServiceRequest.UpdateProfile(
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "1234567890",
            pinCode: "12345",
            idCard: "1234567890123",
            lineAccessToken: "line_token_123",
            notificationLanguage: "th"
        )
        let router = MeServiceRouter.updateProfile(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["first_name"] as? String, "John")
            XCTAssertEqual(json?["last_name"] as? String, "Doe")
            XCTAssertEqual(json?["phone_number"] as? String, "1234567890")
            XCTAssertEqual(json?["pin_code"] as? String, "12345")
            XCTAssertEqual(json?["id_card"] as? String, "1234567890123")
            XCTAssertEqual(json?["line_access_token"] as? String, "line_token_123")
            XCTAssertEqual(json?["notification_language"] as? String, "th")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testChangeEmailRequest() throws {
        // Given
        let request = MeServiceRequest.ChangeEmail(
            currentPassword: "current123",
            newEmail: "new@email.com",
            newEmailConfirmation: "new@email.com"
        )
        let router = MeServiceRouter.changeEmail(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/change-email")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["current_password"] as? String, "current123")
            XCTAssertEqual(json?["new_email"] as? String, "new@email.com")
            XCTAssertEqual(json?["new_email_confirmation"] as? String, "new@email.com")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testChangePasswordRequest() throws {
        // Given
        let request = MeServiceRequest.ChangePassword(
            currentPassword: "current123",
            newPassword: "new123",
            newPasswordConfirmation: "new123"
        )
        let router = MeServiceRouter.changePassword(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/change-password")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["current_password"] as? String, "current123")
            XCTAssertEqual(json?["new_password"] as? String, "new123")
            XCTAssertEqual(json?["new_password_confirmation"] as? String, "new123")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testVerificationRequest() throws {
        // Given
        let request = MeServiceRequest.Verification(pinCode: "12345")
        let router = MeServiceRouter.verification(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/verification")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["pin_code"] as? String, "12345")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testFetchDevicesRequest() throws {
        // Given
        let router = MeServiceRouter.fetchDevices
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/devices")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testGetNotificationSettingsRequest() throws {
        // Given
        let router = MeServiceRouter.getNotificationSettings
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/notification-settings")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.get.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testUpdateNotificationSettingsRequest() throws {
        // Given
        let request = MeServiceRequest.NotificationSettings(
            newCmBooking: true,
            cmBookingWasUpdated: false,
            cmBookingWasCancelled: true,
            newHmsReservation: true,
            hmsReservationWasUpdated: false,
            hmsReservationWasCancelled: true,
            adminBroadcastMessage: true,
            systemBroadcastMessage: false,
            operatorBroadcastMessage: true,
            lineNewCmBooking: true,
            lineCmBookingWasUpdated: false,
            lineCmBookingWasCancelled: true,
            lineNewHmsReservation: true,
            lineHmsReservationWasUpdated: false,
            lineHmsReservationWasCancelled: true,
            lineAdminBroadcastMessage: true,
            lineSystemBroadcastMessage: false,
            lineOperatorBroadcastMessage: true
        )
        let router = MeServiceRouter.updateNotificationSettings(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/notification-settings")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["new_cm_booking"] as? Bool, true)
            XCTAssertEqual(json?["cm_booking_was_updated"] as? Bool, false)
            XCTAssertEqual(json?["cm_booking_was_cancelled"] as? Bool, true)
            XCTAssertEqual(json?["new_hms_reservation"] as? Bool, true)
            XCTAssertEqual(json?["hms_reservation_was_updated"] as? Bool, false)
            XCTAssertEqual(json?["hms_reservation_was_cancelled"] as? Bool, true)
            XCTAssertEqual(json?["admin_broadcast_message"] as? Bool, true)
            XCTAssertEqual(json?["system_broadcast_message"] as? Bool, false)
            XCTAssertEqual(json?["operator_broadcast_message"] as? Bool, true)
            XCTAssertEqual(json?["line_new_cm_booking"] as? Bool, true)
            XCTAssertEqual(json?["line_cm_booking_was_updated"] as? Bool, false)
            XCTAssertEqual(json?["line_cm_booking_was_cancelled"] as? Bool, true)
            XCTAssertEqual(json?["line_new_hms_reservation"] as? Bool, true)
            XCTAssertEqual(json?["line_hms_reservation_was_updated"] as? Bool, false)
            XCTAssertEqual(json?["line_hms_reservation_was_cancelled"] as? Bool, true)
            XCTAssertEqual(json?["line_admin_broadcast_message"] as? Bool, true)
            XCTAssertEqual(json?["line_system_broadcast_message"] as? Bool, false)
            XCTAssertEqual(json?["line_operator_broadcast_message"] as? Bool, true)
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testEmailLoginResendCodeRequest() throws {
        // Given
        let request = MeServiceRequest.EmailLoginResendCode(code: "ABC123")
        let router = MeServiceRouter.emailLoginResendCode(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/email-login/resend-code")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["code"] as? String, "ABC123")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testEmailLoginLinkRequest() throws {
        // Given
        let request = MeServiceRequest.EmailLoginLink(
            code: "ABC123",
            password: "password123",
            confirmPassword: "password123"
        )
        let router = MeServiceRouter.emailLoginLink(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/email-login/link")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["code"] as? String, "ABC123")
            XCTAssertEqual(json?["password"] as? String, "password123")
            XCTAssertEqual(json?["confirm_password"] as? String, "password123")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testEmailLoginSendCodeRequest() throws {
        // Given
        let request = MeServiceRequest.EmailLoginSendCode(email: "test@email.com")
        let router = MeServiceRouter.emailLoginSendCode(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/email-login/send-code")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["email"] as? String, "test@email.com")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testAppleLoginLinkRequest() throws {
        // Given
        let request = MeServiceRequest.AppleLoginLink(code: "APPLE123")
        let router = MeServiceRouter.appleLoginLink(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/apple-login/link")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["code"] as? String, "APPLE123")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testAppleLoginUnlinkRequest() throws {
        // Given
        let request = MeServiceRequest.AppleLoginUnlink(
            password: "password123",
            confirmPassword: "password123"
        )
        let router = MeServiceRouter.appleLoginUnlink(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me/apple-login/unlink")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.post.rawValue)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        // Test body
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["password"] as? String, "password123")
            XCTAssertEqual(json?["confirm_password"] as? String, "password123")
        } else {
            XCTFail("Request should have a body")
        }
    }
    
    func testUpdateProfileRequestWithNilValues() throws {
        // Given
        let request = MeServiceRequest.UpdateProfile(
            firstName: "John",
            lastName: nil,
            phoneNumber: nil,
            pinCode: nil,
            idCard: nil,
            lineAccessToken: nil,
            notificationLanguage: nil
        )
        let router = MeServiceRouter.updateProfile(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString,
                       baseURL + "/v4/me")
        XCTAssertEqual(urlRequest.httpMethod,
                       HTTPMethod.put.rawValue)
        
        // Test body with partial data
        if let body = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            XCTAssertEqual(json?["first_name"] as? String, "John")
            // Nil values should be encoded as null or not present
            XCTAssertTrue(json?["last_name"] == nil || json?["last_name"] is NSNull)
            XCTAssertTrue(json?["phone_number"] == nil || json?["phone_number"] is NSNull)
            XCTAssertTrue(json?["pin_code"] == nil || json?["pin_code"] is NSNull)
            XCTAssertTrue(json?["id_card"] == nil || json?["id_card"] is NSNull)
            XCTAssertTrue(json?["line_access_token"] == nil || json?["line_access_token"] is NSNull)
            XCTAssertTrue(json?["notification_language"] == nil || json?["notification_language"] is NSNull)
        } else {
            XCTFail("Request should have a body")
        }
    }
} 