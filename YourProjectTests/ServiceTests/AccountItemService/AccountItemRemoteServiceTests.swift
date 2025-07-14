//
//  AccountItemRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Mockable
import XCTest

final class AccountItemRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchByPeriod_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<AccountItem>(
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

        let service = AccountItemRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
        let startDate = Date(timeIntervalSince1970: 1_577_836_800)  // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1_735_689_600)  // 2024-12-31
        let request = AccountItemServiceRequest.FetchByPeriod(
            hotelId: 105,
            accountId: 1,
            periodDate: .init(
                start: startDate,
                end: endDate
            ),
            accountItemCategoryId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchByPeriod(request: request)

        // Then
        XCTAssertEqual(
            result.totalItems,
            expectedPaginator.totalItems
        )
    }

    func testFetchByKeyword_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<AccountItem>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = AccountItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let startDate = Date(timeIntervalSince1970: 1_577_836_800)  // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1_609_459_200)  // 2021-01-01
        let request = AccountItemServiceRequest.FetchByKeyword(
            query: "ค่าไฟ",
            hotelId: 105,
            accountId: 1,
            accountItemCategoryId: 1,
            periodDate: .init(
                start: startDate,
                end: endDate
            ),
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .descending
        )

        // When
        let result = try await service.fetchByKeyword(request: request)

        // Then
        XCTAssertEqual(result.totalItems, expectedPaginator.totalItems)
    }

    func testFetchById_WillGetValidResponse() async throws {
        // Given

        let expectedAccountItem = AccountItem(
            id: 12,
            currency: "THB",
            date: Date(timeIntervalSince1970: 1_714_857_600),
            amount: 222.0,
            buyAmountBeforeVat: 222.0,
            buyAmountVat: 10.0,
            sellAmountBeforeVat: 222.0,
            sellAmountVat: 10.0,
            accountId: 1,
            payeeId: 8,
            accountItemCategoryId: 1,
            createdAt: Date(timeIntervalSince1970: 1_714_857_600),
            updatedAt: Date(timeIntervalSince1970: 1_714_857_600)
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountItem)

        let service = AccountItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemServiceRequest.FetchById(id: 12)

        // When
        let result = try await service.fetchById(request: request)

        // Then
        XCTAssertEqual(result.id, expectedAccountItem.id)
        XCTAssertEqual(result.currency, expectedAccountItem.currency)
        XCTAssertEqual(result.amount, expectedAccountItem.amount)
        XCTAssertEqual(result.accountId, expectedAccountItem.accountId)
        XCTAssertEqual(result.payeeId, expectedAccountItem.payeeId)
    }

    func testCreateAccountItem_WillGetValidResponse() async throws {
        // Given
        let expectedAccountItem = AccountItem(
            id: 13,
            currency: "THB",
            date: Date(timeIntervalSince1970: 1_714_857_600),
            amount: 500.0,
            buyAmountBeforeVat: 222.0,
            buyAmountVat: 10.0,
            sellAmountBeforeVat: 222.0,
            sellAmountVat: 10.0,
            accountId: 1,
            payeeId: 8,
            accountItemCategoryId: 1,
            createdAt: Date(timeIntervalSince1970: 1_714_857_600),
            updatedAt: Date(timeIntervalSince1970: 1_714_857_600)
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountItem)

        let service = AccountItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemServiceRequest.CreateAccountItem(
            currency: "THB",
            memo: "test item",
            date: Date(timeIntervalSince1970: 1_714_857_600),
            amount: 500.0,
            accountId: 1,
            payeeId: 8,
            accountItemCategoryId: 1,
            accountSubItemCategoryId: 1
        )

        // When
        let result = try await service.createAccountItem(request: request)

        // Then
        XCTAssertEqual(result.currency, expectedAccountItem.currency)
        XCTAssertEqual(result.amount, expectedAccountItem.amount)
        XCTAssertEqual(result.accountId, expectedAccountItem.accountId)
    }

    func testUpdateAccountItem_WillGetValidResponse() async throws {
        // Given
        let expectedAccountItem = AccountItem(
            id: 12,
            currency: "USD",
            memo: "updated memo",
            date: Date(timeIntervalSince1970: 1_714_857_600),
            amount: 300.0,
            buyAmountBeforeVat: 222.0,
            buyAmountVat: 10.0,
            sellAmountBeforeVat: 222.0,
            sellAmountVat: 10.0,
            accountId: 2,
            payeeId: 9,
            accountItemCategoryId: 2,
            accountSubItemCategoryId: 2,
            createdAt: Date(timeIntervalSince1970: 1_714_857_600),
            updatedAt: Date(timeIntervalSince1970: 1_714_857_600)
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccountItem)

        let service = AccountItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemServiceRequest.UpdateAccountItem(
            id: 12,
            currency: "USD",
            memo: "updated memo",
            amount: 300.0,
            accountId: 2,
            payeeId: 9
        )

        // When
        let result = try await service.updateAccountItem(request: request)

        // Then
        XCTAssertEqual(result.currency, expectedAccountItem.currency)
        XCTAssertEqual(result.memo, expectedAccountItem.memo)
        XCTAssertEqual(result.amount, expectedAccountItem.amount)
    }

    func testDeleteAccountItem_WillCompleteSuccessfully() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = AccountItemRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = AccountItemServiceRequest.DeleteAccountItem(id: 12)

        // When & Then
        try await service.deleteAccountItem(request: request)
        // No assertion needed - if no error is thrown, the test passes
    }
}
