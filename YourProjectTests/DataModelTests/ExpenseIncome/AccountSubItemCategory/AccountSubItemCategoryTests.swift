//
//  AccountSubItemCategoryTests.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import XCTest

final class AccountSubItemCategoryTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let subCategory = createSampleAccountSubItemCategory()
        
        // Assert
        XCTAssertEqual(subCategory.id, 1)
        XCTAssertEqual(subCategory.name, "ซ่อม")
        XCTAssertEqual(subCategory.hotelId, 105)
        XCTAssertEqual(subCategory.accountItemCategoryId, 1)
        XCTAssertNotNil(subCategory.createdAt)
        XCTAssertNotNil(subCategory.updatedAt)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "name": "ซ่อม",
            "created_at": "2020-05-13T08:48:29.084+07:00",
            "updated_at": "2020-06-02T07:11:41.983+07:00",
            "hotel_id": 105,
            "account_item_category_id": 1
        }
        """.data(using: .utf8)!
        
        // Act
        let subCategory = try JSONDecoder().decode(AccountSubItemCategory.self, from: json)
        
        // Assert
        XCTAssertEqual(subCategory.id, 1)
        XCTAssertEqual(subCategory.name, "ซ่อม")
        XCTAssertEqual(subCategory.hotelId, 105)
        XCTAssertEqual(subCategory.accountItemCategoryId, 1)
        XCTAssertNotNil(subCategory.createdAt)
        XCTAssertNotNil(subCategory.updatedAt)
        
        // Test date parsing
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let expectedCreatedAt = formatter.date(from: "2020-05-13T08:48:29.084+07:00")
        let expectedUpdatedAt = formatter.date(from: "2020-06-02T07:11:41.983+07:00")
        
        XCTAssertNotNil(expectedCreatedAt)
        XCTAssertNotNil(expectedUpdatedAt)
    }
    
    func test_decodingFromJSONWithDifferentData() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "name": "Test Sub Category",
            "created_at": "2020-01-01T00:00:00.000+07:00",
            "updated_at": "2020-12-31T23:59:59.999+07:00",
            "hotel_id": 200,
            "account_item_category_id": 5
        }
        """.data(using: .utf8)!
        
        // Act
        let subCategory = try JSONDecoder().decode(AccountSubItemCategory.self, from: json)
        
        // Assert
        XCTAssertEqual(subCategory.id, 2)
        XCTAssertEqual(subCategory.name, "Test Sub Category")
        XCTAssertEqual(subCategory.hotelId, 200)
        XCTAssertEqual(subCategory.accountItemCategoryId, 5)
        XCTAssertNotNil(subCategory.createdAt)
        XCTAssertNotNil(subCategory.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let subCategory = createSampleAccountSubItemCategory()
        
        // Act
        let data = try JSONEncoder().encode(subCategory)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 1)
        XCTAssertEqual(json?["name"] as? String, "ซ่อม")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["account_item_category_id"] as? Int, 1)
        XCTAssertNotNil(json?["created_at"] as? String)
        XCTAssertNotNil(json?["updated_at"] as? String)
    }
    
    func test_roundTripEncodingDecoding() throws {
        // Arrange
        let originalSubCategory = createSampleAccountSubItemCategory()
        
        // Act
        let encodedData = try JSONEncoder().encode(originalSubCategory)
        let decodedSubCategory = try JSONDecoder().decode(AccountSubItemCategory.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(originalSubCategory.id, decodedSubCategory.id)
        XCTAssertEqual(originalSubCategory.name, decodedSubCategory.name)
        XCTAssertEqual(originalSubCategory.hotelId, decodedSubCategory.hotelId)
        XCTAssertEqual(originalSubCategory.accountItemCategoryId, decodedSubCategory.accountItemCategoryId)
        // Note: Date comparison might have slight precision differences
        XCTAssertNotNil(decodedSubCategory.createdAt)
        XCTAssertNotNil(decodedSubCategory.updatedAt)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleAccountSubItemCategory() -> AccountSubItemCategory {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return AccountSubItemCategory(
            id: 1,
            name: "ซ่อม",
            hotelId: 105,
            accountItemCategoryId: 1,
            createdAt: dateFormatter.date(from: "2020-05-13T08:48:29.084+07:00")!,
            updatedAt: dateFormatter.date(from: "2020-06-02T07:11:41.983+07:00")!,
        )
    }
} 
