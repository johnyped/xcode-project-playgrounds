//
//  ReservationServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 19/6/2568 BE.
//

struct ReservationServiceResponse {
    
    struct ConfirmationInfo: Codable {
        let createdAt: String?
        let remark: String?
        let url: String?
        
        init(createdAt: String? = nil,
             remark: String? = nil,
             url: String? = nil) {
            self.createdAt = createdAt
            self.remark = remark
            self.url = url
        }
        
        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case remark
            case url
        }
    }
    
}

