//
//  AccountItemRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class AccountItemRouterServiceTests: XCTestCase {
    
    func testFetchByPeriodRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1735689600) // 2024-12-31
        let request = AccountItemServiceRequest.FetchByPeriod(
            hotelId: 105,
            accountId: 1,
            periodDate: .init(start: startDate,
                              end: endDate),
            accountItemCategoryId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let router = AccountItemServiceRouter.fetchByPeriod(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/period")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["start_datetime"])
        XCTAssertNotNil(parameters?["end_datetime"])
        XCTAssertEqual(parameters?["account_item_category_id"] as? Int, 1)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByKeywordRouter_WillHaveCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800)
        let endDate = Date(timeIntervalSince1970: 1609459200)
        let request = AccountItemServiceRequest.FetchByKeyword(
            query: "ค่าไฟ",
            hotelId: 105,
            accountId: 1,
            accountItemCategoryId: 1,
            periodDate: .init(start: startDate,
                              end: endDate),
            page: 1,
            perPage: .fifty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // When
        let router = AccountItemServiceRouter.fetchByKeyword(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/keyword")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["q"] as? String, "ค่าไฟ")
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
        XCTAssertEqual(parameters?["account_item_category_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["start_datetime"])
        XCTAssertNotNil(parameters?["end_datetime"])
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByIdRouter_WillHaveCorrectPath() throws {
        // Given
        let request = AccountItemServiceRequest.FetchById(id: 12)
        
        // When
        let router = AccountItemServiceRouter.fetchById(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/12")
        XCTAssertEqual(router.method.rawValue, "GET")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testCreateAccountItemRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1591326103)
        let request = AccountItemServiceRequest.CreateAccountItem(
            currency: "THB",
            memo: "test memo",
            date: testDate,
            amount: 222.0,
            accountId: 1,
            payeeId: 8,
            accountItemCategoryId: 1,
            accountSubItemCategoryId: 1
        )
        
        // When
        let router = AccountItemServiceRouter.createAccountItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items")
        XCTAssertEqual(router.method.rawValue, "POST")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testUpdateAccountItemRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1591326103)
        let request = AccountItemServiceRequest.UpdateAccountItem(
            id: 12,
            currency: "USD",
            memo: "updated memo",
            date: testDate,
            amount: 300.0,
            accountId: 2,
            payeeId: 9
        )
        
        // When
        let router = AccountItemServiceRouter.updateAccountItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/12")
        XCTAssertEqual(router.method.rawValue, "PUT")
        XCTAssertNil(router.parameters)
        XCTAssertNotNil(router.body)
    }
    
    func testDeleteAccountItemRouter_WillHaveCorrectMethodAndPath() throws {
        // Given
        let request = AccountItemServiceRequest.DeleteAccountItem(id: 12)
        
        // When
        let router = AccountItemServiceRouter.deleteAccountItem(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/12")
        XCTAssertEqual(router.method.rawValue, "DELETE")
        XCTAssertNil(router.parameters)
        XCTAssertNil(router.body)
    }
    
    func testFetchByPeriodRouter_WithNilOptionalValues_WillHaveMinimalParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800)
        let endDate = Date(timeIntervalSince1970: 1609459200)
        let request = AccountItemServiceRequest.FetchByPeriod(
            hotelId: 105,
            accountId: 1,
            periodDate: .init(start: startDate,
                              end: endDate),
            accountItemCategoryId: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let router = AccountItemServiceRouter.fetchByPeriod(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/period")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["start_datetime"])
        XCTAssertNotNil(parameters?["end_datetime"])
        XCTAssertNil(parameters?["account_item_category_id"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testFetchByKeywordRouter_WithNilOptionalValues_WillHaveMinimalParameters() throws {
        // Given
        let request = AccountItemServiceRequest.FetchByKeyword(
            query: "search",
            hotelId: 105,
            accountId: 1,
            accountItemCategoryId: nil,
            periodDate: .init(start: Date(timeIntervalSince1970: 1577836800),
                              end: Date(timeIntervalSince1970: 1609459200)),
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let router = AccountItemServiceRouter.fetchByKeyword(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/account-items/keyword")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["q"] as? String, "search")
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
        XCTAssertNil(parameters?["account_item_category_id"])
        XCTAssertNotNil(parameters?["start_datetime"])
        XCTAssertNotNil(parameters?["end_datetime"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testCreateAccountItemRouter_WillHaveCorrectHeaders() throws {
        // Given
        let testDate = Date()
        let request = AccountItemServiceRequest.CreateAccountItem(
            currency: "THB",
            date: testDate,
            amount: 100.0,
            accountId: 1,
            payeeId: 8,
            accountItemCategoryId: 1
        )
        
        // When
        let router = AccountItemServiceRouter.createAccountItem(request: request)
        
        // Then
        let headers = router.headers
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    func testUpdateAccountItemRouter_WillHaveCorrectHeaders() throws {
        // Given
        let request = AccountItemServiceRequest.UpdateAccountItem(
            id: 12,
            currency: "USD",
            amount: 200.0
        )
        
        // When
        let router = AccountItemServiceRouter.updateAccountItem(request: request)
        
        // Then
        let headers = router.headers
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
} 
