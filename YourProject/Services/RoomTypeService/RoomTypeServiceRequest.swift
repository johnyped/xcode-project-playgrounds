//
//  RoomTypeServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation


struct RoomTypeServiceRequest {

    typealias FetchRoomType = ById
    typealias DeleteRoomType = ById

    struct ById {
        let id: Int
    }

    struct FetchRoomTypes: Encodable {
        let hotelId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
        }
    }
    
    struct CreateRoomType: Encodable {
        let hotelId: Int
        let name: String
        let baseRate: Double
        let baseGuestNumber: Int
        let extraBedRate: Double?
        let extraGuestRate: Double?
        let maxExtraBedNumber: Int?
        let maxExtraGuestNumber: Int?
        let limitedNumberOfCmUnits: Int?
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case baseRate = "base_rate"
            case baseGuestNumber = "base_guest_number"
            case extraBedRate = "extra_bed_rate"
            case extraGuestRate = "extra_guest_rate"
            case maxExtraBedNumber = "max_extra_bed_number"
            case maxExtraGuestNumber = "max_extra_guest_number"
            case limitedNumberOfCmUnits = "limited_number_of_cm_units"
            case description
        }

        //encode to json
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(name, forKey: .name)
            try container.encode(String(baseRate), forKey: .baseRate)
            try container.encode(baseGuestNumber, forKey: .baseGuestNumber)
            try container.encodeIfPresent(extraBedRate != nil ? extraBedRate!.toString() : nil, forKey: .extraBedRate)
            try container.encodeIfPresent(extraGuestRate != nil ? extraGuestRate!.toString() : nil, forKey: .extraGuestRate)
            try container.encode(maxExtraBedNumber, forKey: .maxExtraBedNumber)
            try container.encode(maxExtraGuestNumber, forKey: .maxExtraGuestNumber)
            try container.encode(limitedNumberOfCmUnits, forKey: .limitedNumberOfCmUnits)
            try container.encode(description, forKey: .description)
            // Skip encoding data dictionary for now as it requires special handling
        }
    }
    
    struct UpdateRoomType: Encodable {
        let id: Int
        let name: String?
        let baseRate: Double?
        let baseGuestNumber: Int?
        let extraBedRate: Double?
        let extraGuestRate: Double?
        let maxExtraBedNumber: Int?
        let maxExtraGuestNumber: Int?
        let limitedNumberOfCmUnits: Int?
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case baseRate = "base_rate"
            case baseGuestNumber = "base_guest_number"
            case extraBedRate = "extra_bed_rate"
            case extraGuestRate = "extra_guest_rate"
            case maxExtraBedNumber = "max_extra_bed_number"
            case maxExtraGuestNumber = "max_extra_guest_number"
            case limitedNumberOfCmUnits = "limited_number_of_cm_units"
            case description
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(baseRate != nil ? String(baseRate!) : nil, forKey: .baseRate)
            try container.encodeIfPresent(baseGuestNumber, forKey: .baseGuestNumber)
            try container.encodeIfPresent(extraBedRate != nil ? extraBedRate!.toString() : nil, forKey: .extraBedRate)
            try container.encodeIfPresent(extraGuestRate != nil ? extraGuestRate!.toString() : nil, forKey: .extraGuestRate)
            try container.encodeIfPresent(maxExtraBedNumber, forKey: .maxExtraBedNumber)
            try container.encodeIfPresent(maxExtraGuestNumber, forKey: .maxExtraGuestNumber)
            try container.encodeIfPresent(limitedNumberOfCmUnits, forKey: .limitedNumberOfCmUnits)
            try container.encodeIfPresent(description, forKey: .description)
            // Skip encoding data dictionary for now as it requires special handling
        }
    }

    struct UpdateRoomTypesOrder: Encodable {
        let hotelId: Int
        let roomTypeOrders: [RoomTypeOrder]
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case roomTypeOrders = "room_type_orders"
        }
        
        struct RoomTypeOrder: Encodable {
            let roomTypeId: Int
            let order: Int
            
            enum CodingKeys: String, CodingKey {
                case roomTypeId = "room_type_id"
                case order
            }
        }
    }
    
} 
