//
//  BlackoutCalendarServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest

final class BlackoutCalendarServiceRouterTests: XCTestCase {
    
    // MARK: - BlackoutCalendar Router Tests
    
    func testFetchByMonthRouter_WillHaveCorrectParameters() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01
        let request = BlackoutCalendarServiceRequest.FetchByMonth(
            hotelId: 105,   
            month: testDate
        )
        
        // When
        let router = BlackoutCalendarServiceRouter.fetchByMonth(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/blackout-calendar/month")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2024-07")
    }
    
} 
