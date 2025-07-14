//
//  GuestRegisterCardServiceRequest.swift
//  YourProject
//
//  Created by AI Assistant
//

import Foundation

struct GuestRegisterCardServiceRequest {
    // MARK: - Type Aliases
    typealias FetchById = ByID
    typealias DeleteGuestRegisterCard = ByID
    typealias UpdateGuestRegisterCard = UpdateRequest
    typealias AcceptPdpa = ByID
    typealias AcceptRules = ByID
    typealias UploadSignature = ByID
    
    struct ByID { let id: Int }
    
    // MARK: - Enums
    enum SortedBy: String {
        case id = "ID"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    // MARK: - Request Structures
    struct FetchGuestRegisterCards: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
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
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchByGuest: Encodable {
        let hotelId: Int
        let customerId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case customerId = "customer_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(customerId, forKey: .customerId)
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
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchByReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(reservationId, forKey: .reservationId)
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
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let period: PeriodDate
        let page: Int?
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
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
            try container.encode(period.start.toDateString(dateFormat), forKey: .startDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endDate)
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
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
    }
    
    struct UpdateRequest: Encodable {
        let id: Int
        let purposeOfVisit: GuestRegisterCard.PurposeOfVisit?
        let fromAddress: String?
        let fromCountry: String?
        let nextAddress: String?
        let nextCountry: String?
        let remark: String?
        
        enum CodingKeys: String, CodingKey {
            case purposeOfVisit = "purpose_of_visit"
            case fromAddress = "from_address"
            case fromCountry = "from_country"
            case nextAddress = "next_address"
            case nextCountry = "next_country"
            case remark
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let purposeOfVisit = purposeOfVisit {
                try container.encode(purposeOfVisit.rawValue, forKey: .purposeOfVisit)
            }
            try container.encodeIfPresent(fromAddress, forKey: .fromAddress)
            try container.encodeIfPresent(fromCountry, forKey: .fromCountry)
            try container.encodeIfPresent(nextAddress, forKey: .nextAddress)
            try container.encodeIfPresent(nextCountry, forKey: .nextCountry)
            try container.encodeIfPresent(remark, forKey: .remark)
        }
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
} 