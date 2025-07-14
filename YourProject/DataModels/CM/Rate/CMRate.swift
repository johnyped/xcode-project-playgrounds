//
//  CMRate.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMRate: Codable {
    
    let id: Int?
    let cmRoomId: Int
    let cmRateId: String
    let offerId: String
    let name: String
    let description: String
    let minNight: Int
    let maxNight: Int
    let minAdvance: Int
    let maxAdvance: Int
    let strategy: Strategy
    let firstNight: Date
    let lastNight: Date
    
    let roomPrice: RateOption
    let roomPriceGuest: Double
    
    let onePersonPrice: RateOption
    let twoPersonPrice: RateOption
    let extraPersonPrice: RateOption
    let extraChildPrice: RateOption
    
    // weekend , weekday
    let availableDay: DayOption
    let channels: Channels
    let rateCode: RateCodes

    let hmsUnitType: UnitType
    let hmsUnitId: Int
    let hotelId: Int

    let isDefault: Bool
    let code: String?
    let color: String?
    
    let createdAt: Date
    let updatedAt: Date
    
    init(id: Int,
         cmRoomId: Int,
         cmRateId: String,
         offerId: String,
         name: String,
         description: String,
         minNight: Int,
         maxNight: Int,
         minAdvance: Int,
         maxAdvance: Int,
         strategy: Strategy,
         firstNight: Date,
         lastNight: Date,
         roomPrice: RateOption,
         roomPriceGuest: Double,
         onePersonPrice: RateOption,
         twoPersonPrice: RateOption,
         extraPersonPrice: RateOption,
         extraChildPrice: RateOption,
         availableDay: DayOption,
         channels: Channels,
         rateCode: RateCodes,
         hmsUnitType: UnitType,
         hmsUnitId: Int,
         hotelId: Int,
         isDefault: Bool,
         code: String?,
         color: String?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.cmRoomId = cmRoomId
        self.cmRateId = cmRateId
        self.offerId = offerId
        self.name = name
        self.description = description
        self.minNight = minNight
        self.maxNight = maxNight
        self.minAdvance = minAdvance
        self.maxAdvance = maxAdvance
        self.strategy = strategy
        self.firstNight = firstNight
        self.lastNight = lastNight
        self.roomPrice = roomPrice
        self.roomPriceGuest = roomPriceGuest
        self.onePersonPrice = onePersonPrice
        self.twoPersonPrice = twoPersonPrice
        self.extraPersonPrice = extraPersonPrice
        self.extraChildPrice = extraChildPrice
        self.availableDay = availableDay
        self.channels = channels
        self.rateCode = rateCode
        self.hmsUnitType = hmsUnitType
        self.hmsUnitId = hmsUnitId
        self.hotelId = hotelId
        self.isDefault = isDefault
        self.code = code
        self.color = color
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    //decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        cmRoomId = try container.decode(Int.self, forKey: .cmRoomId)
        cmRateId = try container.decode(String.self, forKey: .cmRateId)
        offerId = try container.decode(String.self, forKey: .offerId)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        minNight = try container.decode(Int.self, forKey: .minNight)
        maxNight = try container.decode(Int.self, forKey: .maxNight)
        minAdvance = try container.decode(Int.self, forKey: .minAdvance)
        maxAdvance = try container.decode(Int.self, forKey: .maxAdvance)
        strategy = try container.decode(Strategy.self, forKey: .strategy)

        let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
        firstNight = try container.decode(String.self, forKey: .firstNight).tryToDate(yyyyMMdd)
        lastNight = try container.decode(String.self, forKey: .lastNight).tryToDate(yyyyMMdd)

        let roomPriceRate = try container.decode(String.self, forKey: .roomPrice).tryToDouble()
        let roomPriceEnable = try container.decode(Bool.self, forKey: .roomPriceEnable)
        self.roomPrice = RateOption(enable: roomPriceEnable,
                                    rate: roomPriceRate)

        self.roomPriceGuest = try container.decode(String.self, forKey: .roomPriceGuest).tryToDouble()

        let onePersonPriceRate = try container.decode(String.self, forKey: .onePersonPrice).tryToDouble()
        let onePersonPriceEnable = try container.decode(Bool.self, forKey: .onePersonPriceEnable)
        self.onePersonPrice = RateOption(enable: onePersonPriceEnable,
                                         rate: onePersonPriceRate)

        let twoPersonPriceRate = try container.decode(String.self, forKey: .twoPersonPrice).tryToDouble()
        let twoPersonPriceEnable = try container.decode(Bool.self, forKey: .twoPersonPriceEnable)
        self.twoPersonPrice = RateOption(enable: twoPersonPriceEnable,
                                         rate: twoPersonPriceRate)

        let extraPersonPriceRate = try container.decode(String.self, forKey: .extraPersonPrice).tryToDouble()
        let extraPersonPriceEnable = try container.decode(Bool.self, forKey: .extraPersonPriceEnable)
        self.extraPersonPrice = RateOption(enable: extraPersonPriceEnable,
                                          rate: extraPersonPriceRate)

        let extraChildPriceRate = try container.decode(String.self, forKey: .extraChildPrice).tryToDouble()
        let extraChildPriceEnable = try container.decode(Bool.self, forKey: .extraChildPriceEnable)
        self.extraChildPrice = RateOption(enable: extraChildPriceEnable,
                                          rate: extraChildPriceRate)

        self.availableDay = try DayOption(from: decoder)
        self.channels = try container.decode(Channels.self, forKey: .channel)
        self.rateCode = try container.decode(RateCodes.self, forKey: .rateCode)

        self.hmsUnitType = try container.decode(UnitType.self, forKey: .hmsUnitType)
        self.hmsUnitId = try container.decode(Int.self, forKey: .hmsUnitId)
        self.hotelId = try container.decode(Int.self, forKey: .hotelId)

        self.isDefault = try container.decode(Bool.self, forKey: .isDefault)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        
        let isoDateFormat = FormConfig.DateFormat.datetimeISO
        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(isoDateFormat)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(isoDateFormat)
    }

    //encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(cmRoomId, forKey: .cmRoomId)
        try container.encode(cmRateId, forKey: .cmRateId)
        try container.encode(offerId, forKey: .offerId)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(minNight, forKey: .minNight)
        try container.encode(maxNight, forKey: .maxNight)
        try container.encode(minAdvance, forKey: .minAdvance)
        try container.encode(maxAdvance, forKey: .maxAdvance)
        try container.encode(strategy, forKey: .strategy)
        
        let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
        try container.encode(firstNight.toDateString(yyyyMMdd), forKey: .firstNight)
        try container.encode(lastNight.toDateString(yyyyMMdd), forKey: .lastNight)
        
        try container.encode(roomPrice.rate.toString(), forKey: .roomPrice)
        try container.encode(roomPrice.enable, forKey: .roomPriceEnable)
        try container.encode(roomPriceGuest.toString(), forKey: .roomPriceGuest)
        
        try container.encode(onePersonPrice.rate.toString(), forKey: .onePersonPrice)
        try container.encode(onePersonPrice.enable, forKey: .onePersonPriceEnable)
        
        try container.encode(twoPersonPrice.rate.toString(), forKey: .twoPersonPrice)
        try container.encode(twoPersonPrice.enable, forKey: .twoPersonPriceEnable)
        
        try container.encode(extraPersonPrice.rate.toString(), forKey: .extraPersonPrice)
        try container.encode(extraPersonPrice.enable, forKey: .extraPersonPriceEnable)
        
        try container.encode(extraChildPrice.rate.toString(), forKey: .extraChildPrice)
        try container.encode(extraChildPrice.enable, forKey: .extraChildPriceEnable)
        
        try availableDay.encode(to: encoder)
        try channels.encode(to: encoder)
        try rateCode.encode(to: encoder)
        
        try container.encode(channels, forKey: .channel)
        try container.encode(rateCode, forKey: .rateCode)
        
        try container.encode(hmsUnitType, forKey: .hmsUnitType)
        try container.encode(hmsUnitId, forKey: .hmsUnitId)
        try container.encode(hotelId, forKey: .hotelId)
        
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(code, forKey: .code)
        try container.encode(color, forKey: .color)
        
        let isoDateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(isoDateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(isoDateFormat), forKey: .updatedAt)
    }

}

