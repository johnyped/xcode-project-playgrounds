//
//  CalendarBlackoutUnitTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest

final class BlackoutCalendarServiceResponseTests: XCTestCase {
    
    typealias CalendarBlackoutUnitMonth = BlackoutCalendarServiceResponse.BlackoutUnitMonth
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let calendarBlackoutUnit = createSampleCalendarBlackoutUnitMonth()
        
        // Assert
        XCTAssertNotNil(calendarBlackoutUnit.month)
        XCTAssertEqual(calendarBlackoutUnit.blackoutUnits.count, 1)
        
        let blackoutUnit = calendarBlackoutUnit.blackoutUnits.first!
        XCTAssertEqual(blackoutUnit.id, 172)
        XCTAssertEqual(blackoutUnit.unitableId, 620)
        XCTAssertEqual(blackoutUnit.unitableType, .room)
        XCTAssertEqual(blackoutUnit.hotelId, 105)
        XCTAssertEqual(blackoutUnit.quantity, 1)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let calendarBlackoutUnit = createSampleCalendarBlackoutUnitMonth()
        let blackoutUnit = calendarBlackoutUnit.blackoutUnits.first!
        
        // Assert
        XCTAssertNil(blackoutUnit.removesDate)
        XCTAssertEqual(blackoutUnit.note, "")
        XCTAssertNil(blackoutUnit.emoji)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let calendarBlackoutUnit = createSampleCalendarBlackoutUnitMonth()
        let blackoutUnit = calendarBlackoutUnit.blackoutUnits.first!
        
        // Assert
        XCTAssertNotNil(blackoutUnit.startDate)
        XCTAssertNotNil(blackoutUnit.endDate)
        XCTAssertNotNil(blackoutUnit.createdAt)
        XCTAssertNotNil(blackoutUnit.updatedAt)
        XCTAssertNil(blackoutUnit.removesDate)
    }
    
    // MARK: - UnitableType Tests
    
    func test_unitableTypeRawValues() throws {
        XCTAssertEqual(BlackoutUnit.UnitableType.room.rawValue, "ROOM")
        XCTAssertEqual(BlackoutUnit.UnitableType.roomType.rawValue, "ROOM_TYPE")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "month": "2024-05",
            "blackout_units": [
                {
                    "id": 172,
                    "unitable_id": 620,
                    "unitable_type": "ROOM",
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
        """.data(using: .utf8)!
        
        // Act
        let calendarBlackoutUnit = try JSONDecoder().decode(CalendarBlackoutUnitMonth.self, from: json)
        
        // Assert
        XCTAssertEqual(calendarBlackoutUnit.month.toDateString(FormConfig.DateFormat.yyyyMM), "2024-05")
        XCTAssertEqual(calendarBlackoutUnit.blackoutUnits.count, 1)
        
        let blackoutUnit = calendarBlackoutUnit.blackoutUnits.first!
        XCTAssertEqual(blackoutUnit.id, 172)
        XCTAssertEqual(blackoutUnit.unitableId, 620)
        XCTAssertEqual(blackoutUnit.unitableType, .room)
        XCTAssertEqual(blackoutUnit.startDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-29")
        XCTAssertEqual(blackoutUnit.endDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-30")
        XCTAssertNil(blackoutUnit.removesDate)
        XCTAssertEqual(blackoutUnit.note, "")
        XCTAssertNil(blackoutUnit.emoji)
        XCTAssertEqual(blackoutUnit.quantity, 1)
        XCTAssertEqual(blackoutUnit.hotelId, 105)
        XCTAssertNotNil(blackoutUnit.createdAt)
        XCTAssertNotNil(blackoutUnit.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let calendarBlackoutUnit = createSampleCalendarBlackoutUnitMonth()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let jsonData = try encoder.encode(calendarBlackoutUnit)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"month\""))
        XCTAssertTrue(jsonString.contains("\"blackout_units\""))
        XCTAssertTrue(jsonString.contains("\"2024-05\""))
        XCTAssertTrue(jsonString.contains("\"id\":172"))
        XCTAssertTrue(jsonString.contains("\"hotel_id\":105"))
    }
    
    func test_decodingEmptyBlackoutUnits() throws {
        // Arrange
        let json = """
        {
            "month": "2024-05",
            "blackout_units": []
        }
        """.data(using: .utf8)!
        
        // Act
        let calendarBlackoutUnit = try JSONDecoder().decode(CalendarBlackoutUnitMonth.self, from: json)
        
        // Assert
        XCTAssertEqual(calendarBlackoutUnit.month.toDateString(FormConfig.DateFormat.yyyyMM), "2024-05")
        XCTAssertTrue(calendarBlackoutUnit.blackoutUnits.isEmpty)
    }
    
    func test_decodingMissingBlackoutUnits() throws {
        // Arrange
        let json = """
        {
            "month": "2024-05"
        }
        """.data(using: .utf8)!
        
        // Act
        let calendarBlackoutUnit = try JSONDecoder().decode(CalendarBlackoutUnitMonth.self, from: json)
        
        // Assert
        XCTAssertEqual(calendarBlackoutUnit.month.toDateString(FormConfig.DateFormat.yyyyMM), "2024-05")
        XCTAssertTrue(calendarBlackoutUnit.blackoutUnits.isEmpty)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCalendarBlackoutUnitMonth() -> CalendarBlackoutUnitMonth {
        let month = "2024-05".toDate(FormConfig.DateFormat.yyyyMM) ?? Date()
        
        let blackoutUnit = BlackoutUnit(
            id: 172,
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            startDate: "2024-05-29".toDate(FormConfig.DateFormat.yyyyMMdd) ?? Date(),
            endDate: "2024-05-30".toDate(FormConfig.DateFormat.yyyyMMdd) ?? Date(),
            removesDate: nil,
            note: "",
            emoji: nil,
            quantity: 1,
            createdAt: "2024-05-29T06:49:07.734+07:00".toDate(FormConfig.DateFormat.datetimeISO) ?? Date(),
            updatedAt: "2024-05-29T06:49:07.734+07:00".toDate(FormConfig.DateFormat.datetimeISO) ?? Date()
        )
        
        return BlackoutCalendarServiceResponse.BlackoutUnitMonth(
            month: month,
            blackoutUnits: [blackoutUnit]
        )
    }
} 
