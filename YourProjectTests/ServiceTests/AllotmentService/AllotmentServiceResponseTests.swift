//
//  AllotmentServiceResponseTests.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import XCTest

final class AllotmentServiceResponseTests: XCTestCase {
    
    typealias AllotmentMonth = AllotmentServiceResponse.AllotmentMonth
    
    // MARK: - Initialization Tests
    
    func test_initAllotmentMonthWithRequiredProperties() throws {
        // Arrange & Act
        let allotmentMonth = createSampleAllotmentMonth()
        
        // Assert
        XCTAssertNotNil(allotmentMonth.month)
        XCTAssertEqual(allotmentMonth.allotments.count, 3)
        
        let firstAllotment = allotmentMonth.allotments[0]
        XCTAssertEqual(firstAllotment.reservedType, .roomType)
        XCTAssertEqual(firstAllotment.reservedTypeId, 179)
        XCTAssertEqual(firstAllotment.availableUnitCount, 4)
        XCTAssertEqual(firstAllotment.totalUnits, 4)
    }
    
    func test_initAllotmentMonthWithEmptyAllotments() throws {
        // Arrange & Act
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let month = formatter.date(from: "2025-07")!
        let allotmentMonth = AllotmentMonth(month: month, allotments: UnitTypeAllotments(array: []))
        
        // Assert
        XCTAssertNotNil(allotmentMonth.month)
        XCTAssertEqual(allotmentMonth.allotments.count, 0)
    }
    
