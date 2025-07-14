//
//  AccountSubItemCategoryRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//

import XCTest
import Mockable

final class AccountSubItemCategoryRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<AccountSubItemCategory>(
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

        let service = AccountSubItemCategoryRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = AccountSubItemCategoryServiceRequest.FetchByHotel(
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

    func testFetchByAccountItemCategory_WillGetValidResponse() async throws {
        // Given
        let expectedResponse: AccountSubItemCategories = .init(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedResponse)

        let service = AccountSubItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory(
            hotelId: 105,
            accountItemCategoryId: 1
        )

        // When
        let result = try await service.fetchByAccountItemCategory(request: request)

        // Then
        XCTAssertEqual(result.count, expectedResponse.count)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given
        let expectedAccountSubItemCategory = AccountSubItemCategory(
            id: 1,
            name: "Repair & Maintenance",
            hotelId: 105,
            accountItemCategoryId: 1,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountSubItemCategory)

        let service = AccountSubItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountSubItemCategoryServiceRequest.FetchById(id: 1)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountSubItemCategory.id)
        XCTAssertEqual(result.name, expectedAccountSubItemCategory.name)
        XCTAssertEqual(result.hotelId, expectedAccountSubItemCategory.hotelId)
        XCTAssertEqual(result.accountItemCategoryId, expectedAccountSubItemCategory.accountItemCategoryId)
    }

    func testCreateAccountSubItemCategory_WillGetValidResponse() async throws {
        // Given
        let expectedAccountSubItemCategory = AccountSubItemCategory(
            id: 10,
            name: "New Sub Category",
            hotelId: 105,
            accountItemCategoryId: 2,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountSubItemCategory)

        let service = AccountSubItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory(
            hotelId: 105,
            name: "New Sub Category",
            accountItemCategoryId: 2
        )

        // When
        let result = try await service.createAccountSubItemCategory(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountSubItemCategory.id)
        XCTAssertEqual(result.name, expectedAccountSubItemCategory.name)
        XCTAssertEqual(result.hotelId, expectedAccountSubItemCategory.hotelId)
        XCTAssertEqual(result.accountItemCategoryId, expectedAccountSubItemCategory.accountItemCategoryId)
    }

    func testUpdateAccountSubItemCategory_WillGetValidResponse() async throws {
        // Given
        let expectedAccountSubItemCategory = AccountSubItemCategory(
            id: 1,
            name: "Updated Sub Category",
            hotelId: 105,
            accountItemCategoryId: 3,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountSubItemCategory)

        let service = AccountSubItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 1,
            name: "Updated Sub Category",
            accountItemCategoryId: 3
        )

        // When
        let result = try await service.updateAccountSubItemCategory(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountSubItemCategory.id)
        XCTAssertEqual(result.name, expectedAccountSubItemCategory.name)
        XCTAssertEqual(result.hotelId, expectedAccountSubItemCategory.hotelId)
        XCTAssertEqual(result.accountItemCategoryId, expectedAccountSubItemCategory.accountItemCategoryId)
    }

    func testDeleteAccountSubItemCategory_WillCompleteSuccessfully() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = AccountSubItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountSubItemCategoryServiceRequest.DeleteAccountSubItemCategory(id: 1)

        // When & Then (should not throw)
        try await service.deleteAccountSubItemCategory(request: request)
    }
} 
