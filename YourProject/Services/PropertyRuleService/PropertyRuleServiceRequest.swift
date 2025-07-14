//
//  PropertyRuleServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct PropertyRuleServiceRequest {
    
    struct ByHotelID {
        let hotelId: Int
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            dict["hotel_id"] = hotelId
            return dict
        }
    }

    typealias FetchPropertyRuleContent = ByHotelID
    typealias FetchPropertyRulePdfURLs = ByHotelID
    typealias FetchPropertyRuleHTMLURLs = ByHotelID    

    struct UpdatePropertyRuleContent: Encodable {
        let hotelId: Int
        let thContent: String?
        let enContent: String?
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case thContent = "rules_th"
            case enContent = "rules_en"            
        }
    }
}
