//
//  AccountItemCategoryTests.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import XCTest

final class AccountItemCategoryTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let category = createSampleAccountItemCategory()
        
        // Assert
        XCTAssertEqual(category.id, 1)
        XCTAssertEqual(category.name, "ปะปา")
        XCTAssertEqual(category.kind, .expense)
        XCTAssertEqual(category.iconRef, 5)
        XCTAssertEqual(category.hotelId, 105)
        XCTAssertEqual(category.accountSubItemCategoryIds, [1])
        XCTAssertNotNil(category.createdAt)
        XCTAssertNotNil(category.updatedAt)
    }
    
    // MARK: - Kind Enum Tests
    
    func test_kindRawValues() throws {
        XCTAssertEqual(AccountItemCategory.Kind.expense.rawValue, "EXPENSE")
        XCTAssertEqual(AccountItemCategory.Kind.income.rawValue, "INCOME")
    }
    
    func test_kindDescription() throws {
        XCTAssertEqual(AccountItemCategory.Kind.expense.description, "Expense")
        XCTAssertEqual(AccountItemCategory.Kind.income.description, "Income")
    }
    
    func test_kindCaseIterable() throws {
        let allCases = AccountItemCategory.Kind.allCases
        XCTAssertEqual(allCases.count, 2)
        XCTAssertTrue(allCases.contains(.expense))
        XCTAssertTrue(allCases.contains(.income))
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "name": "ปะปา",
            "kind": "EXPENSE",
            "icon_ref": 5,
            "created_at": "2020-05-10T05:39:56.850+07:00",
            "updated_at": "2020-06-14T18:10:55.081+07:00",
            "account_sub_item_category_ids": [
                1
            ],
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let category = try JSONDecoder().decode(AccountItemCategory.self, from: json)
        
        // Assert
        XCTAssertEqual(category.id, 1)
        XCTAssertEqual(category.name, "ปะปา")
        XCTAssertEqual(category.kind, .expense)
        XCTAssertEqual(category.iconRef, 5)
        XCTAssertEqual(category.hotelId, 105)
        XCTAssertEqual(category.accountSubItemCategoryIds, [1])
        XCTAssertNotNil(category.createdAt)
        XCTAssertNotNil(category.updatedAt)
        
        // Test date parsing
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let expectedCreatedAt = formatter.date(from: "2020-05-10T05:39:56.850+07:00")
        let expectedUpdatedAt = formatter.date(from: "2020-06-14T18:10:55.081+07:00")
        
        XCTAssertNotNil(expectedCreatedAt)
        XCTAssertNotNil(expectedUpdatedAt)
    }
    
    func test_decodingFromJSONWithEmptySubCategories() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "name": "Test Category",
            "kind": "INCOME",
            "icon_ref": 3,
            "created_at": "2020-05-10T05:39:56.850+07:00",
            "updated_at": "2020-06-14T18:10:55.081+07:00",
            "account_sub_item_category_ids": [],
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let category = try JSONDecoder().decode(AccountItemCategory.self, from: json)
        
        // Assert
        XCTAssertEqual(category.id, 2)
        XCTAssertEqual(category.name, "Test Category")
        XCTAssertEqual(category.kind, .income)
        XCTAssertEqual(category.iconRef, 3)
        XCTAssertEqual(category.hotelId, 105)
        XCTAssertTrue(category.accountSubItemCategoryIds.isEmpty)
    }
    
    func test_decodingFromJSONWithMissingSubCategories() throws {
        // Arrange
        let json = """
        {
            "id": 3,
            "name": "Test Category",
            "kind": "EXPENSE",
            "icon_ref": 2,
            "created_at": "2020-05-10T05:39:56.850+07:00",
            "updated_at": "2020-06-14T18:10:55.081+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let category = try JSONDecoder().decode(AccountItemCategory.self, from: json)
        
        // Assert
        XCTAssertEqual(category.id, 3)
        XCTAssertEqual(category.name, "Test Category")
        XCTAssertEqual(category.kind, .expense)
        XCTAssertEqual(category.iconRef, 2)
        XCTAssertEqual(category.hotelId, 105)
        XCTAssertTrue(category.accountSubItemCategoryIds.isEmpty)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let category = createSampleAccountItemCategory()
        
        // Act
        let data = try JSONEncoder().encode(category)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 1)
        XCTAssertEqual(json?["name"] as? String, "ปะปา")
        XCTAssertEqual(json?["kind"] as? String, "EXPENSE")
        XCTAssertEqual(json?["icon_ref"] as? Int, 5)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        
        let subCategoryIds = json?["account_sub_item_category_ids"] as? [Int]
        XCTAssertEqual(subCategoryIds, [1])
        
        XCTAssertNotNil(json?["created_at"] as? String)
        XCTAssertNotNil(json?["updated_at"] as? String)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleAccountItemCategory() -> AccountItemCategory {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return AccountItemCategory(
            id: 1,
            name: "ปะปา",
            kind: .expense,
            iconRef: 5,
            accountSubItemCategoryIds: [1],
            hotelId: 105,
            createdAt: dateFormatter.date(from: "2020-05-10T05:39:56.850+07:00")!,
            updatedAt: dateFormatter.date(from: "2020-06-14T18:10:55.081+07:00")!
        )
    }
} 
