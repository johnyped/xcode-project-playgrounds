//
//  CalendarServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest

final class CalendarServiceRouterTests: XCTestCase {
    
    func testFetchMonthRouter_WillHaveCorrectParameters() throws {
        // Given
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 105,
            month: "2024-02"
        )
        
        // When
        let router = CalendarServiceRouter.fetchMonth(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar/month")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2024-02")
    }
    
    func testFetchMonthRouter_WithDateInitializer_WillHaveCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1706745600) // Feb 2024 equivalent
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            date: testDate
        )
        
        // When
        let router = CalendarServiceRouter.fetchMonth(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/calendar/month")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["month"] as? String)
    }
    
    func testFetchMonthRouter_WillHaveCorrectHeaders() throws {
        // Given
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            month: "2024-02"
        )
        
        // When
        let router = CalendarServiceRouter.fetchMonth(request: request)
        
        // Then
        XCTAssertEqual(router.headers?["Content-Type"], "application/json")
        XCTAssertNil(router.body)
    }
    
    func testFetchMonthRouter_AsURLRequest_WillCreateValidRequest() throws {
        // Given
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            month: "2024-02"
        )
        let router = CalendarServiceRouter.fetchMonth(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/calendar/month") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
} 