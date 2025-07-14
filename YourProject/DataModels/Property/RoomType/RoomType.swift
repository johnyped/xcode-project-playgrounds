//
//  RoomType.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation

enum ReservableType: String, Codable {
    case roomType = "ROOM_TYPE"
}

struct RoomType: Codable {
    let id: Int
    let hotelId: Int
    let order: Int    
    let name: String
    let description: String  

    let baseRate: Double
    let baseGuestNumber: Int
    let extraBedRate: Double
    let extraGuestRate: Double
    let maxExtraBedNumber: Int
    let maxExtraGuestNumber: Int
    let limitedNumberOfCMUnits: Int?
          
    let createdAt: Date
    let updatedAt: Date

    init(id: Int,
         order: Int = 0,
         hotelId: Int,
         name: String,
         description: String = "",
         baseRate: Double,
         baseGuestNumber: Int,
         extraBedRate: Double,
         extraGuestRate: Double,
         maxExtraBedNumber: Int,
         maxExtraGuestNumber: Int,
         limitedNumberOfCmUnits: Int? = nil,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.hotelId = hotelId
        self.order = order
        self.name = name
        self.description = description
        self.baseRate = baseRate
        self.baseGuestNumber = baseGuestNumber
        self.extraBedRate = extraBedRate
        self.extraGuestRate = extraGuestRate
        self.maxExtraBedNumber = maxExtraBedNumber
        self.maxExtraGuestNumber = maxExtraGuestNumber
        self.limitedNumberOfCMUnits = limitedNumberOfCmUnits
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.hotelId = try container.decode(Int.self, forKey: .hotelId)
        self.order = try container.decode(Int.self, forKey: .order)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.baseRate = try container.decode(String.self, forKey: .baseRate).tryToDouble()
        self.baseGuestNumber = try container.decode(Int.self, forKey: .baseGuestNumber)
        self.extraBedRate = try container.decode(String.self, forKey: .extraBedRate).tryToDouble()
        self.extraGuestRate = try container.decode(String.self, forKey: .extraGuestRate).tryToDouble()
        self.maxExtraBedNumber = try container.decode(Int.self, forKey: .maxExtraBedNumber)
        self.maxExtraGuestNumber = try container.decode(Int.self, forKey: .maxExtraGuestNumber)
        self.limitedNumberOfCMUnits = try container.decode(Int?.self, forKey: .limitedNumberOfCMUnits)
        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(order, forKey: .order)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(baseRate.toString(), forKey: .baseRate)
        try container.encode(baseGuestNumber, forKey: .baseGuestNumber)
        try container.encode(extraBedRate.toString(), forKey: .extraBedRate)
        try container.encode(extraGuestRate.toString(), forKey: .extraGuestRate)
        try container.encode(maxExtraBedNumber, forKey: .maxExtraBedNumber)
        try container.encode(maxExtraGuestNumber, forKey: .maxExtraGuestNumber)
        try container.encode(limitedNumberOfCMUnits, forKey: .limitedNumberOfCMUnits)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .updatedAt)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case order
        case name
        case description
        case baseRate = "base_rate"
        case baseGuestNumber = "base_guest_number"
        case extraBedRate = "extra_bed_rate"
        case extraGuestRate = "extra_guest_rate"
        case maxExtraBedNumber = "max_extra_bed_number"
        case maxExtraGuestNumber = "max_extra_guest_number"
        case limitedNumberOfCMUnits = "limited_number_of_cm_units"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
}

extension RoomType {
    
    enum FilterBy {
        case id(id: Int)
        case ids(ids: [Int])
        //case roomStatus(status: Room.Status)
                
    }
    
    enum SortBy {
        case id
        case name
        case baseRate
        case createdAt
        case updatedAt
    }
}

/*
[
    {
        "id": 179,
        "name": "Duluxe Room",
        "base_rate": "520.00",
        "base_guest_number": 30,
        "extra_bed_rate": "500.00",
        "extra_guest_rate": "200.00",
        "max_extra_bed_number": 1,
        "max_extra_guest_number": 1,
        "limited_number_of_cm_units": null,
        "description": "test description",
        "tags": [],
        "data": null,
        "order": 0,
        "created_at": "2019-11-28T11:08:41.259+07:00",
        "updated_at": "2024-05-23T14:12:58.166+07:00",
        "hotel_id": 105
    }
 
 {
         "id": 182,
         "name": "uu",
         "base_rate": "100.0",
         "base_guest_number": 2,
         "extra_bed_rate": "200.0",
         "extra_guest_rate": "300.0",
         "max_extra_bed_number": 1,
         "max_extra_guest_number": 1,
         "limited_number_of_cm_units": null,
         "description": "",
         "tags": [],
         "data": null,
         "order": 2,
         "created_at": "2021-01-03T13:06:56.259+07:00",
         "updated_at": "2024-06-13T18:26:32.377+07:00",
         "hotel_id": 105
     }
 */
