//
//  BlackoutCalendarServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest

final class BlackoutCalendarServiceRequestTests: XCTestCase {
    
    // MARK: - BlackoutCalendar Request Tests
    
    func testFetchByMonth_WillGenerateCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01
        let request = BlackoutCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: testDate
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2024-07")
    }
    
} 