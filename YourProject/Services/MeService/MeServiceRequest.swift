//
//  MeServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct MeServiceRequest {
    
    struct UpdateProfile: Encodable {
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

    struct ChangePassword: Encodable {
        let currentPassword: String
        let newPassword: String
        let newPasswordConfirmation: String

        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newPassword = "new_password"
            case newPasswordConfirmation = "new_password_confirmation"
        }
    }

    struct Verification: Encodable {        
        let pinCode: String

        enum CodingKeys: String, CodingKey {
            case pinCode = "pin_code"
        }
    }

    struct NotificationSettings: Encodable {
        let newCmBooking: Bool?
        let cmBookingWasUpdated: Bool?
        let cmBookingWasCancelled: Bool?

        let newHmsReservation: Bool?
        let hmsReservationWasUpdated: Bool?
        let hmsReservationWasCancelled: Bool?
        
        let adminBroadcastMessage: Bool?
        
        let systemBroadcastMessage: Bool?
        let operatorBroadcastMessage: Bool?

        let lineNewCmBooking: Bool?
        let lineCmBookingWasUpdated: Bool?
        let lineCmBookingWasCancelled: Bool?
        let lineNewHmsReservation: Bool?
        let lineHmsReservationWasUpdated: Bool?
        let lineHmsReservationWasCancelled: Bool?
        let lineAdminBroadcastMessage: Bool?
        let lineSystemBroadcastMessage: Bool?
        let lineOperatorBroadcastMessage: Bool?

        enum CodingKeys: String, CodingKey {
            case newCmBooking = "new_cm_booking"
            case cmBookingWasUpdated = "cm_booking_was_updated"
            case cmBookingWasCancelled = "cm_booking_was_cancelled"
            case newHmsReservation = "new_hms_reservation"
            case hmsReservationWasUpdated = "hms_reservation_was_updated"
            case hmsReservationWasCancelled = "hms_reservation_was_cancelled"
            case adminBroadcastMessage = "admin_broadcast_message"
            case systemBroadcastMessage = "system_broadcast_message"
            case operatorBroadcastMessage = "operator_broadcast_message"
            case lineNewCmBooking = "line_new_cm_booking"
            case lineCmBookingWasUpdated = "line_cm_booking_was_updated"
            case lineCmBookingWasCancelled = "line_cm_booking_was_cancelled"
            case lineNewHmsReservation = "line_new_hms_reservation"
            case lineHmsReservationWasUpdated = "line_hms_reservation_was_updated"
            case lineHmsReservationWasCancelled = "line_hms_reservation_was_cancelled"
            case lineAdminBroadcastMessage = "line_admin_broadcast_message"
            case lineSystemBroadcastMessage = "line_system_broadcast_message"
            case lineOperatorBroadcastMessage = "line_operator_broadcast_message"
        }
    }

    struct EmailLoginResendCode: Encodable {
        let code: String
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
    }

    struct EmailLoginSendCode: Encodable {
        let email: String
    }

    struct AppleLoginLink: Encodable {
        let code: String
    }

    struct AppleLoginUnlink: Encodable {
        let password: String
        let confirmPassword: String
        enum CodingKeys: String, CodingKey {
            case password
            case confirmPassword = "confirm_password"
        }
    }
} 
