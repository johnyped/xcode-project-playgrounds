//  AllotmentServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 7/1/2568 BE.
//

import Foundation

struct AllotmentServiceRequest {
    
    struct FetchByUnitType: Encodable {
        let hotelId: Int
        let unitTypeId: Int
        let unitType: ReservableType
        let period: PeriodDate
        let unitIds: [Int]?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case unitTypeId = "unit_type_id"
            case unitType = "unit_type"
            case startDate = "start_date"
            case endDate = "end_date"
            case unitIds = "unit_ids"            
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(unitTypeId, forKey: .unitTypeId)
            try container.encode(unitType.rawValue, forKey: .unitType)
            try container.encode(period.start.toDateString(dateFormat), forKey: .startDate)
            try container.encode(period.end.toDateString(dateFormat), forKey: .endDate)
            try container.encodeIfPresent(unitIds, forKey: .unitIds)            
        }
    }
    
    struct FetchByMonth: Encodable {
        let hotelId: Int
        let month: Date
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case month           
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMM
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(month.toDateString(dateFormat), forKey: .month)
            
        }
    }
} 
