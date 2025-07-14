//  BlackoutCalendarServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//
import Foundation

struct BlackoutCalendarServiceRequest {
    
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

        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(month.toDateString(FormConfig.DateFormat.yyyyMM), forKey: .month)
        }

        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case month
        }

    }
    
} 