//
//  HotelServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct HotelServiceRequest {
    
    struct CreateHotel: Encodable {
        let name: String
        let information: String?
        let address: String?
        let phone: String?
        let geolocation: String?
        let email: String?
        let website: String?
        let workingTime: String?
        let checkInTime: String?
        let checkOutTime: String?
        let note: String?
        let taxNumber: String?
        let policies: String?
        let quote: String?
        let termAndCondition: String?
        let latitude: Double?
        let longitude: Double?
        
        enum CodingKeys: String, CodingKey {
            case name
            case information
            case address
            case phone
            case geolocation
            case email
            case website
            case workingTime = "working_time"
            case checkInTime = "check_in_time"
            case checkOutTime = "check_out_time"
            case note
            case taxNumber = "tax_number"
            case policies
            case quote
            case termAndCondition = "term_and_condition"
            case latitude
            case longitude
        }
    }
    
    struct UpdateHotel: Encodable {
        let hotelId: Int
        let name: String?
        let information: String?
        let address: String?
        let phone: String?
        let geolocation: String?
        let email: String?
        let website: String?
        let workingTime: String?
        let checkInTime: String?
        let checkOutTime: String?
        let note: String?
        let taxNumber: String?
        let policies: String?
        let quote: String?
        let termAndCondition: String?
        let latitude: Double?
        let longitude: Double?
        
        enum CodingKeys: String, CodingKey {
            case name
            case information
            case address
            case phone
            case geolocation
            case email
            case website
            case workingTime = "working_time"
            case checkInTime = "check_in_time"
            case checkOutTime = "check_out_time"
            case note
            case taxNumber = "tax_number"
            case policies
            case quote
            case termAndCondition = "term_and_condition"
            case latitude
            case longitude
            // hotelId is not encoded as it's used in the URL path
        }
    }
    
    struct DeleteHotel: Encodable {
        let hotelId: Int
    }
    
    struct FetchChannelManagerFeature: Encodable {
        let hotelId: Int
    }
    
    struct FetchBeds24Config: Encodable {
        let hotelId: Int
    }
    
    struct UpdateBeds24Config: Encodable {
        let hotelId: Int
        let enabledAutoCancelReservationFromCm: Bool
        
        enum CodingKeys: String, CodingKey {
            case enabledAutoCancelReservationFromCm = "enabled_auto_cancel_reservation_from_cm"
        }
    }
    
    struct FetchColorProfile: Encodable {
        let hotelId: Int
    }
    
    struct UpdateColorProfile: Encodable {
        let hotelId: Int
        let colorProfile: ColorProfile
        
        enum CodingKeys: String, CodingKey {
            case colorProfile = "color_profile"
        }
    }
} 
