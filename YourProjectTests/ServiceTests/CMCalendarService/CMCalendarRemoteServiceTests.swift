//
//  CMCalendarRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import XCTest
import Mockable

final class CMCalendarRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByMonth_WillGetValidResponse() async throws {
        // Given
        let expectedItems = [
            CMCalendarItem(
                date: Date(timeIntervalSince1970: 1714521600), // 2024-05-01
                reservedType: .roomType,
                reservedTypeId: 179,
                checkInDate: Date(timeIntervalSince1970: 1714521600), // 2024-05-01
                checkOutDate: Date(timeIntervalSince1970: 1714608000), // 2024-05-02
                cmBookingId: 76,
                cmBookingStatus: .confirmed,
                unitCount: 1,
                hmsReservationId: 1081
            ),
            CMCalendarItem(
                date: Date(timeIntervalSince1970: 1714780800), // 2024-05-04
                reservedType: .roomType,
                reservedTypeId: 180,
                checkInDate: Date(timeIntervalSince1970: 1714780800), // 2024-05-04
                checkOutDate: Date(timeIntervalSince1970: 1714867200), // 2024-05-05
                cmBookingId: 77,
                cmBookingStatus: .request,
                unitCount: 2,
                hmsReservationId: nil
            )
        ]
        
        let expectedResponse = CMCalendarServiceResponse.CMCalendarMonth(
            month: Date(timeIntervalSince1970: 1714521600), // 2024-05-01
            reservedItems: .init(array: expectedItems)
        )
        
        // Stub the API manager to return the expected response
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)

        let service = CMCalendarRemoteService(localStorage: localStorage,
                                            apiManager: apiManager)
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: Date(timeIntervalSince1970: 1714521600) // 2024-05-01
        )

        // When
        let result = try await service.fetchByMonth(request: request)

        // Then
        XCTAssertEqual(result.reservedItems.count, expectedItems.count)
        XCTAssertEqual(result.month.timeIntervalSince1970, expectedResponse.month.timeIntervalSince1970, accuracy: 1.0)
        
        // Test first item
        let firstItem = result.reservedItems.first
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(firstItem?.reservedTypeId, 179)
        XCTAssertEqual(firstItem?.cmBookingId, 76)
        XCTAssertEqual(firstItem?.unitCount, 1)
        XCTAssertEqual(firstItem?.hmsReservationId, 1081)
        XCTAssertEqual(firstItem?.reservedType, .roomType)
        XCTAssertEqual(firstItem?.cmBookingStatus, .confirmed)
        
        // Test second item
        let secondItem = result.reservedItems.lists[1]
        XCTAssertEqual(secondItem.reservedTypeId, 180)
        XCTAssertEqual(secondItem.cmBookingId, 77)
        XCTAssertEqual(secondItem.unitCount, 2)
        XCTAssertEqual(secondItem.hmsReservationId, nil)
        XCTAssertEqual(secondItem.reservedType, .roomType)
        XCTAssertEqual(secondItem.cmBookingStatus, .request)
    }
    
    func testFetchByMonth_WithEmptyResponse_WillSucceed() async throws {
        // Given
        let expectedResponse = CMCalendarServiceResponse.CMCalendarMonth(
            month: Date(timeIntervalSince1970: 1714521600), // 2024-05-01
            reservedItems: .init()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)

        let service = CMCalendarRemoteService(localStorage: localStorage,
                                            apiManager: apiManager)
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 105,
            month: Date(timeIntervalSince1970: 1714521600) // 2024-05-01
        )

        // When
        let result = try await service.fetchByMonth(request: request)

        // Then
        XCTAssertEqual(result.reservedItems.count, 0)
        XCTAssertEqual(result.month.timeIntervalSince1970, expectedResponse.month.timeIntervalSince1970, accuracy: 1.0)
    }
    
    func testFetchByMonth_WithDifferentMonth_WillUseCorrectRequest() async throws {
        // Given
        let decemberDate = Date(timeIntervalSince1970: 1733011200) // 2024-12-01
        let expectedResponse = CMCalendarServiceResponse.CMCalendarMonth(
            month: decemberDate,
            reservedItems: .init()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)

        let service = CMCalendarRemoteService(localStorage: localStorage,
                                            apiManager: apiManager)
        let request = CMCalendarServiceRequest.FetchByMonth(
            hotelId: 200,
            month: decemberDate
        )

        // When
        let result = try await service.fetchByMonth(request: request)

        // Then
        XCTAssertEqual(result.month.timeIntervalSince1970, decemberDate.timeIntervalSince1970, accuracy: 1.0)
        XCTAssertEqual(result.reservedItems.count, 0)
    }
} 
