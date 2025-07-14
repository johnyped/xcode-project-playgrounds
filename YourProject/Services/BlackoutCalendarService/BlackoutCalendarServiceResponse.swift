//
//  BlackoutCalendarServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import Foundation

struct BlackoutCalendarServiceResponse {
       
    struct BlackoutUnitMonth: Codable {
        let month: Date
        let blackoutUnits: [BlackoutUnit]
        
        enum CodingKeys: String, CodingKey {
            case month
            case blackoutUnits = "blackout_units"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMM
            month = try container.decode(String.self, forKey: .month).tryToDate(dateFormat)
            blackoutUnits = (try? container.decode([BlackoutUnit].self, forKey: .blackoutUnits)) ?? []
        }
        
        init(month: Date,
             blackoutUnits: [BlackoutUnit] = []) {
            self.month = month
            self.blackoutUnits = blackoutUnits
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMM
            try container.encode(month.toDateString(dateFormat), forKey: .month)
            try container.encode(blackoutUnits, forKey: .blackoutUnits)
        }
    }


    /* Example JSON:
    {
        "month": "2024-05",
        "blackout_units": [
            {
                "id": 172,
                "unitable_id": 620,
                "unitable_type": "Room",
                "start_date": "2024-05-29",
                "end_date": "2024-05-30",
                "removes_date": null,
                "note": "",
                "emoji": null,
                "quantity": 1,
                "created_at": "2024-05-29T06:49:07.734+07:00",
                "updated_at": "2024-05-29T06:49:07.734+07:00",
                "hotel_id": 105
            }
        ]
    }
    */
    
}
