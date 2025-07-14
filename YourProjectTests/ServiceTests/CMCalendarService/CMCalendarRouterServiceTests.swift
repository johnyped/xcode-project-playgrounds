//
//  CMCalendarRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import XCTest

final class CMCalendarRouterServiceTests: XCTestCase {
    
    func testFetchByMonthRouter_WillHaveCorrectParameters() throws {
        // Given
        let monthDate = Date(timeIntervalSince1970: 1714521600) // 2024-05-01
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: monthDate
        )
        
        // When
        let router = CMCalendarServiceRouter.fetchByMonth(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-calendar/month")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["month"] as? String, "2024-05")
    }
    
    func testFetchByMonthRouter_WithDifferentValues_WillHaveCorrectParameters() throws {
        // Given
        let monthDate = Date(timeIntervalSince1970: 1733011200) // 2024-12-01
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 200,
            month: monthDate
        )
        
        // When
        let router = CMCalendarServiceRouter.fetchByMonth(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/cm-calendar/month")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 200)
        XCTAssertEqual(parameters?["month"] as? String, "2024-12")
    }
    
    func testFetchByMonthRouter_Headers() throws {
        // Given
        let monthDate = Date(timeIntervalSince1970: 1714521600) // 2024-05-01
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: monthDate
        )
        
        // When
        let router = CMCalendarServiceRouter.fetchByMonth(request: request)
        
        // Then
        let headers = router.headers
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
} 