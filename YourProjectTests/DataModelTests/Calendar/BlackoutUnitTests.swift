//
//  BlackoutUnitTests.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest

final class BlackoutUnitTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() throws {
        // Arrange & Act
        let blackoutUnit = createSampleBlackoutUnit()
        
        // Assert
        XCTAssertEqual(blackoutUnit.id, 172)
        XCTAssertEqual(blackoutUnit.hotelId, 105)
        XCTAssertEqual(blackoutUnit.unitableId, 620)
        XCTAssertEqual(blackoutUnit.unitableType, .room)
        XCTAssertEqual(blackoutUnit.startDate, "2024-05-29".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(blackoutUnit.endDate, "2024-05-30".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(blackoutUnit.quantity, 1)
        XCTAssertNotNil(blackoutUnit.createdAt)
        XCTAssertNotNil(blackoutUnit.updatedAt)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let blackoutUnit = createSampleBlackoutUnit()
        
        // Assert
        XCTAssertNil(blackoutUnit.removesDate)
        XCTAssertEqual(blackoutUnit.note, "")
        XCTAssertNil(blackoutUnit.emoji)
    }
    
    func test_initWithNonNilOptionalProperties() throws {
        // Arrange & Act
        let blackoutUnit = createSampleBlackoutUnitWithOptionals()
        
        // Assert
        XCTAssertNotNil(blackoutUnit.removesDate)
        XCTAssertEqual(blackoutUnit.note, "Test blackout note")
        XCTAssertEqual(blackoutUnit.emoji, "🚫")
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let blackoutUnit = createSampleBlackoutUnit()
        
        // Assert
        XCTAssertNotNil(blackoutUnit.startDate)
        XCTAssertNotNil(blackoutUnit.endDate)
        XCTAssertNotNil(blackoutUnit.createdAt)
        XCTAssertNotNil(blackoutUnit.updatedAt)
    }
    
    // MARK: - UnitableType Tests
    
    func test_unitableTypeRawValues() throws {
        XCTAssertEqual(BlackoutUnit.UnitableType.room.rawValue, "ROOM")
    }
    
    func test_unitableTypeFromRawValue() throws {
        XCTAssertEqual(BlackoutUnit.UnitableType(rawValue: "ROOM"), .room)
        XCTAssertNil(BlackoutUnit.UnitableType(rawValue: "INVALID"))
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
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
        """.data(using: .utf8)!
        
        // Act
        let blackoutUnit = try JSONDecoder().decode(BlackoutUnit.self, from: json)
        
        // Assert
        XCTAssertEqual(blackoutUnit.id, 172)
        XCTAssertEqual(blackoutUnit.hotelId, 105)
        XCTAssertEqual(blackoutUnit.unitableId, 620)
        XCTAssertEqual(blackoutUnit.unitableType, .room)
        XCTAssertEqual(blackoutUnit.startDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-29")
        XCTAssertEqual(blackoutUnit.endDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-05-30")
        XCTAssertNil(blackoutUnit.removesDate)
        XCTAssertEqual(blackoutUnit.note, "")
        XCTAssertNil(blackoutUnit.emoji)
        XCTAssertEqual(blackoutUnit.quantity, 1)
        XCTAssertNotNil(blackoutUnit.createdAt)
        XCTAssertNotNil(blackoutUnit.updatedAt)
    }
    
    func test_decodingFromJSONWithOptionalValues() throws {
        // Arrange
        let json = """
        {
            "id": 173,
            "unitable_id": 621,
            "unitable_type": "ROOM",
            "start_date": "2024-06-01",
            "end_date": "2024-06-05",
            "removes_date": "2024-06-10",
            "note": "Maintenance blackout",
            "emoji": "🔧",
            "quantity": 2,
            "created_at": "2024-06-01T10:00:00.000+07:00",
            "updated_at": "2024-06-01T10:00:00.000+07:00",
            "hotel_id": 106
        }
        """.data(using: .utf8)!
        
        // Act
        let blackoutUnit = try JSONDecoder().decode(BlackoutUnit.self, from: json)
        
        // Assert
        XCTAssertEqual(blackoutUnit.id, 173)
        XCTAssertEqual(blackoutUnit.hotelId, 106)
        XCTAssertEqual(blackoutUnit.unitableId, 621)
        XCTAssertEqual(blackoutUnit.unitableType, .room)
        XCTAssertEqual(blackoutUnit.startDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-06-01")
        XCTAssertEqual(blackoutUnit.endDate.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-06-05")
        XCTAssertNotNil(blackoutUnit.removesDate)
        XCTAssertEqual(blackoutUnit.removesDate?.toDateString(FormConfig.DateFormat.yyyyMMdd), "2024-06-10")
        XCTAssertEqual(blackoutUnit.note, "Maintenance blackout")
        XCTAssertEqual(blackoutUnit.emoji, "🔧")
        XCTAssertEqual(blackoutUnit.quantity, 2)
        XCTAssertNotNil(blackoutUnit.createdAt)
        XCTAssertNotNil(blackoutUnit.updatedAt)
    }
    
    func test_decodingFromJSONWithInvalidDate() throws {
        // Arrange
        let json = """
        {
            "id": 172,
            "unitable_id": 620,
            "unitable_type": "ROOM",
            "start_date": "invalid-date",
            "end_date": "2024-05-30",
            "removes_date": null,
            "note": "",
            "emoji": null,
            "quantity": 1,
            "created_at": "2024-05-29T06:49:07.734+07:00",
            "updated_at": "2024-05-29T06:49:07.734+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(BlackoutUnit.self, from: json))
    }
    
    func test_decodingFromJSONWithInvalidUnitableType() throws {
        // Arrange
        let json = """
        {
            "id": 172,
            "unitable_id": 620,
            "unitable_type": "INVALID_TYPE",
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
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(BlackoutUnit.self, from: json))
    }
    
    func test_decodingFromJSONWithMissingRequiredFields() throws {
        // Arrange
        let json = """
        {
            "id": 172,
            "unitable_id": 620,
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
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(BlackoutUnit.self, from: json))
    }
    
    // MARK: - Date Range Tests
    
    func test_dateRangeValidation() throws {
        // Arrange & Act
        let blackoutUnit = createSampleBlackoutUnit()
        
        // Assert
        XCTAssertTrue(blackoutUnit.startDate < blackoutUnit.endDate)
    }
    
    func test_dateRangeWithSingleDay() throws {
        // Arrange & Act
        let blackoutUnit = createSingleDayBlackoutUnit()
        
        // Assert
        XCTAssertEqual(blackoutUnit.startDate.toDateString(FormConfig.DateFormat.yyyyMMdd), 
                       blackoutUnit.endDate.toDateString(FormConfig.DateFormat.yyyyMMdd))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleBlackoutUnit() -> BlackoutUnit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        
        return BlackoutUnit(
            id: 172,
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            startDate: "2024-05-29".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            endDate: "2024-05-30".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            removesDate: nil,
            note: "",
            emoji: nil,
            quantity: 1,
            createdAt: dateFormatter.date(from: "2024-05-29T06:49:07.734+07:00") ?? .now,
            updatedAt: dateFormatter.date(from: "2024-05-29T06:49:07.734+07:00") ?? .now
        )
    }
    
    private func createSampleBlackoutUnitWithOptionals() -> BlackoutUnit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        
        return BlackoutUnit(
            id: 173,
            hotelId: 106,
            unitableId: 621,
            unitableType: .room,
            startDate: "2024-06-01".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            endDate: "2024-06-05".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            removesDate: "2024-06-10".toDate(FormConfig.DateFormat.yyyyMMdd),
            note: "Test blackout note",
            emoji: "🚫",
            quantity: 2,
            createdAt: dateFormatter.date(from: "2024-06-01T10:00:00.000+07:00") ?? .now,
            updatedAt: dateFormatter.date(from: "2024-06-01T10:00:00.000+07:00") ?? .now
        )
    }
    
    private func createSingleDayBlackoutUnit() -> BlackoutUnit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        let singleDate = "2024-07-15".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now
        
        return BlackoutUnit(
            id: 174,
            hotelId: 107,
            unitableId: 622,
            unitableType: .room,
            startDate: singleDate,
            endDate: singleDate,
            removesDate: nil,
            note: "Single day blackout",
            emoji: "⚡",
            quantity: 1,
            createdAt: dateFormatter.date(from: "2024-07-15T08:00:00.000+07:00") ?? .now,
            updatedAt: dateFormatter.date(from: "2024-07-15T08:00:00.000+07:00") ?? .now
        )
    }
} 