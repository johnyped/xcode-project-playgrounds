//
//  AllotmentRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/1/2568 BE.
//

import XCTest
import Mockable

final class AllotmentRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByUnitType_WillGetValidResponse() async throws {
        // Given
        let expectedResult = UnitTypeAllotments(array: [])
        
        // Stub the API manager to return the expected result
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResult)

        // When
        let sut = AllotmentRemoteService(localStorage: localStorage, apiManager: apiManager)
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-04
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: [642, 643]
        )
        let response = try await sut.fetchByUnitType(request: request)

        // Then
        XCTAssertEqual(response.count, expectedResult.count)
    }
    
    func testFetchByMonth_WillGetValidResponse() async throws {
        // Given
        let month = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let expectedResult = AllotmentServiceResponse.AllotmentMonth(
            month: month,
            allotments: UnitTypeAllotments(array: [])
        )
        
        // Stub the API manager to return the expected result
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResult)

        // When
        let sut = AllotmentRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        let response = try await sut.fetchByMonth(request: request)

        // Then
        XCTAssertEqual(response.month, expectedResult.month)
        XCTAssertEqual(response.allotments.count, expectedResult.allotments.count)
    }

    func testFetchByUnitType_WillCallAPIManagerWithCorrectRouter() async throws {
        // Given
        let expectedResult = UnitTypeAllotments(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResult)

        // When
        let sut = AllotmentRemoteService(localStorage: localStorage, apiManager: apiManager)
        let period = PeriodDate(start: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                               end: Date(timeIntervalSince1970: 1578009600)) // 2020-01-04
        let request = AllotmentServiceRequest.FetchByUnitType(
            hotelId: 105,
            unitTypeId: 179,
            unitType: .roomType,
            period: period,
            unitIds: [642, 643]
        )
        _ = try await sut.fetchByUnitType(request: request)

        // Then
        verify(apiManager)
            .request(router: .any,
                    requiredAuthorization: .value(true))
            .called(1)
    }

    func testFetchByMonth_WillCallAPIManagerWithCorrectRouter() async throws {
        // Given
        let month = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let expectedResult = AllotmentServiceResponse.AllotmentMonth(
            month: month,
            allotments: UnitTypeAllotments(array: [])
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResult)

        // When
        let sut = AllotmentRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AllotmentServiceRequest.FetchByMonth(
            hotelId: 105,
            month: month
        )
        _ = try await sut.fetchByMonth(request: request)

        // Then
        verify(apiManager)
            .request(router: .any,
                    requiredAuthorization: .value(true))
            .called(1)
    }
} 
