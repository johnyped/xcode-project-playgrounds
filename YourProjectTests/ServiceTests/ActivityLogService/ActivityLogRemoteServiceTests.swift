//
//  ActivityLogRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/7/2568 BE.
//

import XCTest
import Mockable

final class ActivityLogRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchCreatorByFinancialRecord_WillGetValidResponse() async throws {
        // Given
        let expectedCreator = Creator(
            id: 38,
            email: "test1@email.com",
            firstName: "John",
            lastName: "Doe",
            logoImage: nil,
            staffId: nil,
            role: .supportSuperAdmin
        )
        // Stub the API manager to return the expected creator
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCreator)

        let service = ActivityLogRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = ActivityLogServiceRequest.FetchCreatorByFinancialRecord(
            hotelId: 105,
            financialRecordId: 440
        )

        // When
        let result = try await service.fetchCreatorByFinancialRecord(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCreator.id)
        XCTAssertEqual(result.email, expectedCreator.email)
        XCTAssertEqual(result.firstName, expectedCreator.firstName)
        XCTAssertEqual(result.lastName, expectedCreator.lastName)
        XCTAssertEqual(result.role, expectedCreator.role)
    }

    func testFetchCreatorByReservation_WillGetValidResponse() async throws {
        // Given
        let expectedCreator = Creator(
            id: 25,
            email: "manager@email.com",
            firstName: "Jane",
            lastName: "Smith",
            logoImage: nil,
            staffId: 1,
            role: .user
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCreator)

        let service = ActivityLogRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ActivityLogServiceRequest.FetchCreatorByReservation(
            hotelId: 105,
            reservationId: 273
        )

        // When
        let result = try await service.fetchCreatorByReservation(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCreator.id)
        XCTAssertEqual(result.email, expectedCreator.email)
        XCTAssertEqual(result.firstName, expectedCreator.firstName)
        XCTAssertEqual(result.lastName, expectedCreator.lastName)
        XCTAssertEqual(result.staffId, expectedCreator.staffId)
        XCTAssertEqual(result.role, expectedCreator.role)
    }

    func testFetchCreatorByAdditional_WillGetValidResponse() async throws {
        // Given
        let expectedCreator = Creator(
            id: 12,
            email: "frontdesk@email.com",
            firstName: "Mike",
            lastName: "Johnson",
            logoImage: nil,
            staffId: 2,
            role: .user
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCreator)

        let service = ActivityLogRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ActivityLogServiceRequest.FetchCreatorByAdditional(
            hotelId: 105,
            additionalId: 273
        )

        // When
        let result = try await service.fetchCreatorByAdditional(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCreator.id)
        XCTAssertEqual(result.email, expectedCreator.email)
        XCTAssertEqual(result.firstName, expectedCreator.firstName)
        XCTAssertEqual(result.lastName, expectedCreator.lastName)
        XCTAssertEqual(result.logoImage, expectedCreator.logoImage)
        XCTAssertEqual(result.staffId, expectedCreator.staffId)
        XCTAssertEqual(result.role, expectedCreator.role)
    }

    func testFetchCreatorByAccount_WillGetValidResponse() async throws {
        // Given
        let expectedCreator = Creator(
            id: 15,
            email: "admin@email.com",
            firstName: "Alice",
            lastName: "Brown",
            logoImage: nil,
            staffId: nil,
            role: .admin
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCreator)

        let service = ActivityLogRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ActivityLogServiceRequest.FetchCreatorByAccount(
            hotelId: 105,
            accountId: 1
        )

        // When
        let result = try await service.fetchCreatorByAccount(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCreator.id)
        XCTAssertEqual(result.email, expectedCreator.email)
        XCTAssertEqual(result.firstName, expectedCreator.firstName)
        XCTAssertEqual(result.lastName, expectedCreator.lastName)
        XCTAssertEqual(result.role, expectedCreator.role)
    }

    func testFetchCreatorByAccountItem_WillGetValidResponse() async throws {
        // Given
        let expectedCreator = Creator(
            id: 8,
            email: "user@email.com",
            firstName: "Bob",
            lastName: "Wilson",
            logoImage: nil,
            staffId: 3,
            role: .user
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCreator)

        let service = ActivityLogRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = ActivityLogServiceRequest.FetchCreatorByAccountItem(
            hotelId: 105,
            accountItemId: 1
        )

        // When
        let result = try await service.fetchCreatorByAccountItem(request: request)

        // Then
        XCTAssertEqual(result.id, expectedCreator.id)
        XCTAssertEqual(result.email, expectedCreator.email)
        XCTAssertEqual(result.firstName, expectedCreator.firstName)
        XCTAssertEqual(result.lastName, expectedCreator.lastName)
        XCTAssertEqual(result.staffId, expectedCreator.staffId)
        XCTAssertEqual(result.role, expectedCreator.role)
    }
} 