extension CMRate {

    enum CodingKeys: String, CodingKey {
        case id
        case cmRoomId = "cm_room_id"
        case cmRateId = "rate_id"
        case offerId = "offer_id"
        case name
        case description
        case minNight = "min_nights"
        case maxNight = "max_nights"
        case minAdvance = "min_advance"
        case maxAdvance = "max_advance"
        case strategy = "strategy"
        case firstNight = "first_night"
        case lastNight = "last_night"
        case roomPrice = "room_price"

        case roomPriceEnable = "room_price_enable"
        case roomPriceGuest = "room_price_guests"
        case onePersonPrice = "one_person_price"
        case onePersonPriceEnable = "one_person_price_enable"
        case twoPersonPrice = "two_people_price"
        case twoPersonPriceEnable = "two_people_price_enable"
        case extraPersonPrice = "extra_person_price"
        case extraPersonPriceEnable = "extra_person_price_enable"
        case extraChildPrice = "extra_child_price"
        case extraChildPriceEnable = "extra_child_price_enable"

        case hmsUnitType = "hms_unit_type"
        case hmsUnitId = "hms_unit_id"
        case hotelId = "hotel_id"

        case channel = "channel"
        case rateCode = "rate_code"
        case pinned = "pinned"

        case isDefault = "is_default"
        case code = "code"
        case color = "color"

        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    enum Strategy: Int, Codable {
        case _default = 0
        case doNotAllowLowerPricesOrShorterStays = 1
        case doNotAllowAnyOtherRate = 2
        
        var value: Int { self.rawValue }
    }
    
    enum UnitType: String, Codable {
        case roomType = "ROOM_TYPE"
    }
    
