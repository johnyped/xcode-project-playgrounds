//
//  AllotmentMonth.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Foundation

struct UnitTypeAllotment: Codable {
    let reservedType: ReservedType
    let reservedTypeId: Int
    let date: Date
    
    let hmsUnselectedReservedCount: Int
    let hmsSelectedReservedCount: Int
    let hmsReservedCount: Int
    let cmReservedCount: Int
    let availableUnitCount: Int
    let unavailableUnitCount: Int
    let blackoutUnitCount: Int
    let totalUnits: Int
    
    enum CodingKeys: String, CodingKey {
        case reservedType = "reserved_type"
        case reservedTypeId = "reserved_type_id"
        case date
        case hmsUnselectedReservedCount = "hms_unselected_reserved_count"
        case hmsSelectedReservedCount = "hms_selected_reserved_count"
        case hmsReservedCount = "hms_reserved_count"
        case cmReservedCount = "cm_reserved_count"
        case availableUnitCount = "available_unit_count"
        case unavailableUnitCount = "unavailable_unit_count"
        case blackoutUnitCount = "blackout_unit_count"
        case totalUnits = "total_units"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reservedType = try container.decode(ReservedType.self, forKey: .reservedType)
        reservedTypeId = try container.decode(Int.self, forKey: .reservedTypeId)
        
        let dataFormat = FormConfig.DateFormat.yyyyMMdd
        date = try container.decode(String.self, forKey: .date).tryToDate(dataFormat)
        
        hmsUnselectedReservedCount = try container.decode(Int.self, forKey: .hmsUnselectedReservedCount)
        hmsSelectedReservedCount = try container.decode(Int.self, forKey: .hmsSelectedReservedCount)
        hmsReservedCount = try container.decode(Int.self, forKey: .hmsReservedCount)
        cmReservedCount = try container.decode(Int.self, forKey: .cmReservedCount)
        availableUnitCount = try container.decode(Int.self, forKey: .availableUnitCount)
        unavailableUnitCount = try container.decode(Int.self, forKey: .unavailableUnitCount)
        blackoutUnitCount = try container.decode(Int.self, forKey: .blackoutUnitCount)
        totalUnits = try container.decode(Int.self, forKey: .totalUnits)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(reservedType.rawValue, forKey: .reservedType)
        try container.encode(reservedTypeId, forKey: .reservedTypeId)
        let dataFormat = FormConfig.DateFormat.yyyyMMdd
        try container.encode(date.toDateString(dataFormat), forKey: .date)
        
        try container.encode(hmsUnselectedReservedCount, forKey: .hmsUnselectedReservedCount)
        try container.encode(hmsSelectedReservedCount, forKey: .hmsSelectedReservedCount)
        try container.encode(hmsReservedCount, forKey: .hmsReservedCount)
        try container.encode(cmReservedCount, forKey: .cmReservedCount)
        try container.encode(availableUnitCount, forKey: .availableUnitCount)
        try container.encode(unavailableUnitCount, forKey: .unavailableUnitCount)
        try container.encode(blackoutUnitCount, forKey: .blackoutUnitCount)
        try container.encode(totalUnits, forKey: .totalUnits)
    }
}

extension UnitTypeAllotment {
    enum ReservedType: String, Codable {
        case roomType = "ROOM_TYPE"
        case room = "ROOM"
    }
}
/*
 {
     "month": "2025-07",
     "allotments": [
         {
             "reserved_type": "RoomType",
             "reserved_type_id": 179,
             "date": "2025-07-04",
             "hms_unselected_reserved_count": 0,
             "hms_selected_reserved_count": 0,
             "hms_reserved_count": 0,
             "cm_reserved_count": 0,
             "available_unit_count": 4,
             "unavailable_unit_count": 0,
             "blackout_unit_count": 0,
             "total_units": 4
         },
         {
             "reserved_type": "RoomType",
             "reserved_type_id": 179,
             "date": "2025-07-05",
             "hms_unselected_reserved_count": 0,
             "hms_selected_reserved_count": 0,
             "hms_reserved_count": 0,
             "cm_reserved_count": 0,
             "available_unit_count": 4,
             "unavailable_unit_count": 0,
             "blackout_unit_count": 0,
             "total_units": 4
         },
         {
             "reserved_type": "RoomType",
             "reserved_type_id": 179,
             "date": "2025-07-06",
             "hms_unselected_reserved_count": 0,
             "hms_selected_reserved_count": 0,
             "hms_reserved_count": 0,
             "cm_reserved_count": 0,
             "available_unit_count": 4,
             "unavailable_unit_count": 0,
             "blackout_unit_count": 0,
             "total_units": 4
         }
     ]
 }
 */
