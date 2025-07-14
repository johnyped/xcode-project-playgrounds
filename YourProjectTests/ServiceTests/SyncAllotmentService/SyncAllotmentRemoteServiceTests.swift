//  SyncAllotmentRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/1/2568 BE.
//

import XCTest
import Mockable

final class SyncAllotmentRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        
        let expectedAllotment = CMSyncAllotment(
            id: 1,
            status: .pending,
            startDate: Date(),
            endDate: Date(),
            result: [:],
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
            )
        
        // Stub the API manager to return the expected allotment
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAllotment)

        let service = SyncAllotmentRemoteService(localStorage: localStorage,
                                               apiManager: apiManager)
        let request = SyncAllotmentServiceRequest.FetchById(
            id: 105
        )

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAllotment.id)
        XCTAssertEqual(result.status, expectedAllotment.status)
        XCTAssertEqual(result.startDate, expectedAllotment.startDate)
        XCTAssertEqual(result.endDate, expectedAllotment.endDate)
        
        XCTAssertEqual(result.hotelId, expectedAllotment.hotelId)
    }

    func testCreateSyncAllotment_WillGetValidResponse() async throws {
        // Given
        let expectedAllotment = CMSyncAllotment(
            id: 1,
            status: .pending,
            startDate: Date(),
            endDate: Date(),
            result: [:],
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAllotment)

        let service = SyncAllotmentRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = SyncAllotmentServiceRequest.CreateSyncAllotment(
            hotelId: 105
        )

        // When
        let result = try await service.createSyncAllotment(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAllotment.id)
        XCTAssertEqual(result.status, expectedAllotment.status)
        XCTAssertEqual(result.startDate, expectedAllotment.startDate)
        XCTAssertEqual(result.endDate, expectedAllotment.endDate)
        XCTAssertEqual(result.hotelId, expectedAllotment.hotelId)
    }
} 
