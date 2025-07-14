//
//  CalendarEventServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest

final class CalendarEventServiceRequestTests: XCTestCase {
    
    func testFetchByMonth_WillGenerateCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01
        let request = CalendarEventServiceRequest.FetchByMonth(
            hotelId: 105,
            date: testDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["date"] as? String, "2024-07")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByMonth_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01
        let request = CalendarEventServiceRequest.FetchByMonth(
            hotelId: 105,
            date: testDate,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["date"] as? String, "2024-07")
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testFetchByDay_WillGenerateCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-01
        let request = CalendarEventServiceRequest.FetchByDay(
            hotelId: 105,
            date: testDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["date"] as? String, "2025-07-01")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByDay_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-01
        let request = CalendarEventServiceRequest.FetchByDay(
            hotelId: 105,
            date: testDate,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["date"] as? String, "2025-07-01")
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testCreateCalendarEvent_WillGenerateCorrectBody() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-01
        let request = CalendarEventServiceRequest.CreateCalendarEvent(
            hotelId: 105,
            date: testDate,
            title: "Test Event",
            note: "Test note"
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["date"] as? String, "2025-07-01")
        XCTAssertEqual(json?["title"] as? String, "Test Event")
        XCTAssertEqual(json?["note"] as? String, "Test note")
    }
    
    func testCreateCalendarEvent_WithNilNote_WillGenerateCorrectBody() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-01
        let request = CalendarEventServiceRequest.CreateCalendarEvent(
            hotelId: 105,
            date: testDate,
            title: "Test Event"
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["date"] as? String, "2025-07-01")
        XCTAssertEqual(json?["title"] as? String, "Test Event")
        XCTAssertNil(json?["note"])
    }
    
    func testUpdateCalendarEvent_WillGenerateCorrectBody() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-01
        let request = CalendarEventServiceRequest.UpdateCalendarEvent(
            id: 2,
            date: testDate,
            title: "Updated Event",
            note: "Updated note"
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["date"] as? String, "2025-07-01")
        XCTAssertEqual(json?["title"] as? String, "Updated Event")
        XCTAssertEqual(json?["note"] as? String, "Updated note")
        // ID should not be in the body as it's used in the URL path
        XCTAssertNil(json?["id"])
    }
    
    func testUpdateCalendarEvent_WithNilValues_WillGenerateMinimalBody() throws {
        // Given
        let request = CalendarEventServiceRequest.UpdateCalendarEvent(
            id: 2,
            date: nil,
            title: nil,
            note: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertNil(json?["date"])
        XCTAssertNil(json?["title"])
        XCTAssertNil(json?["note"])
        XCTAssertNil(json?["id"])
    }
} 
