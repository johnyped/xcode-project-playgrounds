//
//  PayeeServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class PayeeServiceRequestTests: XCTestCase {
    
    // MARK: - FetchByHotel Tests
    
    func testFetchByHotel_WillGenerateCorrectParameters() throws {
        // Given
        let request = PayeeServiceRequest.FetchByHotel(
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
        let request = PayeeServiceRequest.FetchByHotel(
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
        let request = PayeeServiceRequest.FetchByHotel(
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
    
    // MARK: - CreatePayee Tests
    
    func testCreatePayee_WillGenerateCorrectBody() throws {
        // Given
        let request = PayeeServiceRequest.CreatePayee(
            hotelId: 105,
            name: "ค่าไฟ้า",
            memo: "electricity bill",
            buyVatType: .sevenPercent,
            sellVatType: .sevenPercent,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: 1
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["name"] as? String, "ค่าไฟ้า")
        XCTAssertEqual(jsonObject?["memo"] as? String, "electricity bill")
        XCTAssertEqual(jsonObject?["buy_vat_type"] as? String, "7_PERCENT")
        XCTAssertEqual(jsonObject?["sell_vat_type"] as? String, "7_PERCENT")
        XCTAssertEqual(jsonObject?["account_item_category_id"] as? Int, 5)
        XCTAssertEqual(jsonObject?["account_sub_item_category_id"] as? Int, 1)
    }
    
    func testCreatePayee_WithNilSubCategory_WillGenerateCorrectBody() throws {
        // Given
        let request = PayeeServiceRequest.CreatePayee(
            hotelId: 105,
            name: "ค่าน้ำ",
            memo: "water bill",
            buyVatType: .noVat,
            sellVatType: .noVat,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["name"] as? String, "ค่าน้ำ")
        XCTAssertEqual(jsonObject?["memo"] as? String, "water bill")
        XCTAssertEqual(jsonObject?["buy_vat_type"] as? String, "NO_VAT")
        XCTAssertEqual(jsonObject?["sell_vat_type"] as? String, "NO_VAT")
        XCTAssertEqual(jsonObject?["account_item_category_id"] as? Int, 5)
        XCTAssertNil(jsonObject?["account_sub_item_category_id"])
    }
    
    // MARK: - UpdatePayee Tests
    
    func testUpdatePayee_WillGenerateCorrectBody() throws {
        // Given
        let request = PayeeServiceRequest.UpdatePayee(
            id: 1,
            name: "ค่าไฟ้า (Updated)",
            memo: "updated electricity bill",
            buyVatType: .tenPercent,
            sellVatType: .tenPercent,
            accountItemCategoryId: 6,
            accountSubItemCategoryId: 2
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        // ID should not be in the body
        XCTAssertNil(jsonObject?["id"])
        XCTAssertEqual(jsonObject?["name"] as? String, "ค่าไฟ้า (Updated)")
        XCTAssertEqual(jsonObject?["memo"] as? String, "updated electricity bill")
        XCTAssertEqual(jsonObject?["buy_vat_type"] as? String, "10_PERCENT")
        XCTAssertEqual(jsonObject?["sell_vat_type"] as? String, "10_PERCENT")
        XCTAssertEqual(jsonObject?["account_item_category_id"] as? Int, 6)
        XCTAssertEqual(jsonObject?["account_sub_item_category_id"] as? Int, 2)
    }
    
    func testUpdatePayee_WithNilOptionalValues_WillGenerateMinimalBody() throws {
        // Given
        let request = PayeeServiceRequest.UpdatePayee(
            id: 1,
            name: nil,
            memo: nil,
            buyVatType: nil,
            sellVatType: nil,
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
        XCTAssertNil(jsonObject?["name"])
        XCTAssertNil(jsonObject?["memo"])
        XCTAssertNil(jsonObject?["buy_vat_type"])
        XCTAssertNil(jsonObject?["sell_vat_type"])
        XCTAssertNil(jsonObject?["account_item_category_id"])
        XCTAssertNil(jsonObject?["account_sub_item_category_id"])
    }
    
    func testUpdatePayee_WithPartialValues_WillGenerateCorrectBody() throws {
        // Given
        let request = PayeeServiceRequest.UpdatePayee(
            id: 1,
            name: "Updated Name",
            memo: nil,
            buyVatType: .sevenPercent,
            sellVatType: nil,
            accountItemCategoryId: 3,
            accountSubItemCategoryId: nil
        )
        
        // When
        let body = request.body
        
        // Then
        XCTAssertNotNil(body)
        
        let jsonObject = try JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]
        XCTAssertNotNil(jsonObject)
        XCTAssertEqual(jsonObject?["name"] as? String, "Updated Name")
        XCTAssertNil(jsonObject?["memo"])
        XCTAssertEqual(jsonObject?["buy_vat_type"] as? String, "7_PERCENT")
        XCTAssertNil(jsonObject?["sell_vat_type"])
        XCTAssertEqual(jsonObject?["account_item_category_id"] as? Int, 3)
        XCTAssertNil(jsonObject?["account_sub_item_category_id"])
    }
} 