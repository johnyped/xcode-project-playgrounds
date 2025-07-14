//
//  ReservedDateRange.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Foundation

struct ReservedDateRange: Codable {
    let rooms: [Room]
    
    enum CodingKeys: String, CodingKey {
        case rooms
    }
    
    init(rooms: [Room]) {
        self.rooms = rooms
    }
}

extension ReservedDateRange {
    struct Room: Codable {
        let roomId: Int
        let reservableDateRanges: [Date]
        
        enum CodingKeys: String, CodingKey {
            case roomId = "room_id"
            case reservableDateRanges = "reservable_date_ranges"
        }
        
        init(roomId: Int, reservableDateRanges: [Date]) {
            self.roomId = roomId
            self.reservableDateRanges = reservableDateRanges
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            roomId = try container.decode(Int.self, forKey: .roomId)
            let dateStrings = try container.decode([String].self, forKey: .reservableDateRanges)
            reservableDateRanges = dateStrings.compactMap{ try? $0.tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd) }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(roomId, forKey: .roomId)
            let dateStrings = reservableDateRanges.map { $0.toDateString(FormConfig.DateFormat.yyyyMMdd) }
            try container.encode(dateStrings, forKey: .reservableDateRanges)
        }
    }
}

/*
 {
     "rooms": [
         {
             "room_id": 643,
             "reservable_date_ranges": [
                 "2025-06-27",
                 "2025-06-28",
                 "2025-06-29",
                 "2025-06-30"
             ]
         },
         {
             "room_id": 642,
             "reservable_date_ranges": [
                 "2025-06-27",
                 "2025-06-28",
                 "2025-06-29",
                 "2025-06-30"
             ]
         }
     ]
 }
 */
