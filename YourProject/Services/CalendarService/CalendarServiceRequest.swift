//
//  CalendarServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//
import Foundation

struct CalendarServiceRequest {
    
    struct FetchMonth: Encodable {
        let hotelId: Int
        let month: String
        
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
        
        init(hotelId: Int, month: String) {
            self.hotelId = hotelId
            self.month = month
        }
        
        init(hotelId: Int, date: Date) {
            self.hotelId = hotelId
            self.month = date.toDateString(FormConfig.DateFormat.yyyyMM)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(month, forKey: .month)
        }
    }
} 
