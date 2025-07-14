//
//  AccountItemCategoryRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class AccountItemCategoryRouterServiceTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.FetchByHotel(
            hotelId: 105,
            kind: .expense,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending
        )
        let router = AccountItemCategoryServiceRouter.fetchByHotel(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // MARK: - FetchById Tests
    
    func testFetchById_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.FetchById(id: 5)
        let router = AccountItemCategoryServiceRouter.fetchById(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories/5") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - FetchSubCategories Tests
    
    func testFetchSubCategories_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.FetchSubCategories(id: 3)
        let router = AccountItemCategoryServiceRouter.fetchSubCategories(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories/3/sub-categories") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - CreateAccountItemCategory Tests
    
    func testCreateAccountItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.CreateAccountItemCategory(
            hotelId: 105,
            name: "New Category",
            kind: .income,
            iconRef: 7
        )
        let router = AccountItemCategoryServiceRouter.createAccountItemCategory(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
        
        // Verify body content
        let body = try XCTUnwrap(urlRequest.httpBody)
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(jsonObject["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject["name"] as? String, "New Category")
        XCTAssertEqual(jsonObject["kind"] as? String, "INCOME")
        XCTAssertEqual(jsonObject["icon_ref"] as? Int, 7)
    }
    
    // MARK: - UpdateAccountItemCategory Tests
    
    func testUpdateAccountItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 2,
            name: "Updated Category",
            iconRef: 4
        )
        let router = AccountItemCategoryServiceRouter.updateAccountItemCategory(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories/2") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
        
        // Verify body content
        let body = try XCTUnwrap(urlRequest.httpBody)
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Updated Category")
        XCTAssertEqual(jsonObject["icon_ref"] as? Int, 4)
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
    
    func testUpdateAccountItemCategory_WithPartialData_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 7,
            name: "Partial Update",
            iconRef: nil
        )
        let router = AccountItemCategoryServiceRouter.updateAccountItemCategory(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories/7") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNotNil(urlRequest.httpBody)
        
        // Verify body content
        let body = try XCTUnwrap(urlRequest.httpBody)
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Partial Update")
        XCTAssertNil(jsonObject["icon_ref"])
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
    
    // MARK: - DeleteAccountItemCategory Tests
    
    func testDeleteAccountItemCategory_WillGenerateCorrectRoute() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.DeleteAccountItemCategory(id: 9)
        let router = AccountItemCategoryServiceRouter.deleteAccountItemCategory(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/account-item-categories/9") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertNil(urlRequest.httpBody)
    }
    
    // MARK: - Path Tests
    
    func testRouter_WillReturnCorrectPaths() {
        // Test all router paths
        let fetchByHotelRequest = AccountItemCategoryServiceRequest.FetchByHotel(
            hotelId: 1,
            kind: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        let fetchByIdRequest = AccountItemCategoryServiceRequest.FetchById(id: 5)
        let fetchSubCategoriesRequest = AccountItemCategoryServiceRequest.FetchSubCategories(id: 3)
        let createRequest = AccountItemCategoryServiceRequest.CreateAccountItemCategory(
            hotelId: 1, name: "Test",
            kind: .expense,
            iconRef: 1
        )
        let updateRequest = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 2,
            name: nil,
            iconRef: nil
        )
        let deleteRequest = AccountItemCategoryServiceRequest.DeleteAccountItemCategory(id: 7)
        
        XCTAssertEqual(AccountItemCategoryServiceRouter.fetchByHotel(request: fetchByHotelRequest).path, "/v4/account-item-categories")
        XCTAssertEqual(AccountItemCategoryServiceRouter.fetchById(request: fetchByIdRequest).path, "/v4/account-item-categories/5")
        XCTAssertEqual(AccountItemCategoryServiceRouter.fetchSubCategories(request: fetchSubCategoriesRequest).path, "/v4/account-item-categories/3/sub-categories")
        XCTAssertEqual(AccountItemCategoryServiceRouter.createAccountItemCategory(request: createRequest).path, "/v4/account-item-categories")
        XCTAssertEqual(AccountItemCategoryServiceRouter.updateAccountItemCategory(request: updateRequest).path, "/v4/account-item-categories/2")
        XCTAssertEqual(AccountItemCategoryServiceRouter.deleteAccountItemCategory(request: deleteRequest).path, "/v4/account-item-categories/7")
    }
}
