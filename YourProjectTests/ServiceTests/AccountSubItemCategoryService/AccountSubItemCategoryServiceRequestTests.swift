//
//  AccountSubItemCategoryServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 25/1/2568 BE.
//

import XCTest

final class AccountSubItemCategoryServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectParameters() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchByHotel(
            hotelId: 105,
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
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByHotel_WithNilOptionalValues_WillGenerateMinimalParameters() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchByHotel(
            hotelId: 1,
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
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func testFetchByHotel_WithInvalidPage_WillExcludePageParameter() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchByHotel(
            hotelId: 1,
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
        XCTAssertNil(parameters?["page"]) // Should be excluded because page < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - FetchByAccountItemCategory Tests
    
    func testFetchByAccountItemCategory_WillGenerateCorrectParameters() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.FetchByAccountItemCategory(
            hotelId: 105,
            accountItemCategoryId: 3
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["account_item_category_id"] as? Int, 3)
    }
    
    // MARK: - CreateAccountSubItemCategory Tests
    
    func testCreateAccountSubItemCategory_WillGenerateCorrectBody() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.CreateAccountSubItemCategory(
            hotelId: 105,
            name: "Test Sub Category",
            accountItemCategoryId: 2
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject["name"] as? String, "Test Sub Category")
        XCTAssertEqual(jsonObject["account_item_category_id"] as? Int, 2)
    }
    
    // MARK: - UpdateAccountSubItemCategory Tests
    
    func testUpdateAccountSubItemCategory_WillGenerateCorrectBody() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 1,
            name: "Updated Sub Category",
            accountItemCategoryId: 4
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Updated Sub Category")
        XCTAssertEqual(jsonObject["account_item_category_id"] as? Int, 4)
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
    
    func testUpdateAccountSubItemCategory_WithNilValues_WillGenerateMinimalBody() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 1,
            name: nil,
            accountItemCategoryId: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertNil(jsonObject["name"])
        XCTAssertNil(jsonObject["account_item_category_id"])
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
    
    func testUpdateAccountSubItemCategory_WithPartialValues_WillGeneratePartialBody() throws {
        // Given
        let request = AccountSubItemCategoryServiceRequest.UpdateAccountSubItemCategory(
            id: 1,
            name: "Partial Update",
            accountItemCategoryId: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        // Verify body content
        let jsonObject = try XCTUnwrap(JSONSerialization.jsonObject(with: body!) as? [String: Any])
        XCTAssertEqual(jsonObject["name"] as? String, "Partial Update")
        XCTAssertNil(jsonObject["account_item_category_id"])
        XCTAssertNil(jsonObject["id"]) // ID should not be in body
    }
} 
