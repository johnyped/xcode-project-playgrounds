//
//  ReservationLog.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import Foundation

struct ReservationLog: Codable {
    let id: Int
    let user: User
    let description: String
    let verb: String
    let path: String
    let parameters: Parameters
    let createdAt: Date
    let updatedAt: Date
       
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case description
        case verb
        case path
        case parameters
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int,
         user: User,
         description: String,
         verb: String,
         path: String,
         parameters: Parameters,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.user = user
        self.description = description
        self.verb = verb
        self.path = path
        self.parameters = parameters
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        user = try container.decode(User.self, forKey: .user)
        description = try container.decode(String.self, forKey: .description)
        verb = try container.decode(String.self, forKey: .verb)
        path = try container.decode(String.self, forKey: .path)
        parameters = try container.decode(Parameters.self, forKey: .parameters)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(user, forKey: .user)
        try container.encode(description, forKey: .description)
        try container.encode(verb, forKey: .verb)
        try container.encode(path, forKey: .path)
        try container.encode(parameters, forKey: .parameters)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}

extension ReservationLog {
     struct User: Codable {
        let id: Int
        let firstName: String
        let lastName: String
        let email: String
        let role: String
        let staffRole: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case email
            case role
            case staffRole = "staff_role"
        }
    }
    
    struct Parameters: Codable {
        let contactEmail: String
        let channelId: Int
        let checkOutDate: Date
        let extraAdultNumber: Int
        let hotelId: String
        let otaBookingId: String
        let items: [Item]
        let contactTel: String
        let subChannelId: Int
        
        enum CodingKeys: String, CodingKey {
            case contactEmail = "contact_email"
            case channelId = "channel_id"
            case checkOutDate = "check_out_date"
            case extraAdultNumber = "extra_adult_number"
            case hotelId = "hotel_id"
            case otaBookingId = "ota_booking_id"
            case items
            case contactTel = "contact_tel"
            case subChannelId = "sub_channel_id"
        }
    }
    
    struct Item: Codable {
        let reservableId: Int
        let totalPrice: Int
        let reservableType: String
        let reservedDate: String
        let data: ItemData
        
        enum CodingKeys: String, CodingKey {
            case reservableId = "reservable_id"
            case totalPrice = "total_price"
            case reservableType = "reservable_type"
            case reservedDate = "reserved_date"
            case data
        }
    }
    
    struct ItemData: Codable {
        let extraBedRate: Int
        let extraPersonRate: Int
        let childMealRate: Int
        let adultMealLimit: Int
        let extraAdultMealNumber: Int
        let extraChildMealRate: Int
        let adultMealRate: Int
        let extraPersonNumber: Int
        let priceCardRate: Int
        let extraChildMealNumber: Int
        let extraBedNumber: Int
        let mealIncluded: Bool
        let childMealLimit: Int
        let extraAdultMealRate: Int
        let isCustomRate: Bool
        
        enum CodingKeys: String, CodingKey {
            case extraBedRate = "extra_bed_rate"
            case extraPersonRate = "extra_person_rate"
            case childMealRate = "child_meal_rate"
            case adultMealLimit = "adult_meal_limit"
            case extraAdultMealNumber = "extra_adult_meal_number"
            case extraChildMealRate = "extra_child_meal_rate"
            case adultMealRate = "adult_meal_rate"
            case extraPersonNumber = "extra_person_number"
            case priceCardRate = "price_card_rate"
            case extraChildMealNumber = "extra_child_meal_number"
            case extraBedNumber = "extra_bed_number"
            case mealIncluded = "meal_included"
            case childMealLimit = "child_meal_limit"
            case extraAdultMealRate = "extra_adult_meal_rate"
            case isCustomRate = "is_custom_rate"
        }
    }
}

/*
 [
     {
         "id": 2451,
         "user": {
             "id": 38,
             "first_name": "John2",
             "last_name": "Doe2",
             "email": "test1@email.com",
             "role": "ROLE_SUPPORT_SUPER_ADMIN",
             "staff_role": null
         },
         "named": "reservation.create",
         "verb": "POST",
         "path": "/api/v3/reservations/cm-reservations",
         "parameters": {
             "contact_email": "stongp.580776@guest.booking.com",
             "channel_id": 7,
             "check_out_date": "2024-06-07T00:00:00.000+00:00",
             "extra_adult_number": 0,
             "hotel_id": "105",
             "ota_booking_id": "",
             "items": [
                 {
                     "reservable_id": 625,
                     "total_price": 2160,
                     "reservable_type": "Room",
                     "reserved_date": "2024-06-06",
                     "data": {
                         "extra_bed_rate": 0,
                         "extra_person_rate": 500,
                         "child_meal_rate": 0,
                         "adult_meal_limit": 0,
                         "extra_adult_meal_number": 0,
                         "extra_child_meal_rate": 0,
                         "adult_meal_rate": 0,
                         "extra_person_number": 0,
                         "price_card_rate": 2160,
                         "extra_child_meal_number": 0,
                         "extra_bed_number": 0,
                         "meal_included": false,
                         "child_meal_limit": 0,
                         "extra_adult_meal_rate": 0,
                         "is_custom_rate": true
                     }
                 }
             ],
             "contact_tel": "+66 89 170 3704, ",
             "sub_channel_id": 35,
             "guest_comment": "Approximate time of arrival: between 14:00 and 15:00\r\nFloor preference (if available):\r\nTriple Room - Beach Front: Ground floor\r\nNon Smoking Requested",
             "note": "",
             "adult_number": 2,
             "contact_fullname": "Surasak Tongphonthong",
             "cm_booking_id": 66,
             "check_in_date": "2024-06-06T00:00:00.000+00:00"
         },
         "body": {
             "contact_email": "stongp.580776@guest.booking.com",
             "channel_id": 7,
             "check_out_date": "2024-06-07T00:00:00.000+00:00",
             "extra_adult_number": 0,
             "hotel_id": "105",
             "ota_booking_id": "",
             "items": [
                 {
                     "reservable_id": 625,
                     "total_price": 2160,
                     "reservable_type": "Room",
                     "reserved_date": "2024-06-06",
                     "data": {
                         "extra_bed_rate": 0,
                         "extra_person_rate": 500,
                         "child_meal_rate": 0,
                         "adult_meal_limit": 0,
                         "extra_adult_meal_number": 0,
                         "extra_child_meal_rate": 0,
                         "adult_meal_rate": 0,
                         "extra_person_number": 0,
                         "price_card_rate": 2160,
                         "extra_child_meal_number": 0,
                         "extra_bed_number": 0,
                         "meal_included": false,
                         "child_meal_limit": 0,
                         "extra_adult_meal_rate": 0,
                         "is_custom_rate": true
                     }
                 }
             ],
             "contact_tel": "+66 89 170 3704, ",
             "sub_channel_id": 35,
             "guest_comment": "Approximate time of arrival: between 14:00 and 15:00\r\nFloor preference (if available):\r\nTriple Room - Beach Front: Ground floor\r\nNon Smoking Requested",
             "note": "",
             "adult_number": 2,
             "contact_fullname": "Surasak Tongphonthong",
             "cm_booking_id": 66,
             "check_in_date": "2024-06-06T00:00:00.000+00:00"
         },
         "description": "Add a new reservation from channel manager booking",
         "created_at": "2024-04-13T17:09:11.862+07:00",
         "updated_at": "2024-04-13T17:09:11.862+07:00"
     }
 ]
 */
