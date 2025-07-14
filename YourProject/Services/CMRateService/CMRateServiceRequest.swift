//
//  CMRateServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMRateServiceRequest {
    typealias FetchById = ByID
    typealias DeleteCMRate = ByID
    
    struct ByID { let id: Int }
    
    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let startDate: Date
        let endDate: Date
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case startDate = "start_date"
            case endDate = "end_date"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(startDate.toDateString(dateFormat), forKey: .startDate)
            try container.encode(endDate.toDateString(dateFormat), forKey: .endDate)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct FetchByRoomType: Encodable {
        let hotelId: Int
        let roomTypeId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case roomTypeId = "room_type_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(roomTypeId, forKey: .roomTypeId)
            if let page = page, page >= 1 {
                try container.encode(page, forKey: .page)
            }
            if let perPage = perPage {
                try container.encode(perPage.rawValue, forKey: .perPage)
            }
            if let sortedBy = sortedBy {
                try container.encode(sortedBy.rawValue, forKey: .sortedBy)
            }
            if let sortedOrder = sortedOrder {
                try container.encode(sortedOrder.rawValue, forKey: .sortedOrder)
            }
        }
    }
    
    struct CreateCMRate: Encodable {
        let cmRoomId: Int
        let cmRateId: String
        let offerId: String
        let name: String
        let description: String
        let minNight: Int
        let maxNight: Int
        let minAdvance: Int
        let maxAdvance: Int
        let strategy: CMRate.Strategy
        let firstNight: Date
        let lastNight: Date
        let roomPrice: CMRate.RateOption
        let roomPriceGuest: Double
        let onePersonPrice: CMRate.RateOption
        let twoPersonPrice: CMRate.RateOption
        let extraPersonPrice: CMRate.RateOption
        let extraChildPrice: CMRate.RateOption
        let availableDay: CMRate.DayOption
        let channels: CMRate.Channels
        let rateCode: CMRate.RateCodes
        let hmsUnitType: CMRate.UnitType
        let hmsUnitId: Int
        let hotelId: Int
        let isDefault: Bool
        let code: String?
        let color: String?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
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
            case isDefault = "is_default"
            case code = "code"
            case color = "color"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
            
            try container.encode(cmRoomId, forKey: .cmRoomId)
            try container.encode(cmRateId, forKey: .cmRateId)
            try container.encode(offerId, forKey: .offerId)
            try container.encode(name, forKey: .name)
            try container.encode(description, forKey: .description)
            try container.encode(minNight, forKey: .minNight)
            try container.encode(maxNight, forKey: .maxNight)
            try container.encode(minAdvance, forKey: .minAdvance)
            try container.encode(maxAdvance, forKey: .maxAdvance)
            try container.encode(strategy.rawValue, forKey: .strategy)
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
            try container.encode(channels, forKey: .channel)
            try container.encode(rateCode, forKey: .rateCode)
            
            try container.encode(hmsUnitType.rawValue, forKey: .hmsUnitType)
            try container.encode(hmsUnitId, forKey: .hmsUnitId)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(isDefault, forKey: .isDefault)
            try container.encodeIfPresent(code, forKey: .code)
            try container.encodeIfPresent(color, forKey: .color)
        }
    }
    
    struct UpdateCMRate: Encodable {
        let id: Int
        let cmRoomId: Int?
        let cmRateId: String?
        let offerId: String?
        let name: String?
        let description: String?
        let minNight: Int?
        let maxNight: Int?
        let minAdvance: Int?
        let maxAdvance: Int?
        let strategy: CMRate.Strategy?
        let firstNight: Date?
        let lastNight: Date?
        let roomPrice: CMRate.RateOption?
        let roomPriceGuest: Double?
        let onePersonPrice: CMRate.RateOption?
        let twoPersonPrice: CMRate.RateOption?
        let extraPersonPrice: CMRate.RateOption?
        let extraChildPrice: CMRate.RateOption?
        let availableDay: CMRate.DayOption?
        let channels: CMRate.Channels?
        let rateCode: CMRate.RateCodes?
        let hmsUnitType: CMRate.UnitType?
        let hmsUnitId: Int?
        let hotelId: Int?
        let isDefault: Bool?
        let code: String?
        let color: String?
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
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
            case isDefault = "is_default"
            case code = "code"
            case color = "color"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let yyyyMMdd = FormConfig.DateFormat.yyyyMMdd
            
            try container.encodeIfPresent(cmRoomId, forKey: .cmRoomId)
            try container.encodeIfPresent(cmRateId, forKey: .cmRateId)
            try container.encodeIfPresent(offerId, forKey: .offerId)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(minNight, forKey: .minNight)
            try container.encodeIfPresent(maxNight, forKey: .maxNight)
            try container.encodeIfPresent(minAdvance, forKey: .minAdvance)
            try container.encodeIfPresent(maxAdvance, forKey: .maxAdvance)
            
            if let strategy = strategy {
                try container.encode(strategy.rawValue, forKey: .strategy)
            }
            
            if let firstNight = firstNight {
                try container.encode(firstNight.toDateString(yyyyMMdd), forKey: .firstNight)
            }
            
            if let lastNight = lastNight {
                try container.encode(lastNight.toDateString(yyyyMMdd), forKey: .lastNight)
            }
            
            if let roomPrice = roomPrice {
                try container.encode(roomPrice.rate.toString(), forKey: .roomPrice)
                try container.encode(roomPrice.enable, forKey: .roomPriceEnable)
            }
            
            if let roomPriceGuest = roomPriceGuest {
                try container.encode(roomPriceGuest.toString(), forKey: .roomPriceGuest)
            }
            
            if let onePersonPrice = onePersonPrice {
                try container.encode(onePersonPrice.rate.toString(), forKey: .onePersonPrice)
                try container.encode(onePersonPrice.enable, forKey: .onePersonPriceEnable)
            }
            
            if let twoPersonPrice = twoPersonPrice {
                try container.encode(twoPersonPrice.rate.toString(), forKey: .twoPersonPrice)
                try container.encode(twoPersonPrice.enable, forKey: .twoPersonPriceEnable)
            }
            
            if let extraPersonPrice = extraPersonPrice {
                try container.encode(extraPersonPrice.rate.toString(), forKey: .extraPersonPrice)
                try container.encode(extraPersonPrice.enable, forKey: .extraPersonPriceEnable)
            }
            
            if let extraChildPrice = extraChildPrice {
                try container.encode(extraChildPrice.rate.toString(), forKey: .extraChildPrice)
                try container.encode(extraChildPrice.enable, forKey: .extraChildPriceEnable)
            }
            
            if let availableDay = availableDay {
                try availableDay.encode(to: encoder)
            }
            
            try container.encodeIfPresent(channels, forKey: .channel)
            try container.encodeIfPresent(rateCode, forKey: .rateCode)
            
            if let hmsUnitType = hmsUnitType {
                try container.encode(hmsUnitType.rawValue, forKey: .hmsUnitType)
            }
            
            try container.encodeIfPresent(hmsUnitId, forKey: .hmsUnitId)
            try container.encodeIfPresent(hotelId, forKey: .hotelId)
            try container.encodeIfPresent(isDefault, forKey: .isDefault)
            try container.encodeIfPresent(code, forKey: .code)
            try container.encodeIfPresent(color, forKey: .color)
        }
    }
    
    struct ChangeUnitableRequest: Encodable {
        let id: Int
        let hmsUnitType: CMRate.UnitType
        let hmsUnitId: Int
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case hmsUnitType = "unitable_type"
            case hmsUnitId = "unitable_id"
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hmsUnitType.rawValue, forKey: .hmsUnitType)
            try container.encode(hmsUnitId, forKey: .hmsUnitId)
        }
    }
} 
