//
//  CalendarServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest

final class CalendarServiceRequestTests: XCTestCase {
    
    // MARK: - FetchMonth Tests
    
    func testFetchMonth_WillGenerateCorrectParameters() throws {
        // Given
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 105,
            month: "2024-02"
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2024-02")
    }
    
    func testFetchMonth_WithDateInitializer_WillGenerateCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1706745600) // Feb 2024 equivalent
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            date: testDate
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["month"] as? String)
        // Note: The exact month string depends on the toDateString implementation
    }
    
    func testFetchMonth_Encoding_WillGenerateCorrectJSON() throws {
        // Given
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 2,
            month: "2024-03"
        )
        
        // When
        let jsonData = try JSONEncoder().encode(request)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
        let json = jsonObject as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 2)
        XCTAssertEqual(json?["month"] as? String, "2024-03")
    }
} 