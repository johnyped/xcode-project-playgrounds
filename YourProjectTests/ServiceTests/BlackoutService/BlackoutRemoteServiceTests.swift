//
//  BlackoutRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import XCTest
import Mockable

final class BlackoutRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByPeriod_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<BlackoutUnit>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        // Stub the API manager to return the expected paginator
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = BlackoutRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = BlackoutServiceRequest.FetchByPeriod(
            hotelId: 105,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByPeriod(request: request)

        // Then
        XCTAssertEqual(result.totalItems,
                       expectedPaginator.totalItems)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let expectedBlackoutUnit = BlackoutUnit(
            id: 172,
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            startDate: Date(timeIntervalSince1970: 1716249600), // 2024-05-21
            endDate: Date(timeIntervalSince1970: 1716336000), // 2024-05-22
            removesDate: nil,
            note: "Test blackout",
            emoji: "🚫",
            quantity: 1,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBlackoutUnit)

        let service = BlackoutRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = BlackoutServiceRequest.FetchById(id: 172)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBlackoutUnit.id)
        XCTAssertEqual(result.hotelId, expectedBlackoutUnit.hotelId)
        XCTAssertEqual(result.unitableId, expectedBlackoutUnit.unitableId)
        XCTAssertEqual(result.unitableType, expectedBlackoutUnit.unitableType)
        XCTAssertEqual(result.quantity, expectedBlackoutUnit.quantity)
    }

    func testCreateBlackoutUnit_WillGetValidResponse() async throws {
        // Given
        let expectedBlackoutUnit = BlackoutUnit(
            id: 200,
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            startDate: Date(timeIntervalSince1970: 1716249600), // 2024-05-21
            endDate: Date(timeIntervalSince1970: 1716336000), // 2024-05-22
            removesDate: nil,
            note: "New blackout unit",
            emoji: "🚫",
            quantity: 2,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBlackoutUnit)

        let service = BlackoutRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = BlackoutServiceRequest.CreateBlackoutUnit(
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            period: .init(start: Date(timeIntervalSince1970: 1716249600),
                          end: Date(timeIntervalSince1970: 1716336000)),
            removesDate: nil,
            note: "New blackout unit",
            emoji: "🚫",
            quantity: 2
        )

        // When
        let result = try await service.createBlackoutUnit(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBlackoutUnit.id)
        XCTAssertEqual(result.hotelId, expectedBlackoutUnit.hotelId)
        XCTAssertEqual(result.unitableId, expectedBlackoutUnit.unitableId)
        XCTAssertEqual(result.note, expectedBlackoutUnit.note)
        XCTAssertEqual(result.quantity, expectedBlackoutUnit.quantity)
    }

    func testUpdateBlackoutUnit_WillGetValidResponse() async throws {
        // Given
        let expectedBlackoutUnit = BlackoutUnit(
            id: 172,
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            startDate: Date(timeIntervalSince1970: 1716249600),
            endDate: Date(timeIntervalSince1970: 1716336000),
            removesDate: Date(timeIntervalSince1970: 1716249600),
            note: "Updated blackout unit",
            emoji: "⚠️",
            quantity: 3,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBlackoutUnit)

        let service = BlackoutRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = BlackoutServiceRequest.UpdateBlackoutUnit(
            id: 172,
            note: "Updated blackout unit",
            emoji: "⚠️",
            removesDate: Date(timeIntervalSince1970: 1716249600)
        )

        // When
        let result = try await service.updateBlackoutUnit(request: request)

        // Then
        XCTAssertEqual(result.id, expectedBlackoutUnit.id)
        XCTAssertEqual(result.note, expectedBlackoutUnit.note)
        XCTAssertEqual(result.emoji, expectedBlackoutUnit.emoji)
        XCTAssertEqual(result.removesDate, expectedBlackoutUnit.removesDate)
    }

    func testDeleteBlackoutUnit_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = BlackoutRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = BlackoutServiceRequest.DeleteBlackoutUnit(id: 172)

        // When/Then
        do {
            try await service.deleteBlackoutUnit(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testBatchCreateBlackoutUnits_WillGetValidResponse() async throws {
        // Given
        let blackoutUnit1 = BlackoutUnit(
            id: 201,
            hotelId: 105,
            unitableId: 620,
            unitableType: .room,
            startDate: Date(timeIntervalSince1970: 1716249600),
            endDate: Date(timeIntervalSince1970: 1716336000),
            removesDate: nil,
            note: "Batch unit 1",
            emoji: "🚫",
            quantity: 1,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let blackoutUnit2 = BlackoutUnit(
            id: 202,
            hotelId: 105,
            unitableId: 621,
            unitableType: .room,
            startDate: Date(timeIntervalSince1970: 1716249600),
            endDate: Date(timeIntervalSince1970: 1716336000),
            removesDate: nil,
            note: "Batch unit 2",
            emoji: "🚫",
            quantity: 1,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let expectedBlackoutUnits = BlackoutUnits(array: [blackoutUnit1, blackoutUnit2])
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBlackoutUnits)

        let createRequest1 = BlackoutServiceRequest.BatchBlackoutUnit(
            unitableId: 620,
            unitableType: .room,
            period: .init(start: Date(timeIntervalSince1970: 1716249600),
                          end: Date(timeIntervalSince1970: 1716336000)),
            removesDate: nil,
            note: "Batch unit 1",
            emoji: "🚫",
            quantity: 1
        )
        
        let createRequest2 = BlackoutServiceRequest.BatchBlackoutUnit(
            unitableId: 621,
            unitableType: .room,
            period: .init(start: Date(timeIntervalSince1970: 1716249600),
                          end: Date(timeIntervalSince1970: 1716336000)),
            removesDate: nil,
            note: "Batch unit 2",
            emoji: "🚫",
            quantity: 1
        )

        let service = BlackoutRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = BlackoutServiceRequest.BatchCreateBlackoutUnits(
            hotelId: 105,
            blackoutUnits: [createRequest1, createRequest2],
            isDailyChunk: nil
        )

        // When
        let result = try await service.batchCreateBlackoutUnits(request: request)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, blackoutUnit1.id)
        XCTAssertEqual(result[1].id, blackoutUnit2.id)
    }

    func testBatchDeleteBlackoutUnits_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = BlackoutRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = BlackoutServiceRequest.BatchDeleteBlackoutUnits(
            hotelId: 105,
            ids: [172, 173, 174]
        )

        // When/Then
        do {
            try await service.batchDeleteBlackoutUnits(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Batch delete should not throw error")
        }
    }
} 
