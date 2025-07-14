//
//  FinancialRecordRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest
import Mockable

final class FinancialRecordRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<FinancialRecord>(
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

        let service = FinancialRecordRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = FinancialRecordServiceRequest.FetchByHotel(
            hotelId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByHotel(request: request)

        // Then
        XCTAssertEqual(result.totalItems,
                       expectedPaginator.totalItems)
    }

    func testFetchByPeriod_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<FinancialRecord>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2024-12-31
        let period = PeriodDate(start: startDate, end: endDate)

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.FetchByPeriod(
            hotelId: 1,
            period: period,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )

        // When
        let result = try await service.fetchByPeriod(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchByReservation_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<FinancialRecord>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.FetchByReservation(
            hotelId: 1,
            reservationId: 1061,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByReservation(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchByCreatedAt_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<FinancialRecord>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let startDate = Date(timeIntervalSince1970: 1714129200) // 2025-04-26T20:20:00+07:00 equivalent
        let endDate = Date(timeIntervalSince1970: 1714215600) // 2025-04-27T20:20:00+07:00 equivalent  
        let periodDate = PeriodDate(start: startDate, end: endDate)

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.FetchByCreatedAt(
            hotelId: 1,
            periodDate: periodDate,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByCreatedAt(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchByAccountItem_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<FinancialRecord>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.FetchByAccountItem(
            hotelId: 1,
            accountItemId: 2,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByAccountItem(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let expectedFinancialRecord = FinancialRecord(
            id: 439,
            name: "PAYMENT",
            paymentMethod: "Bank Transfer",
            note: nil,
            timestamp: Date(),
            amount: 3940.0,
            recordableId: 1061,
            recordableType: .reservation,
            createdAt: Date(),
            updatedAt: Date(),
            hotelId: 105,
            bankAccountId: nil
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFinancialRecord)

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.FetchById(id: 439)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFinancialRecord.id)
        XCTAssertEqual(result.name, expectedFinancialRecord.name)
        XCTAssertEqual(result.paymentMethod, expectedFinancialRecord.paymentMethod)
        XCTAssertEqual(result.amount, expectedFinancialRecord.amount)
        XCTAssertEqual(result.hotelId, expectedFinancialRecord.hotelId)
    }

    func testCreateFinancialRecord_WillGetValidResponse() async throws {
        // Given
        let expectedFinancialRecord = FinancialRecord(
            id: 500,
            name: "NEW PAYMENT",
            paymentMethod: "Credit Card",
            note: "Test payment",
            timestamp: Date(),
            amount: 1500.0,
            recordableId: 1070,
            recordableType: .reservation,
            createdAt: Date(),
            updatedAt: Date(),
            hotelId: 105,
            bankAccountId: nil
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFinancialRecord)

        let timestamp = Date(timeIntervalSince1970: 1713254537) // 2024-04-16T15:52:17.285+07:00 equivalent
        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.CreateFinancialRecord(
            hotelId: 105,
            name: "NEW PAYMENT",
            paymentMethod: "Credit Card",
            note: "Test payment",
            timestamp: timestamp,
            amount: 1500.0,
            recordableId: 1070,
            recordableType: .reservation,
            bankAccountId: nil
        )

        // When
        let result = try await service.createFinancialRecord(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFinancialRecord.id)
        XCTAssertEqual(result.name, expectedFinancialRecord.name)
        XCTAssertEqual(result.paymentMethod, expectedFinancialRecord.paymentMethod)
        XCTAssertEqual(result.amount, expectedFinancialRecord.amount)
    }

    func testUpdateFinancialRecord_WillGetValidResponse() async throws {
        // Given
        let expectedFinancialRecord = FinancialRecord(
            id: 439,
            name: "UPDATED PAYMENT",
            paymentMethod: "Cash",
            note: "Updated note",
            timestamp: Date(),
            amount: 2000.0,
            recordableId: 1061,
            recordableType: .reservation,
            createdAt: Date(),
            updatedAt: Date(),
            hotelId: 105,
            bankAccountId: nil
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFinancialRecord)

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.UpdateFinancialRecord(
            id: 439,
            name: "UPDATED PAYMENT",
            paymentMethod: "Cash",
            note: "Updated note",
            timestamp: nil,
            amount: 2000.0,
            recordableId: nil,
            recordableType: nil,
            bankAccountId: nil
        )

        // When
        let result = try await service.updateFinancialRecord(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFinancialRecord.id)
        XCTAssertEqual(result.name, expectedFinancialRecord.name)
        XCTAssertEqual(result.paymentMethod, expectedFinancialRecord.paymentMethod)
        XCTAssertEqual(result.amount, expectedFinancialRecord.amount)
    }

    func testDeleteFinancialRecord_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = FinancialRecordRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FinancialRecordServiceRequest.DeleteFinancialRecord(id: 439)

        // When/Then
        do {
            try await service.deleteFinancialRecord(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }
} 