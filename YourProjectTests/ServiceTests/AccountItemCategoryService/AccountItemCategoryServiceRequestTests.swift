//
//  AccountItemCategoryServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//

import XCTest

final class AccountItemCategoryServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectParameters() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.FetchByHotel(
            hotelId: 105,
            kind: .expense,
            page: 2,
            perPage: .fifty,
            sortedBy: .name,
            sortedOrder: .descending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "EXPENSE")
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByHotel_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.FetchByHotel(
            hotelId: 1,
            kind: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertNil(parameters?["kind"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testFetchByHotel_WithInvalidPage_WillExcludePageParameter() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.FetchByHotel(
            hotelId: 1,
            kind: .income,
            page: 0, // Invalid page
            perPage: .ten,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 1)
        XCTAssertEqual(parameters?["kind"] as? String, "INCOME")
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - CreateAccountItemCategory Tests
    
    func testCreateAccountItemCategory_WillGenerateCorrectBody() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.CreateAccountItemCategory(
            hotelId: 105,
            name: "Test Category",
            kind: .expense,
            iconRef: 5
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject["name"] as? String, "Test Category")
        XCTAssertEqual(jsonObject["kind"] as? String, "EXPENSE")
        XCTAssertEqual(jsonObject["icon_ref"] as? Int, 5)
    }
    
    func testCreateAccountItemCategoryWithIncome_WillGenerateCorrectBody() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.CreateAccountItemCategory(
            hotelId: 1,
            name: "Income Category",
            kind: .income,
            iconRef: 3
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["hotel_id"] as? Int, 1)
        XCTAssertEqual(jsonObject["name"] as? String, "Income Category")
        XCTAssertEqual(jsonObject["kind"] as? String, "INCOME")
        XCTAssertEqual(jsonObject["icon_ref"] as? Int, 3)
    }
    
    // MARK: - UpdateAccountItemCategory Tests
    
    func testUpdateAccountItemCategory_WillGenerateCorrectBody() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 1,
            name: "Updated Category",
            iconRef: 7
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Updated Category")        
        XCTAssertEqual(jsonObject["icon_ref"] as? Int, 7)
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
    
    func testUpdateAccountItemCategory_WithNilValues_WillGenerateMinimalBody() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 1,
            name: nil,
            iconRef: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertNil(jsonObject["name"])
        XCTAssertNil(jsonObject["icon_ref"])
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
    
    func testUpdateAccountItemCategory_WithPartialValues_WillGeneratePartialBody() throws {
        // Given
        let request = AccountItemCategoryServiceRequest.UpdateAccountItemCategory(
            id: 1,
            name: "Partial Update",
            iconRef: 9
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Partial Update")
        XCTAssertNil(jsonObject["kind"])
        XCTAssertEqual(jsonObject["icon_ref"] as? Int, 9)
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
} 
