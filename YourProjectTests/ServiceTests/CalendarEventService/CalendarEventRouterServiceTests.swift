//
//  CalendarEventRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest

final class CalendarEventRouterServiceTests: XCTestCase {
    
    func testFetchByMonthRouter_WillHaveCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01 for month format
        let request = CalendarEventServiceRequest.FetchByMonth(
            hotelId: 105,
            date: testDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // When
        let router = CalendarEventServiceRouter.fetchByMonth(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar-events/month")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["date"] as? String, "2024-07")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByDayRouter_WillHaveCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-01
        let request = CalendarEventServiceRequest.FetchByDay(
            hotelId: 105,
            date: testDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = CalendarEventServiceRouter.fetchByDay(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar-events/day")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["date"] as? String, "2025-07-01")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = CalendarEventServiceRequest.FetchById(id: 2)
        
        // When
        let router = CalendarEventServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar-events/2")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
    }
    
    func testCreateCalendarEventRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1751364000) // 2025-07-07
        let request = CalendarEventServiceRequest.CreateCalendarEvent(
            hotelId: 105,
            date: testDate,
            title: "New Event",
            note: "New event note"
        )
        
        // When
        let router = CalendarEventServiceRouter.createCalendarEvent(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar-events")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateCalendarEventRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = CalendarEventServiceRequest.UpdateCalendarEvent(
            id: 2,
            date: nil,
            title: "Updated Demo",
            note: "Updated note"
        )
        
        // When
        let router = CalendarEventServiceRouter.updateCalendarEvent(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar-events/2")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeleteCalendarEventRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = CalendarEventServiceRequest.DeleteCalendarEvent(id: 2)
        
        // When
        let router = CalendarEventServiceRouter.deleteCalendarEvent(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar-events/2")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
} 
