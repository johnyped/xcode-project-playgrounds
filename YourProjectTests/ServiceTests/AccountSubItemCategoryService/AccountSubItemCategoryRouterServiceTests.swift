//
//  AccountSubItemCategoryRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class AccountSubItemCategoryRouterServiceTests: XCTestCase {

    // MARK: - FetchByHotel Tests

    func testFetchByHotel_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending
        )
        let router = AccountSubItemCategoryServiceRouter.fetchByHotel(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    // MARK: - FetchByAccountItemCategory Tests

    func testFetchByAccountItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory(
            hotelId: 105,
            accountItemCategoryId: 2
        )
        let router = AccountSubItemCategoryServiceRouter.fetchByAccountItemCategory(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories/account-item-categories") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    // MARK: - FetchById Tests

    func testFetchById_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchById(id: 5)
        let router = AccountSubItemCategoryServiceRouter.fetchById(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories/5") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
    }

    // MARK: - CreateAccountSubItemCategory Tests

    func testCreateAccountSubItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory(
            hotelId: 105,
            name: "New Sub Category",
            accountItemCategoryId: 3
        )
        let router = AccountSubItemCategoryServiceRouter.createAccountSubItemCategory(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)

        // Verify body content
        let body = try XCTUnwrap(urlRequest.httpBody)
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(jsonObject["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject["name"] as? String, "New Sub Category")
        XCTAssertEqual(jsonObject["account_item_category_id"] as? Int, 3)
    }

    // MARK: - UpdateAccountSubItemCategory Tests

    func testUpdateAccountSubItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 2,
            name: "Updated Sub Category",
            accountItemCategoryId: 4
        )
        let router = AccountSubItemCategoryServiceRouter.updateAccountSubItemCategory(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories/2") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)

        // Verify body content
        let body = try XCTUnwrap(urlRequest.httpBody)
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Updated Sub Category")
        XCTAssertEqual(jsonObject["account_item_category_id"] as? Int, 4)
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }

    func testUpdateAccountSubItemCategory_WithPartialData_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 7,
            name: "Partial Update",
            accountItemCategoryId: nil
        )
        let router = AccountSubItemCategoryServiceRouter.updateAccountSubItemCategory(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories/7") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)

        // Verify body content
        let body = try XCTUnwrap(urlRequest.httpBody)
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Partial Update")
        XCTAssertNil(jsonObject["account_item_category_id"])
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }

    // MARK: - DeleteAccountSubItemCategory Tests

    func testDeleteAccountSubItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.DeleteAccountSubItemCategory(id: 9)
        let router = AccountSubItemCategoryServiceRouter.deleteAccountSubItemCategory(request: request)

        // When
        let urlRequest = try router.asURLRequest()

        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-sub-item-categories/9") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
    }

    // MARK: - Path Tests

    func testRouter_WillReturnCorrectPaths() {
        // Test all router paths
        let fetchByHotelRequest = AccountSubItemCategoryServiceRequest.FetchByHotel(
            hotelId: 1,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let fetchByAccountItemCategoryRequest = AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory(
            hotelId: 1,
            accountItemCategoryId: 3
        )
        let fetchByIdRequest = AccountSubItemCategoryServiceRequest.FetchById(id: 5)
        let createRequest = AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory(
            hotelId: 1,
            name: "Test",
            accountItemCategoryId: 2
        )
        let updateRequest = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 2,
            name: nil,
            accountItemCategoryId: nil
        )
        let deleteRequest = AccountSubItemCategoryServiceRequest.DeleteAccountSubItemCategory(id: 7)

        XCTAssertEqual(AccountSubItemCategoryServiceRouter.fetchByHotel(request: fetchByHotelRequest).path, "/v4/account-sub-item-categories")
        XCTAssertEqual(AccountSubItemCategoryServiceRouter.fetchByAccountItemCategory(request: fetchByAccountItemCategoryRequest).path, "/v4/account-sub-item-categories/account-item-categories")
        XCTAssertEqual(AccountSubItemCategoryServiceRouter.fetchById(request: fetchByIdRequest).path, "/v4/account-sub-item-categories/5")
        XCTAssertEqual(AccountSubItemCategoryServiceRouter.createAccountSubItemCategory(request: createRequest).path, "/v4/account-sub-item-categories")
        XCTAssertEqual(AccountSubItemCategoryServiceRouter.updateAccountSubItemCategory(request: updateRequest).path, "/v4/account-sub-item-categories/2")
        XCTAssertEqual(AccountSubItemCategoryServiceRouter.deleteAccountSubItemCategory(request: deleteRequest).path, "/v4/account-sub-item-categories/7")
    }
} 
