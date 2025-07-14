//
//  CMBooking.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMBooking: Codable {
    
    let id: Int
    
    let hotelId: Int
    let hmsUnitType: Self.ReservableType
    let hmsUnitId: Int
    let firstNight: Date
    let lastNight: Date

    var period: PeriodDate {
        .init(start: firstNight,
              end: lastNight.getTomorrowDate() ?? lastNight)
    }
    
    let cmBookID: String
    let cmRoomId: String
    let cmStatus: CMBookingRaw.Status
    let raw: CMBookingRaw
    
    let createdAt: Date
    let updatedAt: Date
    
    let hmsReservationID: Int?
    
    var unitCount: Int {
        raw.roomCount
    }
    
    init(id: Int,
         hotelId: Int,
         hmsUnitType: ReservableType,
         hmsUnitId: Int,
         firstNight: Date,
         lastNight: Date,
         cmBookID: String,
         cmRoomId: String,
         cmStatus: CMBookingRaw.Status,
         raw: CMBookingRaw,
         hmsReservationID: Int?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.hotelId = hotelId
        self.hmsUnitType = hmsUnitType
        self.hmsUnitId = hmsUnitId
        self.firstNight = firstNight
        self.lastNight = lastNight
        self.cmBookID = cmBookID
        self.cmRoomId = cmRoomId
        self.cmStatus = cmStatus
        self.raw = raw
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hmsReservationID = hmsReservationID
    }
    
    //decode
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        hotelId = try values.decode(Int.self, forKey: .hotelId)
        hmsUnitType = try values.decode(Self.ReservableType.self, forKey: .hmsUnitType)
        hmsUnitId = try values.decode(Int.self, forKey: .hmsUnitId)
        
        cmBookID = try values.decode(String.self, forKey: .cmBookID)
        cmRoomId = try values.decode(String.self, forKey: .cmRoomId)
        cmStatus = try values.decode(CMBookingRaw.Status.self, forKey: .cmStatus)
        raw = try values.decode(CMBookingRaw.self, forKey: .raw)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        firstNight = try values.decode(String.self, forKey: .firstNight).tryToDate(dateFormat) 
        lastNight = try values.decode(String.self, forKey: .lastNight).tryToDate(dateFormat) 
        
        createdAt = try values.decode(String.self, forKey: .createdAt).tryToDate(FormConfig.DateFormat.datetimeISO)
        updatedAt = try values.decode(String.self, forKey: .updatedAt).tryToDate(FormConfig.DateFormat.datetimeISO)
        
        hmsReservationID = try values.decodeIfPresent(Int.self, forKey: .hmsReservationID)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(hmsUnitType.rawValue, forKey: .hmsUnitType)
        try container.encode(hmsUnitId, forKey: .hmsUnitId)
        try container.encode(firstNight.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .firstNight)
        try container.encode(lastNight.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .lastNight)
        try container.encode(cmBookID, forKey: .cmBookID)
        try container.encode(cmRoomId, forKey: .cmRoomId)
        try container.encode(cmStatus.rawValue, forKey: .cmStatus)
        try container.encode(raw, forKey: .raw)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
        try container.encodeIfPresent(hmsReservationID, forKey: .hmsReservationID)
    }
    
    // enum
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case hmsUnitType = "hms_unit_type"
        case hmsUnitId = "hms_unit_id"
        case firstNight = "first_night"
        case lastNight = "last_night"
        case cmBookID = "book_id"
        case cmRoomId = "room_id"
        case cmStatus = "status"
        case raw = "raw_response"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hmsReservationID = "hms_reservation_id"
    }
}

extension CMBooking {
    
    enum ReservableType: String, Codable {
        case roomType = "ROOM_TYPE"
    }
   
}
