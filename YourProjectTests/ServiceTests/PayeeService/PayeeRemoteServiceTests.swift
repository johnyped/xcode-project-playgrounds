//
//  PayeeRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest
import Mockable

final class PayeeRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<Payee>(
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

        let service = PayeeRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = PayeeServiceRequest.FetchByHotel(
            hotelId: 105,
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

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let expectedPayee = Payee(
            id: 1,
            name: "ค่าไฟ้า",
            memo: "memo",
            buyVatType: .sevenPercent,
            sellVatType: .sevenPercent,
            hotelId: 105,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPayee)

        let service = PayeeRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = PayeeServiceRequest.FetchById(id: 1)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedPayee.id)
        XCTAssertEqual(result.name, expectedPayee.name)
        XCTAssertEqual(result.memo, expectedPayee.memo)
        XCTAssertEqual(result.buyVatType, expectedPayee.buyVatType)
        XCTAssertEqual(result.sellVatType, expectedPayee.sellVatType)
        XCTAssertEqual(result.hotelId, expectedPayee.hotelId)
        XCTAssertEqual(result.accountItemCategoryId, expectedPayee.accountItemCategoryId)
        XCTAssertEqual(result.accountSubItemCategoryId, expectedPayee.accountSubItemCategoryId)
    }

    func testCreatePayee_WillGetValidResponse() async throws {
        // Given
        let expectedPayee = Payee(
            id: 2,
            name: "ค่าน้ำ",
            memo: "water bill",
            buyVatType: .noVat,
            sellVatType: .noVat,
            hotelId: 105,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: 1,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPayee)

        let service = PayeeRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = PayeeServiceRequest.CreatePayee(
            hotelId: 105,
            name: "ค่าน้ำ",
            memo: "water bill",
            buyVatType: .noVat,
            sellVatType: .noVat,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: 1
        )

        // When
        let result = try await service.createPayee(request: request)

        // Then
        XCTAssertEqual(result.name, expectedPayee.name)
        XCTAssertEqual(result.memo, expectedPayee.memo)
        XCTAssertEqual(result.buyVatType, expectedPayee.buyVatType)
        XCTAssertEqual(result.sellVatType, expectedPayee.sellVatType)
    }

    func testUpdatePayee_WillGetValidResponse() async throws {
        // Given
        let expectedPayee = Payee(
            id: 1,
            name: "ค่าไฟ้า (Updated)",
            memo: "updated memo",
            buyVatType: .tenPercent,
            sellVatType: .tenPercent,
            hotelId: 105,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: 2,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPayee)

        let service = PayeeRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = PayeeServiceRequest.UpdatePayee(
            id: 1,
            name: "ค่าไฟ้า (Updated)",
            memo: "updated memo",
            buyVatType: .tenPercent,
            sellVatType: .tenPercent,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: 2
        )

        // When
        let result = try await service.updatePayee(request: request)

        // Then
        XCTAssertEqual(result.name, expectedPayee.name)
        XCTAssertEqual(result.memo, expectedPayee.memo)
        XCTAssertEqual(result.buyVatType, expectedPayee.buyVatType)
        XCTAssertEqual(result.sellVatType, expectedPayee.sellVatType)
    }

    func testDeletePayee_WillCompleteSuccessfully() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = PayeeRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = PayeeServiceRequest.DeletePayee(id: 1)

        // When & Then
        try await service.deletePayee(request: request)
        // No assertion needed - if no error is thrown, the test passes
    }
} 