    func test_initAllotmentMonthWithDifferentReservedTypes() throws {
        // Arrange & Act
        let roomTypeAllotment = createSampleUnitTypeAllotment(reservedType: .roomType)
        let roomAllotment = createSampleUnitTypeAllotment(reservedType: .room, reservedTypeId: 642)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let month = formatter.date(from: "2025-07")!
        let allotmentMonth = AllotmentMonth(month: month, allotments: UnitTypeAllotments(array: [roomTypeAllotment, roomAllotment]))
        
        // Assert
        XCTAssertEqual(allotmentMonth.allotments.count, 2)
        XCTAssertEqual(allotmentMonth.allotments[0].reservedType, .roomType)
        XCTAssertEqual(allotmentMonth.allotments[1].reservedType, .room)
        XCTAssertEqual(allotmentMonth.allotments[1].reservedTypeId, 642)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingAllotmentMonthFromJSON() throws {
        // Arrange
        let json = """
        {
            "month": "2025-07",
            "allotments": [
                {
                    "reserved_type": "ROOM_TYPE",
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
                    "reserved_type": "ROOM",
                    "reserved_type_id": 642,
                    "date": "2025-07-05",
                    "hms_unselected_reserved_count": 1,
                    "hms_selected_reserved_count": 2,
                    "hms_reserved_count": 3,
                    "cm_reserved_count": 1,
                    "available_unit_count": 2,
                    "unavailable_unit_count": 1,
                    "blackout_unit_count": 1,
                    "total_units": 5
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let allotmentMonth = try JSONDecoder().decode(AllotmentMonth.self, from: json)
        
        // Assert
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let expectedMonth = formatter.date(from: "2025-07")!
        XCTAssertEqual(allotmentMonth.month, expectedMonth)
        XCTAssertEqual(allotmentMonth.allotments.count, 2)
        
        let firstAllotment = allotmentMonth.allotments[0]
        XCTAssertEqual(firstAllotment.reservedType, .roomType)
        XCTAssertEqual(firstAllotment.reservedTypeId, 179)
        XCTAssertEqual(firstAllotment.availableUnitCount, 4)
        XCTAssertEqual(firstAllotment.totalUnits, 4)
        
        let secondAllotment = allotmentMonth.allotments[1]
        XCTAssertEqual(secondAllotment.reservedType, .room)
        XCTAssertEqual(secondAllotment.reservedTypeId, 642)
        XCTAssertEqual(secondAllotment.hmsUnselectedReservedCount, 1)
        XCTAssertEqual(secondAllotment.hmsSelectedReservedCount, 2)
        XCTAssertEqual(secondAllotment.hmsReservedCount, 3)
        XCTAssertEqual(secondAllotment.cmReservedCount, 1)
        XCTAssertEqual(secondAllotment.availableUnitCount, 2)
        XCTAssertEqual(secondAllotment.unavailableUnitCount, 1)
        XCTAssertEqual(secondAllotment.blackoutUnitCount, 1)
        XCTAssertEqual(secondAllotment.totalUnits, 5)
    }
    
    func test_encodingAllotmentMonthToJSON() throws {
        // Arrange
        let allotmentMonth = createSampleAllotmentMonth()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let jsonData = try encoder.encode(allotmentMonth)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"2025-07\""))
        XCTAssertTrue(jsonString.contains("\"reserved_type\":\"ROOM_TYPE\""))
        XCTAssertTrue(jsonString.contains("\"reserved_type_id\":179"))
        XCTAssertTrue(jsonString.contains("\"available_unit_count\":4"))
        XCTAssertTrue(jsonString.contains("\"total_units\":4"))
        XCTAssertTrue(jsonString.contains("\"2025-07-04\""))
        XCTAssertTrue(jsonString.contains("\"2025-07-05\""))
        XCTAssertTrue(jsonString.contains("\"2025-07-06\""))
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingAllotmentMonthWithEmptyAllotments() throws {
        // Arrange
        let json = """
        {
            "month": "2025-07",
            "allotments": []
        }
        """.data(using: .utf8)!
        
        // Act
        let allotmentMonth = try JSONDecoder().decode(AllotmentMonth.self, from: json)
        
        // Assert
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let expectedMonth = formatter.date(from: "2025-07")!
        XCTAssertEqual(allotmentMonth.month, expectedMonth)
        XCTAssertTrue(allotmentMonth.allotments.lists.isEmpty)
    }
    
    func test_decodingAllotmentMonthWithSingleAllotment() throws {
        // Arrange
        let json = """
        {
            "month": "2025-07",
            "allotments": [
                {
                    "reserved_type": "ROOM_TYPE",
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
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let allotmentMonth = try JSONDecoder().decode(AllotmentMonth.self, from: json)
        
        // Assert
        XCTAssertEqual(allotmentMonth.allotments.count, 1)
        let allotment = allotmentMonth.allotments.first!
        XCTAssertEqual(allotment.reservedType, .roomType)
        XCTAssertEqual(allotment.reservedTypeId, 179)
    }
    
    func test_roundTripEncodeDecodeConsistency() throws {
        // Arrange
        let originalAllotmentMonth = createSampleAllotmentMonth()
        
        // Act - Encode then decode
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(originalAllotmentMonth)
        let decodedAllotmentMonth = try JSONDecoder().decode(AllotmentMonth.self, from: jsonData)
        
        // Assert
        XCTAssertEqual(originalAllotmentMonth.month, decodedAllotmentMonth.month)
        XCTAssertEqual(originalAllotmentMonth.allotments.count, decodedAllotmentMonth.allotments.count)
        
        for (original, decoded) in zip(originalAllotmentMonth.allotments.lists, decodedAllotmentMonth.allotments.lists) {
            XCTAssertEqual(original.reservedType, decoded.reservedType)
            XCTAssertEqual(original.reservedTypeId, decoded.reservedTypeId)
            XCTAssertEqual(original.date, decoded.date)
            XCTAssertEqual(original.hmsUnselectedReservedCount, decoded.hmsUnselectedReservedCount)
            XCTAssertEqual(original.hmsSelectedReservedCount, decoded.hmsSelectedReservedCount)
            XCTAssertEqual(original.hmsReservedCount, decoded.hmsReservedCount)
            XCTAssertEqual(original.cmReservedCount, decoded.cmReservedCount)
            XCTAssertEqual(original.availableUnitCount, decoded.availableUnitCount)
            XCTAssertEqual(original.unavailableUnitCount, decoded.unavailableUnitCount)
            XCTAssertEqual(original.blackoutUnitCount, decoded.blackoutUnitCount)
            XCTAssertEqual(original.totalUnits, decoded.totalUnits)
        }
    }
    
    // MARK: - ReservedType Tests
    
    func test_reservedTypeRawValues() throws {
        XCTAssertEqual(UnitTypeAllotment.ReservedType.roomType.rawValue, "ROOM_TYPE")
        XCTAssertEqual(UnitTypeAllotment.ReservedType.room.rawValue, "ROOM")
    }
    
    func test_reservedTypeDecoding() throws {
        // Test ROOM_TYPE
        let roomTypeJson = "\"ROOM_TYPE\"".data(using: .utf8)!
        let roomType = try JSONDecoder().decode(UnitTypeAllotment.ReservedType.self, from: roomTypeJson)
        XCTAssertEqual(roomType, .roomType)
        
        // Test ROOM
        let roomJson = "\"ROOM\"".data(using: .utf8)!
        let room = try JSONDecoder().decode(UnitTypeAllotment.ReservedType.self, from: roomJson)
        XCTAssertEqual(room, .room)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleAllotmentMonth() -> AllotmentMonth {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let month = formatter.date(from: "2025-07")!
        
        let allotments = [
            createSampleUnitTypeAllotment(dateString: "2025-07-04"),
            createSampleUnitTypeAllotment(dateString: "2025-07-05"),
            createSampleUnitTypeAllotment(dateString: "2025-07-06")
        ]
        
        return AllotmentMonth(month: month, allotments: UnitTypeAllotments(array: allotments))
    }
    
    private func createSampleUnitTypeAllotment(
        reservedType: UnitTypeAllotment.ReservedType = .roomType,
        reservedTypeId: Int = 179,
        dateString: String = "2025-07-04",
        hmsUnselectedReservedCount: Int = 0,
        hmsSelectedReservedCount: Int = 0,
        hmsReservedCount: Int = 0,
        cmReservedCount: Int = 0,
        availableUnitCount: Int = 4,
        unavailableUnitCount: Int = 0,
        blackoutUnitCount: Int = 0,
        totalUnits: Int = 4
    ) -> UnitTypeAllotment {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let date = formatter.date(from: dateString)!
        
        return UnitTypeAllotment(
            reservedType: reservedType,
            reservedTypeId: reservedTypeId,
            date: date,
            hmsUnselectedReservedCount: hmsUnselectedReservedCount,
            hmsSelectedReservedCount: hmsSelectedReservedCount,
            hmsReservedCount: hmsReservedCount,
            cmReservedCount: cmReservedCount,
            availableUnitCount: availableUnitCount,
            unavailableUnitCount: unavailableUnitCount,
            blackoutUnitCount: blackoutUnitCount,
            totalUnits: totalUnits
        )
    }
    
    private func createSampleAllotmentMonthWithCustomData(
        monthString: String,
        allotments: [UnitTypeAllotment]
    ) -> AllotmentMonth {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en")
        
        let month = formatter.date(from: monthString)!
        return AllotmentMonth(month: month, allotments: UnitTypeAllotments(array: allotments))
    }
}

// MARK: - UnitTypeAllotment Extension for Testing
extension UnitTypeAllotment {
    init(
        reservedType: ReservedType,
        reservedTypeId: Int,
        date: Date,
        hmsUnselectedReservedCount: Int,
        hmsSelectedReservedCount: Int,
        hmsReservedCount: Int,
        cmReservedCount: Int,
        availableUnitCount: Int,
        unavailableUnitCount: Int,
        blackoutUnitCount: Int,
        totalUnits: Int
    ) {
        self.reservedType = reservedType
        self.reservedTypeId = reservedTypeId
        self.date = date
        self.hmsUnselectedReservedCount = hmsUnselectedReservedCount
        self.hmsSelectedReservedCount = hmsSelectedReservedCount
        self.hmsReservedCount = hmsReservedCount
        self.cmReservedCount = cmReservedCount
        self.availableUnitCount = availableUnitCount
        self.unavailableUnitCount = unavailableUnitCount
        self.blackoutUnitCount = blackoutUnitCount
        self.totalUnits = totalUnits
    }
} 
