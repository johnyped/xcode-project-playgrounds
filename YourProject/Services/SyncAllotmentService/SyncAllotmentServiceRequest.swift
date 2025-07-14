//  SyncAllotmentServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//
import Foundation

struct SyncAllotmentServiceRequest {
    typealias FetchById = ByID
    
    struct ByID { let id: Int }
  
    struct CreateSyncAllotment: Encodable {
        let hotelId: Int
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
        }
    }
    
} 
