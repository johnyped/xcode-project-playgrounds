//
//  CalendarEventTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest


final class CalendarEventTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let calendarEvent = createSampleCalendarEvent()
        
        // Assert
        XCTAssertEqual(calendarEvent.id, 2)
        XCTAssertEqual(calendarEvent.hotelId, 105)
        XCTAssertEqual(calendarEvent.title, "Demo")
        XCTAssertEqual(calendarEvent.note, " note")
        XCTAssertEqual(calendarEvent.date, "2025-07-07".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertNotNil(calendarEvent.createdAt)
        XCTAssertNotNil(calendarEvent.updatedAt)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        var calendarEvent = createSampleCalendarEvent()
        
        // Assert
        XCTAssertNotNil(calendarEvent.date)
        XCTAssertNotNil(calendarEvent.createdAt)
        XCTAssertNotNil(calendarEvent.updatedAt)
        XCTAssertEqual(calendarEvent.dateText, "2025-07-07")
    }
    
    func test_dateTextProperty() throws {
        // Arrange & Act
        var calendarEvent = createSampleCalendarEvent()
        
        // Assert
        XCTAssertEqual(calendarEvent.dateText, "2025-07-07")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "hotel_id": 105,
            "title": "Demo",
            "note": " note",
            "date": "2025-07-07",
            "created_at": "2025-07-07T13:18:51.571+07:00",
            "updated_at": "2025-07-07T13:18:51.571+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let calendarEvent = try JSONDecoder().decode(CalendarEvent.self, from: json)
        
        // Assert
        XCTAssertEqual(calendarEvent.id, 2)
        XCTAssertEqual(calendarEvent.hotelId, 105)
        XCTAssertEqual(calendarEvent.title, "Demo")
        XCTAssertEqual(calendarEvent.note, " note")
        XCTAssertNotNil(calendarEvent.date)
        XCTAssertNotNil(calendarEvent.createdAt)
        XCTAssertNotNil(calendarEvent.updatedAt)
        XCTAssertEqual(calendarEvent.date.toDateString(FormConfig.DateFormat.yyyyMMdd), "2025-07-07")
    }
    
    func test_decodingFromJSONWithEmptyNote() throws {
        // Arrange
        let json = """
        {
            "id": 3,
            "hotel_id": 106,
            "title": "Test Event",
            "note": null,
            "date": "2025-07-08",
            "created_at": "2025-07-08T14:20:30.000+07:00",
            "updated_at": "2025-07-08T14:20:30.000+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let calendarEvent = try JSONDecoder().decode(CalendarEvent.self, from: json)
        
        // Assert
        XCTAssertEqual(calendarEvent.id, 3)
        XCTAssertEqual(calendarEvent.hotelId, 106)
        XCTAssertEqual(calendarEvent.title, "Test Event")
        XCTAssertEqual(calendarEvent.note, "") // Should default to empty string
        XCTAssertEqual(calendarEvent.date.toDateString(FormConfig.DateFormat.yyyyMMdd), "2025-07-08")
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let calendarEvent = createSampleCalendarEvent()
        
        // Act
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(calendarEvent)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["id"] as? Int, 2)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["title"] as? String, "Demo")
        XCTAssertEqual(jsonObject?["note"] as? String, " note")
        XCTAssertEqual(jsonObject?["date"] as? String, "2025-07-07")
        XCTAssertNotNil(jsonObject?["created_at"])
        XCTAssertNotNil(jsonObject?["updated_at"])
    }
    
    func test_decodingAndReencodingPreservesData() throws {
        // Arrange
        let originalJSON = """
        {
            "id": 2,
            "hotel_id": 105,
            "title": "Demo",
            "note": " note",
            "date": "2025-07-07",
            "created_at": "2025-07-07T13:18:51.571+07:00",
            "updated_at": "2025-07-07T13:18:51.571+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let calendarEvent = try JSONDecoder().decode(CalendarEvent.self, from: originalJSON)
        let encodedData = try JSONEncoder().encode(calendarEvent)
        let reencodedEvent = try JSONDecoder().decode(CalendarEvent.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(calendarEvent.id, reencodedEvent.id)
        XCTAssertEqual(calendarEvent.hotelId, reencodedEvent.hotelId)
        XCTAssertEqual(calendarEvent.title, reencodedEvent.title)
        XCTAssertEqual(calendarEvent.note, reencodedEvent.note)
        XCTAssertEqual(calendarEvent.date.toDateString(FormConfig.DateFormat.yyyyMMdd), 
                      reencodedEvent.date.toDateString(FormConfig.DateFormat.yyyyMMdd))
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingWithMissingOptionalNote() throws {
        // Arrange
        let json = """
        {
            "id": 4,
            "hotel_id": 107,
            "title": "Event without note",
            "date": "2025-07-09",
            "created_at": "2025-07-09T15:30:45.123+07:00",
            "updated_at": "2025-07-09T15:30:45.123+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let calendarEvent = try JSONDecoder().decode(CalendarEvent.self, from: json)
        
        // Assert
        XCTAssertEqual(calendarEvent.note, "") // Should default to empty string
    }
    
    func test_dateStringFormattingConsistency() throws {
        // Arrange
        var calendarEvent = createSampleCalendarEvent()
        
        // Act
        let dateString1 = calendarEvent.dateText
        let dateString2 = calendarEvent.date.toDateString(FormConfig.DateFormat.yyyyMMdd)
        
        // Assert
        XCTAssertEqual(dateString1, dateString2)
        XCTAssertEqual(dateString1, "2025-07-07")
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCalendarEvent() -> CalendarEvent {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        
        return CalendarEvent(
            id: 2,
            hotelId: 105,
            title: "Demo",
            note: " note",
            date: "2025-07-07".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            createdAt: dateFormatter.date(from: "2025-07-07T13:18:51.571+07:00")!,
            updatedAt: dateFormatter.date(from: "2025-07-07T13:18:51.571+07:00")!
        )
    }
    
    private func createCalendarEventWithCustomData(
        id: Int,
        hotelId: Int,
        title: String,
        note: String = "",
        dateString: String = "2025-07-07",
        createdAtString: String = "2025-07-07T13:18:51.571+07:00",
        updatedAtString: String = "2025-07-07T13:18:51.571+07:00"
    ) -> CalendarEvent {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        
        return CalendarEvent(
            id: id,
            hotelId: hotelId,
            title: title,
            note: note,
            date: dateString.toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            createdAt: dateFormatter.date(from: createdAtString)!,
            updatedAt: dateFormatter.date(from: updatedAtString)!
        )
    }
} 
