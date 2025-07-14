//
//  CMCalendarServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import XCTest

final class CMCalendarServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByMonth Tests
    
    func testFetchByMonth_WillGenerateCorrectParameters() throws {
        // Given
        let monthDate = Date(timeIntervalSince1970: 1714521600) // 2024-05-01
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: monthDate
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2024-05")
    }
    
    func testFetchByMonth_WithDifferentValues_WillGenerateCorrectParameters() throws {
        // Given
        let monthDate = Date(timeIntervalSince1970: 1733011200) // 2024-12-01
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 107,
            month: monthDate
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 107)
        XCTAssertEqual(parameters?["month"] as? String, "2024-12")
    }
    
    func testFetchByMonth_WithZeroHotelId_WillGenerateCorrectParameters() throws {
        // Given
        let monthDate = Date(timeIntervalSince1970: 1711929600) // 2024-04-01
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 0,
            month: monthDate
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 0)
        XCTAssertEqual(parameters?["month"] as? String, "2024-04")
    }
} 