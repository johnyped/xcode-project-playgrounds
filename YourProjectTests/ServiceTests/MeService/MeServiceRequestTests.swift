//
//  MeServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest

final class MeServiceRequestTests: XCTestCase {
    
    func testUpdateProfileRequest_Encoding() throws {
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
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["first_name"] as? String, "John")
        XCTAssertEqual(json?["last_name"] as? String, "Doe")
        XCTAssertEqual(json?["phone_number"] as? String, "1234567890")
        XCTAssertEqual(json?["pin_code"] as? String, "12345")
        XCTAssertEqual(json?["id_card"] as? String, "1234567890123")
        XCTAssertEqual(json?["line_access_token"] as? String, "line_token_123")
        XCTAssertEqual(json?["notification_language"] as? String, "th")
    }
    
    func testUpdateProfileRequest_EncodingWithNilValues() throws {
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
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["first_name"] as? String, "John")
        // Nil values should be encoded as null or not present
        XCTAssertTrue(json?["last_name"] == nil || json?["last_name"] is NSNull)
        XCTAssertTrue(json?["phone_number"] == nil || json?["phone_number"] is NSNull)
        XCTAssertTrue(json?["pin_code"] == nil || json?["pin_code"] is NSNull)
        XCTAssertTrue(json?["id_card"] == nil || json?["id_card"] is NSNull)
        XCTAssertTrue(json?["line_access_token"] == nil || json?["line_access_token"] is NSNull)
        XCTAssertTrue(json?["notification_language"] == nil || json?["notification_language"] is NSNull)
    }
    
    func testChangeEmailRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.ChangeEmail(
            currentPassword: "current123",
            newEmail: "new@email.com",
            newEmailConfirmation: "new@email.com"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["current_password"] as? String, "current123")
        XCTAssertEqual(json?["new_email"] as? String, "new@email.com")
        XCTAssertEqual(json?["new_email_confirmation"] as? String, "new@email.com")
    }
    
    func testChangePasswordRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.ChangePassword(
            currentPassword: "current123",
            newPassword: "new123",
            newPasswordConfirmation: "new123"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["current_password"] as? String, "current123")
        XCTAssertEqual(json?["new_password"] as? String, "new123")
        XCTAssertEqual(json?["new_password_confirmation"] as? String, "new123")
    }
    
    func testVerificationRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.Verification(pinCode: "12345")
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["pin_code"] as? String, "12345")
    }
    
    func testNotificationSettingsRequest_Encoding() throws {
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
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
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
    }
    
    func testNotificationSettingsRequest_EncodingWithNilValues() throws {
        // Given
        let request = MeServiceRequest.NotificationSettings(
            newCmBooking: true,
            cmBookingWasUpdated: nil,
            cmBookingWasCancelled: false,
            newHmsReservation: nil,
            hmsReservationWasUpdated: true,
            hmsReservationWasCancelled: nil,
            adminBroadcastMessage: false,
            systemBroadcastMessage: nil,
            operatorBroadcastMessage: true,
            lineNewCmBooking: nil,
            lineCmBookingWasUpdated: false,
            lineCmBookingWasCancelled: nil,
            lineNewHmsReservation: true,
            lineHmsReservationWasUpdated: nil,
            lineHmsReservationWasCancelled: false,
            lineAdminBroadcastMessage: nil,
            lineSystemBroadcastMessage: true,
            lineOperatorBroadcastMessage: nil
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["new_cm_booking"] as? Bool, true)
        XCTAssertEqual(json?["cm_booking_was_cancelled"] as? Bool, false)
        XCTAssertEqual(json?["hms_reservation_was_updated"] as? Bool, true)
        XCTAssertEqual(json?["admin_broadcast_message"] as? Bool, false)
        XCTAssertEqual(json?["operator_broadcast_message"] as? Bool, true)
        XCTAssertEqual(json?["line_cm_booking_was_updated"] as? Bool, false)
        XCTAssertEqual(json?["line_new_hms_reservation"] as? Bool, true)
        XCTAssertEqual(json?["line_hms_reservation_was_cancelled"] as? Bool, false)
        XCTAssertEqual(json?["line_system_broadcast_message"] as? Bool, true)
        
        // Nil values should be encoded as null or not present
        XCTAssertTrue(json?["cm_booking_was_updated"] == nil || json?["cm_booking_was_updated"] is NSNull)
        XCTAssertTrue(json?["new_hms_reservation"] == nil || json?["new_hms_reservation"] is NSNull)
        XCTAssertTrue(json?["hms_reservation_was_cancelled"] == nil || json?["hms_reservation_was_cancelled"] is NSNull)
        XCTAssertTrue(json?["system_broadcast_message"] == nil || json?["system_broadcast_message"] is NSNull)
        XCTAssertTrue(json?["line_new_cm_booking"] == nil || json?["line_new_cm_booking"] is NSNull)
        XCTAssertTrue(json?["line_cm_booking_was_cancelled"] == nil || json?["line_cm_booking_was_cancelled"] is NSNull)
        XCTAssertTrue(json?["line_hms_reservation_was_updated"] == nil || json?["line_hms_reservation_was_updated"] is NSNull)
        XCTAssertTrue(json?["line_admin_broadcast_message"] == nil || json?["line_admin_broadcast_message"] is NSNull)
        XCTAssertTrue(json?["line_operator_broadcast_message"] == nil || json?["line_operator_broadcast_message"] is NSNull)
    }
    
    func testEmailLoginResendCodeRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.EmailLoginResendCode(code: "ABC123")
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["code"] as? String, "ABC123")
    }
    
    func testEmailLoginLinkRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.EmailLoginLink(
            code: "ABC123",
            password: "password123",
            confirmPassword: "password123"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["code"] as? String, "ABC123")
        XCTAssertEqual(json?["password"] as? String, "password123")
        XCTAssertEqual(json?["confirm_password"] as? String, "password123")
    }
    
    func testEmailLoginSendCodeRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.EmailLoginSendCode(email: "test@email.com")
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["email"] as? String, "test@email.com")
    }
    
    func testAppleLoginLinkRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.AppleLoginLink(code: "APPLE123")
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["code"] as? String, "APPLE123")
    }
    
    func testAppleLoginUnlinkRequest_Encoding() throws {
        // Given
        let request = MeServiceRequest.AppleLoginUnlink(
            password: "password123",
            confirmPassword: "password123"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["password"] as? String, "password123")
        XCTAssertEqual(json?["confirm_password"] as? String, "password123")
    }
} 