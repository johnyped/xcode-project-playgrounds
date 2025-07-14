//
//  PriceCardServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct PriceCardServiceRequest {
    
    typealias FetchPriceCard = ById
    typealias DeletePriceCard = ById
    
    struct ById {
        let id: Int
    }
    
    struct FetchPriceCards {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let roomTypeId: Int?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let roomTypeId = roomTypeId { dict["room_type_id"] = roomTypeId }

            if dict.isEmpty {
                return nil
            }

            return dict
        }
    }
    
    struct FetchPriceCardsByPeriod: Encodable {
        let hotelId: Int
        let startDate: Date
        let endDate: Date
        let channelId: Int?
        let subChannelId: Int?
        let reservableTypeType: String?
        let reservableTypeId: Int?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [
                "hotel_id": hotelId,
                "start_date": startDate.toDateString(FormConfig.DateFormat.ddMMMyyyy),
                "end_date": endDate.toDateString(FormConfig.DateFormat.ddMMMyyyy)
            ]
            if let channelId = channelId { dict["channel_id"] = channelId }
            if let subChannelId = subChannelId { dict["sub_channel_id"] = subChannelId }
            if let reservableTypeType = reservableTypeType { dict["reservable_type_type"] = reservableTypeType }
            if let reservableTypeId = reservableTypeId { dict["reservable_type_id"] = reservableTypeId }
            return dict
        }
    }
    
    struct CreatePriceCard: Encodable {
        let hotelId: Int
        let title: String
        let reservableTypeId: Int
        let reservableTypeType: String
        let price: Double
        let description: String?
        let code: String?
        let color: String?
        let periodTypes: [String]?
        let exceptionDates: [String]?
        let bfIncluded: Bool?
        let bfAdultPrice: Double?
        let bfAdultLimit: Int?
        let bfAdultExtraRate: Double?
        let bfAdultExtraLimit: Int?
        let bfChildPrice: Double?
        let bfChildLimit: Int?
        let bfChildExtraRate: Double?
        let bfChildExtraLimit: Int?
        let startAt: Date
        let endAt: Date
        let channels: [String]?
        let pinned: Bool?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case title
            case reservableTypeId = "reservable_type_id"
            case reservableTypeType = "reservable_type_type"
            case price
            case description
            case code
            case color
            case periodTypes = "period_types"
            case exceptionDates = "exception_dates"
            case bfIncluded = "bf_included"
            case bfAdultPrice = "bf_adult_price"
            case bfAdultLimit = "bf_adult_limit"
            case bfAdultExtraRate = "bf_adult_extra_rate"
            case bfAdultExtraLimit = "bf_adult_extra_limit"
            case bfChildPrice = "bf_child_price"
            case bfChildLimit = "bf_child_limit"
            case bfChildExtraRate = "bf_child_extra_rate"
            case bfChildExtraLimit = "bf_child_extra_limit"
            case startAt = "start_at"
            case endAt = "end_at"
            case channels
            case pinned
        }

        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(title, forKey: .title)
            try container.encode(reservableTypeId, forKey: .reservableTypeId)
            try container.encode(reservableTypeType, forKey: .reservableTypeType)
            try container.encode(price.toString(), forKey: .price)
            try container.encode(description, forKey: .description)
            try container.encode(code, forKey: .code)
            try container.encode(color, forKey: .color)
            try container.encode(periodTypes, forKey: .periodTypes)
            try container.encode(exceptionDates, forKey: .exceptionDates)
            try container.encode(bfIncluded, forKey: .bfIncluded)
            try container.encode(bfAdultPrice?.toString(), forKey: .bfAdultPrice)
            try container.encode(bfAdultLimit, forKey: .bfAdultLimit)
            try container.encode(bfAdultExtraRate?.toString(), forKey: .bfAdultExtraRate)
            try container.encode(bfAdultExtraLimit, forKey: .bfAdultExtraLimit)
            try container.encode(bfChildPrice?.toString(), forKey: .bfChildPrice)
            try container.encode(bfChildLimit, forKey: .bfChildLimit)
            try container.encode(bfChildExtraRate?.toString(), forKey: .bfChildExtraRate)
            try container.encode(bfChildExtraLimit, forKey: .bfChildExtraLimit)
            try container.encode(startAt.toDateString(FormConfig.DateFormat.ddMMMyyyy), forKey: .startAt)
            try container.encode(endAt.toDateString(FormConfig.DateFormat.ddMMMyyyy), forKey: .endAt)
            try container.encode(channels, forKey: .channels)
            try container.encode(pinned, forKey: .pinned)
        }
        
    }
    
    struct UpdatePriceCard: Encodable {
        let id: Int
        let title: String?
        let description: String?
        let reservableTypeId: Int?
        let reservableTypeType: String?
        let price: Double?
        let code: String?
        let color: String?
        let periodTypes: [String]?
        let exceptionDates: [String]?
        let bfIncluded: Bool?
        let bfAdultPrice: Double?
        let bfAdultLimit: Int?
        let bfAdultExtraRate: Double?
        let bfAdultExtraLimit: Int?
        let bfChildPrice: Double?
        let bfChildLimit: Int?
        let bfChildExtraRate: Double?
        let bfChildExtraLimit: Int?
        let startAt: Date?
        let endAt: Date?
        let channels: [String]?
        let pinned: Bool?
        
        enum CodingKeys: String, CodingKey {
            case title
            case description
            case reservableTypeId = "reservable_type_id"
            case reservableTypeType = "reservable_type_type"
            case price
            case code
            case color
            case periodTypes = "period_types"
            case exceptionDates = "exception_dates"
            case bfIncluded = "bf_included"
            case bfAdultPrice = "bf_adult_price"
            case bfAdultLimit = "bf_adult_limit"
            case bfAdultExtraRate = "bf_adult_extra_rate"
            case bfAdultExtraLimit = "bf_adult_extra_limit"
            case bfChildPrice = "bf_child_price"
            case bfChildLimit = "bf_child_limit"
            case bfChildExtraRate = "bf_child_extra_rate"
            case bfChildExtraLimit = "bf_child_extra_limit"
            case startAt = "start_at"
            case endAt = "end_at"
            case channels
            case pinned
            // id is not encoded as it's used in the URL path
        }

        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let title = title {
                try container.encode(title, forKey: .title)
            }
            if let description = description {
                try container.encode(description, forKey: .description)
            }
            if let reservableTypeId = reservableTypeId {
                try container.encode(reservableTypeId, forKey: .reservableTypeId)
            }
            if let reservableTypeType = reservableTypeType {
                try container.encode(reservableTypeType, forKey: .reservableTypeType)
            }
            if let price = price?.toString() {
                try container.encode(price, forKey: .price)
            }
            if let code = code {
                try container.encode(code, forKey: .code)
            }
            if let color = color {
                try container.encode(color, forKey: .color)
            }
            if let periodTypes = periodTypes {
                try container.encode(periodTypes, forKey: .periodTypes)
            }
            if let exceptionDates = exceptionDates {
                try container.encode(exceptionDates, forKey: .exceptionDates)
            }
            if let bfIncluded = bfIncluded {
                try container.encode(bfIncluded, forKey: .bfIncluded)
            }
            if let bfAdultPrice = bfAdultPrice?.toString() {
                try container.encode(bfAdultPrice, forKey: .bfAdultPrice)
            }
            if let bfAdultLimit = bfAdultLimit {
                try container.encode(bfAdultLimit, forKey: .bfAdultLimit)
            }
            if let bfAdultExtraRate = bfAdultExtraRate?.toString() {
                try container.encode(bfAdultExtraRate, forKey: .bfAdultExtraRate)
            }
            if let bfAdultExtraLimit = bfAdultExtraLimit {
                try container.encode(bfAdultExtraLimit, forKey: .bfAdultExtraLimit)
            }
            if let bfChildPrice = bfChildPrice?.toString() {
                try container.encode(bfChildPrice, forKey: .bfChildPrice)
            }
            if let bfChildLimit = bfChildLimit {
                try container.encode(bfChildLimit, forKey: .bfChildLimit)
            }
            if let bfChildExtraRate = bfChildExtraRate?.toString() {
                try container.encode(bfChildExtraRate, forKey: .bfChildExtraRate)
            }
            if let bfChildExtraLimit = bfChildExtraLimit {
                try container.encode(bfChildExtraLimit, forKey: .bfChildExtraLimit)
            }
            if let startAt = startAt?.toDateString(FormConfig.DateFormat.ddMMMyyyy) {
                try container.encode(startAt, forKey: .startAt)
            }
            if let endAt = endAt?.toDateString(FormConfig.DateFormat.ddMMMyyyy) {
                try container.encode(endAt, forKey: .endAt)
            }
            if let channels = channels {
                try container.encode(channels, forKey: .channels)
            }
            if let pinned = pinned {
                try container.encode(pinned, forKey: .pinned)
            }
        }
    }
    
} 
