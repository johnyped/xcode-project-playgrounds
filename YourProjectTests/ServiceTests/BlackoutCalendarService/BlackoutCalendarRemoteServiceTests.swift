//
//  BlackoutCalendarRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/7/2568 BE.
//

import XCTest
import Mockable

final class BlackoutCalendarRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    // MARK: - BlackoutCalendar Tests
    
    func testFetchByMonth_WillGetValidResponse() async throws {
        // Given
        let expectedBlackoutUnits = BlackoutCalendarServiceResponse.BlackoutUnitMonth(
            month: Date(),
            blackoutUnits: []
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBlackoutUnits)

        let service = BlackoutCalendarRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let testDate = Date(timeIntervalSince1970: 1719792000) // 2024-07-01
        let request = BlackoutCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: testDate
        )

        // When
        let result = try await service.fetchByMonth(request: request)

        // Then
        XCTAssertEqual(result.blackoutUnits.count, expectedBlackoutUnits.blackoutUnits.count)
    }

} 
