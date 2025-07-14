//
//  CMCalendarServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//
import Foundation

struct CMCalendarServiceResponse {
    struct CMCalendarMonth: Decodable {
        let month: Date
        let reservedItems: CMCalendarItems

        enum CodingKeys: String, CodingKey {
            case month
            case reservedItems = "reserved_items"
        }
        
        init(month: Date,
             reservedItems: CMCalendarItems) {
            self.month = month
            self.reservedItems = reservedItems
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            month = try container.decode(String.self, forKey: .month).tryToDate(FormConfig.DateFormat.yyyyMM)
            reservedItems = try container.decode(CMCalendarItems.self, forKey: .reservedItems)
        }

        /*
         {
             "month": "2024-05",
             "reserved_items": [
                 {
                     "date": "2024-05-13",
                     "reserved_type": "RoomType",
                     "reserved_type_id": 179,
                     "check_in_date": "2024-05-13",
                     "check_out_date": "2024-05-14",
                     "cm_booking_id": 76,
                     "cm_booking_status": "2",
                     "unit_count": 1,
                     "reservation_id": 1081
                 },
                 {
                     "date": "2024-05-31",
                     "reserved_type": "RoomType",
                     "reserved_type_id": 179,
                     "check_in_date": "2024-05-31",
                     "check_out_date": "2024-06-01",
                     "cm_booking_id": 82,
                     "cm_booking_status": "1",
                     "unit_count": 1,
                     "reservation_id": null
                 },
                 {
                     "date": "2024-05-23",
                     "reserved_type": "RoomType",
                     "reserved_type_id": 180,
                     "check_in_date": "2024-05-23",
                     "check_out_date": "2024-05-24",
                     "cm_booking_id": 84,
                     "cm_booking_status": "1",
                     "unit_count": 1,
                     "reservation_id": 1092
                 },
                 {
                     "date": "2024-05-13",
                     "reserved_type": "RoomType",
                     "reserved_type_id": 180,
                     "check_in_date": "2024-05-13",
                     "check_out_date": "2024-05-14",
                     "cm_booking_id": 74,
                     "cm_booking_status": "1",
                     "unit_count": 1,
                     "reservation_id": null
                 },
                 {
                     "date": "2024-05-13",
                     "reserved_type": "RoomType",
                     "reserved_type_id": 179,
                     "check_in_date": "2024-05-13",
                     "check_out_date": "2024-05-14",
                     "cm_booking_id": 75,
                     "cm_booking_status": "2",
                     "unit_count": 1,
                     "reservation_id": 1082
                 },
                 {
                     "date": "2024-05-14",
                     "reserved_type": "RoomType",
                     "reserved_type_id": 179,
                     "check_in_date": "2024-05-14",
                     "check_out_date": "2024-05-15",
                     "cm_booking_id": 79,
                     "cm_booking_status": "2",
                     "unit_count": 1,
                     "reservation_id": 1089
                 }
             ]
         }
         */
    }
}
