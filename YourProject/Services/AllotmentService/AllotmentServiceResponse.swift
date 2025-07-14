//
//  AllotmentServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import Foundation

struct AllotmentServiceResponse {
    
    struct AllotmentMonth: Codable {
        let month: Date
        let allotments: UnitTypeAllotments
        
        init(month: Date, 
        allotments: UnitTypeAllotments) {
            self.month = month
            self.allotments = allotments
        }
                
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            month = try container.decode(String.self, forKey: .month).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMM)
            let unitTypeAllotments = try container.decode([UnitTypeAllotment].self, forKey: .allotments)
            allotments = UnitTypeAllotments(array: unitTypeAllotments)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(month.toDateString(FormConfig.DateFormat.yyyyMM), forKey: .month)
            try container.encode(allotments, forKey: .allotments)
        }
        
        enum CodingKeys: String, CodingKey {
            case month
            case allotments
        }
    }
   
}
