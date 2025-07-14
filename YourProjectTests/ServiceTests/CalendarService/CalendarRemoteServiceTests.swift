//
//  CalendarRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest
import Mockable

final class CalendarRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    typealias ReservedItem = CalendarReserviceResponse.ReservedItem
    typealias CalendarMonth = CalendarReserviceResponse.CalendarMonth

    func testFetchMonth_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarMonth = CalendarMonth(
            month: "2024-02",
            reservedItems: [
                ReservedItem(
                    reservationId: 995,
                    status: .created,
                    checkInDate: Date(timeIntervalSince1970: 1709164800), // 2024-02-29
                    checkOutDate: Date(timeIntervalSince1970: 1709337600), // 2024-03-02
                    reservedType: .roomType,
                    reservedTypeId: 179,
                    reservedUnitId: 620,
                    emoji: nil
                )
            ]
        )
        
        // Stub the API manager to return the expected calendar month
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarMonth)

        let service = CalendarRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            month: "2024-02"
        )

        // When
        let result = try await service.fetchMonth(request: request)

        // Then
        XCTAssertEqual(result.month, expectedCalendarMonth.month)
        XCTAssertEqual(result.reservedItems.count, expectedCalendarMonth.reservedItems.count)
        XCTAssertEqual(result.reservedItems.first?.reservationId, 995)
        XCTAssertEqual(result.reservedItems.first?.status, .created)
        XCTAssertEqual(result.reservedItems.first?.reservedType, .roomType)
        XCTAssertEqual(result.reservedItems.first?.reservedTypeId, 179)
        XCTAssertEqual(result.reservedItems.first?.reservedUnitId, 620)
        XCTAssertNil(result.reservedItems.first?.emoji)
    }

    func testFetchMonth_WithDateInitializer_WillGetValidResponse() async throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1706745600) // Feb 2024 equivalent
        let expectedCalendarMonth = CalendarMonth(
            month: "2024-02",
            reservedItems: []
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarMonth)

        let service = CalendarRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            date: testDate
        )

        // When
        let result = try await service.fetchMonth(request: request)

        // Then
        XCTAssertEqual(result.month, expectedCalendarMonth.month)
        XCTAssertEqual(result.reservedItems.count, 0)
    }

    func testFetchMonth_WithMultipleReservedItems_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarMonth = CalendarMonth(
            month: "2024-02",
            reservedItems: [
                ReservedItem(
                    reservationId: 993,
                    status: .created,
                    checkInDate: Date(timeIntervalSince1970: 1707609600), // 2024-02-11
                    checkOutDate: Date(timeIntervalSince1970: 1707696000), // 2024-02-12
                    reservedType: .roomType,
                    reservedTypeId: 180,
                    reservedUnitId: 623,
                    emoji: nil
                ),
                ReservedItem(
                    reservationId: 994,
                    status: .created,
                    checkInDate: Date(timeIntervalSince1970: 1708819200), // 2024-02-25
                    checkOutDate: Date(timeIntervalSince1970: 1708905600), // 2024-02-26
                    reservedType: .roomType,
                    reservedTypeId: 179,
                    reservedUnitId: 625,
                    emoji: nil
                )
            ]
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarMonth)

        let service = CalendarRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = CalendarServiceRequest.FetchMonth(
            hotelId: 1,
            month: "2024-02"
        )

        // When
        let result = try await service.fetchMonth(request: request)

        // Then
        XCTAssertEqual(result.month, expectedCalendarMonth.month)
        XCTAssertEqual(result.reservedItems.count, 2)
        XCTAssertEqual(result.reservedItems.first?.reservationId, 993)
        XCTAssertEqual(result.reservedItems.last?.reservationId, 994)
    }
}

