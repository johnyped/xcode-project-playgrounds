//  ReservationLogServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//
import Foundation

struct ReservationLogServiceRequest {
    
    struct FetchByReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case reservationId = "reservation_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(reservationId, forKey: .reservationId)
        }
    }
        
} 
