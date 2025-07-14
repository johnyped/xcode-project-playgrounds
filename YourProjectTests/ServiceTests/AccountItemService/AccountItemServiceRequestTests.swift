//
//  AccountItemServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class AccountItemServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByPeriod Tests
    
    func testFetchByPeriod_WillGenerateCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        let request = AccountItemServiceRequest.FetchByPeriod(
            hotelId: 105,
            accountId: 1,
            periodDate: .init(start: startDate,
                              end: endDate),
            accountItemCategoryId: 1,
            page: 2,
            perPage: .fifty,
            sortedBy: .id,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["start_datetime"])
        XCTAssertNotNil(parameters?["end_datetime"])
        XCTAssertEqual(parameters?["account_item_category_id"] as? Int, 1)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByPeriod_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
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
        let parameters = request.parameters
        
        // Then
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
    
    // MARK: - FetchByKeyword Tests
    
    func testFetchByKeyword_WillGenerateCorrectParameters() throws {
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
            perPage: .hundred,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["q"] as? String, "ค่าไฟ")
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_id"] as? Int, 1)
        XCTAssertEqual(parameters?["account_item_category_id"] as? Int, 1)
        XCTAssertNotNil(parameters?["start_datetime"])
        XCTAssertNotNil(parameters?["end_datetime"])
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByKeyword_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let request = AccountItemServiceRequest.FetchByKeyword(
            query: "search term",
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
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["q"] as? String, "search term")
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
    
    // MARK: - CreateAccountItem Tests
    
    func testCreateAccountItem_WillGenerateCorrectBody() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1591326103) // 2020-06-05T08:41:43
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
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["currency"] as? String, "THB")
        XCTAssertEqual(jsonObject?["memo"] as? String, "test memo")
        XCTAssertNotNil(jsonObject?["date"])
        XCTAssertEqual(jsonObject?["amount"] as? String, "222.0")
        XCTAssertEqual(jsonObject?["account_id"] as? Int, 1)
        XCTAssertEqual(jsonObject?["payee_id"] as? Int, 8)
        XCTAssertEqual(jsonObject?["account_item_category_id"] as? Int, 1)
        XCTAssertEqual(jsonObject?["account_sub_item_category_id"] as? Int, 1)
    }
    
    func testCreateAccountItem_WithNilMemo_WillGenerateCorrectBody() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1591326103)
        let request = AccountItemServiceRequest.CreateAccountItem(
            currency: "USD",
            memo: nil,
            date: testDate,
            amount: 100.0,
            accountId: 2,
            payeeId: 9,
            accountItemCategoryId: 2,
            accountSubItemCategoryId: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["currency"] as? String, "USD")
        XCTAssertNil(jsonObject?["memo"])
        XCTAssertEqual(jsonObject?["amount"] as? String, "100.0")        
        XCTAssertNil(jsonObject?["account_sub_item_category_id"])
    }
    
    // MARK: - UpdateAccountItem Tests
    
    func testUpdateAccountItem_WillGenerateCorrectBody() throws {
        // Given
        let testDate = Date(timeIntervalSince1970: 1591326103)
        let request = AccountItemServiceRequest.UpdateAccountItem(
            id: 12,
            currency: "EUR",
            memo: "updated memo",
            date: testDate,
            amount: 300.0,
            accountId: 3,
            payeeId: 10,
            accountItemCategoryId: 3,
            accountSubItemCategoryId: 3
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        // ID should not be in the body
        XCTAssertNil(jsonObject?["id"])
        XCTAssertEqual(jsonObject?["currency"] as? String, "EUR")
        XCTAssertEqual(jsonObject?["memo"] as? String, "updated memo")
        XCTAssertNotNil(jsonObject?["date"])
        XCTAssertEqual(jsonObject?["amount"] as? String, "300.0")
        XCTAssertEqual(jsonObject?["account_id"] as? Int, 3)
        XCTAssertEqual(jsonObject?["payee_id"] as? Int, 10)
    }
    
    func testUpdateAccountItem_WithNilOptionalValues_WillGenerateMinimalBody() throws {
        // Given
        let request = AccountItemServiceRequest.UpdateAccountItem(
            id: 12,
            currency: nil,
            memo: nil,
            date: nil,
            amount: nil,
            accountId: nil,
            payeeId: nil,
            accountItemCategoryId: nil,
            accountSubItemCategoryId: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        // All optional fields should be excluded
        XCTAssertNil(jsonObject?["currency"])
        XCTAssertNil(jsonObject?["memo"])
        XCTAssertNil(jsonObject?["date"])
        XCTAssertNil(jsonObject?["amount"])
        XCTAssertNil(jsonObject?["account_id"])
        XCTAssertNil(jsonObject?["payee_id"])
        XCTAssertNil(jsonObject?["account_item_category_id"])
        XCTAssertNil(jsonObject?["account_sub_item_category_id"])
    }
    
    func testUpdateAccountItem_WithPartialValues_WillGenerateCorrectBody() throws {
        // Given
        let request = AccountItemServiceRequest.UpdateAccountItem(
            id: 12,
            currency: "JPY",
            memo: nil,
            amount: 500.0,
            accountId: 4,
            payeeId: nil,
            accountItemCategoryId: 4
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["currency"] as? String, "JPY")
        XCTAssertNil(jsonObject?["memo"])
        XCTAssertEqual(jsonObject?["amount"] as? String, "500.0")
        XCTAssertEqual(jsonObject?["account_id"] as? Int, 4)
        XCTAssertNil(jsonObject?["payee_id"])
        XCTAssertEqual(jsonObject?["account_item_category_id"] as? Int, 4)
    }
} 