    struct DayOption: Codable {
        let mon: Bool
        let tue: Bool
        let wed: Bool
        let thu: Bool
        let fri: Bool
        let sat: Bool
        let sun: Bool

        init(mon: Bool,
             tue: Bool,
             wed: Bool,
             thu: Bool,
             fri: Bool,
             sat: Bool,
             sun: Bool) {
            self.mon = mon
            self.tue = tue
            self.wed = wed
            self.thu = thu
            self.fri = fri
            self.sat = sat
            self.sun = sun
        }
        
        //decoder
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            mon = try container.decode(Bool.self, forKey: .availableDayMon)
            tue = try container.decode(Bool.self, forKey: .availableDayTue)
            wed = try container.decode(Bool.self, forKey: .availableDayWed)
            thu = try container.decode(Bool.self, forKey: .availableDayThu)
            fri = try container.decode(Bool.self, forKey: .availableDayFri)
            sat = try container.decode(Bool.self, forKey: .availableDaySat)
            sun = try container.decode(Bool.self, forKey: .availableDaySun)
        }

        //encoder
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(mon, forKey: .availableDayMon)
            try container.encode(tue, forKey: .availableDayTue)
            try container.encode(wed, forKey: .availableDayWed)
            try container.encode(thu, forKey: .availableDayThu)
            try container.encode(fri, forKey: .availableDayFri)
            try container.encode(sat, forKey: .availableDaySat)
            try container.encode(sun, forKey: .availableDaySun)
        }

        enum CodingKeys: String, CodingKey {
            case availableDayMon = "can_in_mon"
            case availableDayTue = "can_in_tue"
            case availableDayWed = "can_in_wed"
            case availableDayThu = "can_in_thu"
            case availableDayFri = "can_in_fri"
            case availableDaySat = "can_in_sat"
            case availableDaySun = "can_in_sun"
        }
    }
    
    struct RateOption: Codable {
        let enable: Bool
        let rate: Double
    }
}

/*
json response
{
  "id": 40,
  "cm_room_id": 1,
  "rate_id": "4486488",
  "offer_id": "1",
  "name": "Agoda Rate",
  "description": "",
  "min_nights": 0,
  "max_nights": 365,
  "min_advance": 0,
  "max_advance": 999,
  "strategy": 1,
  "first_night": "2024-04-27",
  "last_night": "2025-04-27",
  "room_price": "620.0",
  "room_price_enable": 1,
  "room_price_guests": "0.0",
  "one_person_price": "0.0",
  "one_person_price_enable": 0,
  "two_people_price": "0.0",
  "two_people_price_enable": 0,
  "extra_person_price": "0.0",
  "extra_person_price_enable": 0,
  "extra_child_price": "0.0",
  "extra_child_price_enable": 0,
  "can_in_mon": 1,
  "can_in_tue": 1,
  "can_in_wed": 1,
  "can_in_thu": 1,
  "can_in_fri": 1,
  "can_in_sat": 1,
  "can_in_sun": 1,
  "hms_unit_type": "ROOM_TYPE",
  "hms_unit_id": 179,
  "channel": {
    "channel000": 0,
    "channel002": 0,
    "channel012": 0,
    "channel014": 0,
    "channel017": 1,
    "channel019": 0,
    "channel023": 0,
    "channel024": 0,
    "channel027": 0,
    "channel030": 0,
    "channel031": 0,
    "channel032": 0,
    "channel033": 0,
    "channel034": 0,
    "channel035": 0,
    "channel036": 0,
    "channel042": 0,
    "channel044": 0,
    "channel046": 0,
    "channel050": 0,
    "channel051": 0,
    "channel052": 0,
    "channel053": 0,
    "channel055": 0,
    "channel056": 0,
    "channel057": 0,
    "channel059": 0,
    "channel063": 0,
    "channel064": 0,
    "channel066": 0,
    "channel072": 0,
    "channel073": 0,
    "channel076": 0,
    "channel078": 0,
    "channel083": 0,
    "channel086": 0,
    "channel087": 0,
    "channel999": 0
  },
  "rate_code": {
    "otaRateCode": "",
    "ctripRateCode": "",
    "hrsdeRateCode": "",
    "odigeoRateCode": "",
    "traviaRateCode": "",
    "feratelRateCode": "",
    "agodacomRateCode": "",
    "bookingcomRateCode": "",
    "expediacomRateCode": "",
    "ostrovokruRateCode": "",
    "tomastravelRateCode": "",
    "hotelbedscomRateCode": "",
    "lateroomscomRateCode": "",
    "travelokacomRateCode": "",
    "lastminutecomRateCode": "",
    "hostelworldcomRateCode": "",
    "travelocitycomRateCode": "",
    "budgetplacescomRateCode": "",
    "tablethotelscomRateCode": ""
  },
  "pinned": false,
  "is_default": false,
  "created_at": "2024-04-27T08:05:12.528+07:00",
  "updated_at": "2024-04-27T08:05:12.528+07:00",
  "code": null,
  "color": null,
  "hotel_id": 105
}
*/
