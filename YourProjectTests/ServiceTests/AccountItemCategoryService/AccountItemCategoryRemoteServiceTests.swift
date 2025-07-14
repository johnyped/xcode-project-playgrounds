//
//  AccountItemCategoryRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//

import XCTest
import Mockable

final class AccountItemCategoryRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByHotel_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<AccountItemCategory>(
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

        let service = AccountItemCategoryRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = AccountItemCategoryServiceRequest.FetchByHotel(
            hotelId: 105,
            kind: .expense,
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
        let expectedAccountItemCategory = AccountItemCategory(
            id: 1,
            name: "Food & Beverage",
            kind: .expense,
            iconRef: 5,
            accountSubItemCategoryIds: [1, 2],
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountItemCategory)

        let service = AccountItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemCategoryServiceRequest.FetchById(id: 1)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountItemCategory.id)
        XCTAssertEqual(result.name, expectedAccountItemCategory.name)
        XCTAssertEqual(result.kind, expectedAccountItemCategory.kind)
        XCTAssertEqual(result.iconRef, expectedAccountItemCategory.iconRef)
    }

    func testFetchSubCategories_WillGetValidResponse() async throws {
        // Given
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(AccountSubItemCategories(array: []))

        let service = AccountItemCategoryRemoteService(localStorage: localStorage,
                                                       apiManager: apiManager)
        let request = AccountItemCategoryServiceRequest.FetchSubCategories(id: 1)

        // When
        let result = try await service.fetchSubCategories(request: request)

        // Then
        XCTAssertEqual(result.count, 0)
    }

    func testCreateAccountItemCategory_WillGetValidResponse() async throws {
        // Given
        let expectedAccountItemCategory = AccountItemCategory(
            id: 10,
            name: "New Category",
            kind: .income,
            iconRef: 3,
            accountSubItemCategoryIds: [],
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountItemCategory)

        let service = AccountItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemCategoryServiceRequest.CreateAccountItemCategory(
            hotelId: 105,
            name: "New Category",
            kind: .income,
            iconRef: 3
        )

        // When
        let result = try await service.createAccountItemCategory(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountItemCategory.id)
        XCTAssertEqual(result.name, expectedAccountItemCategory.name)
        XCTAssertEqual(result.kind, expectedAccountItemCategory.kind)
        XCTAssertEqual(result.iconRef, expectedAccountItemCategory.iconRef)
    }

    func testUpdateAccountItemCategory_WillGetValidResponse() async throws {
        // Given
        let expectedAccountItemCategory = AccountItemCategory(
            id: 1,
            name: "Updated Category",
            kind: .expense,
            iconRef: 7,
            accountSubItemCategoryIds: [1],
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountItemCategory)

        let service = AccountItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 1,
            name: "Updated Category",
            iconRef: 7
        )

        // When
        let result = try await service.updateAccountItemCategory(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountItemCategory.id)
        XCTAssertEqual(result.name, expectedAccountItemCategory.name)
        XCTAssertEqual(result.kind, expectedAccountItemCategory.kind)
        XCTAssertEqual(result.iconRef, expectedAccountItemCategory.iconRef)
    }

    func testDeleteAccountItemCategory_WillCompleteSuccessfully() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = AccountItemCategoryRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemCategoryServiceRequest.DeleteAccountItemCategory(id: 1)

        // When & Then (should not throw)
        try await service.deleteAccountItemCategory(request: request)
    }
} 
