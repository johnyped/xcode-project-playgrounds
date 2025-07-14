//
//  AccountItemTests.swift
//  YourProject
//
//  Created by IntrodexMini on 23/5/2568 BE.
//

import XCTest

final class AccountItemTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let accountItem = createSampleAccountItem()
        
        // Assert
        XCTAssertEqual(accountItem.id, 12)
        XCTAssertEqual(accountItem.currency, "THB")
        XCTAssertEqual(accountItem.amount, 222.0)
        XCTAssertEqual(accountItem.buyAmountBeforeVat, 222.0)
        XCTAssertEqual(accountItem.buyAmountVat, 0.0)
        XCTAssertEqual(accountItem.sellAmountBeforeVat, 222.0)
        XCTAssertEqual(accountItem.sellAmountVat, 0.0)
        XCTAssertEqual(accountItem.accountId, 1)
        XCTAssertEqual(accountItem.payeeId, 8)
        XCTAssertEqual(accountItem.accountItemCategoryId, 1)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let accountItem = createSampleAccountItem()
        
        // Assert
        XCTAssertNil(accountItem.memo)
        XCTAssertEqual(accountItem.accountSubItemCategoryId, 1)
        XCTAssertTrue(accountItem.documentIds.isEmpty)
        XCTAssertTrue(accountItem.financialRecordIds.isEmpty)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let accountItem = createSampleAccountItem()
        
        // Assert
        XCTAssertNotNil(accountItem.date)
        XCTAssertNotNil(accountItem.createdAt)
        XCTAssertNotNil(accountItem.updatedAt)
    }
    
    func test_initWithCustomValues() throws {
        // Arrange
        let customDate = Date()
        let customCreatedAt = Date()
        let customUpdatedAt = Date()
        
        // Act
        let accountItem = AccountItem(
            id: 999,
            currency: "USD",
            memo: "Test memo",
            date: customDate,
            amount: 100.5,
            buyAmountBeforeVat: 90.0,
            buyAmountVat: 10.5,
            sellAmountBeforeVat: 95.0,
            sellAmountVat: 5.5,
            documentIds: [1, 2, 3],
            financialRecordIds: [4, 5, 6],
            accountId: 2,
            payeeId: 3,
            accountItemCategoryId: 4,
            accountSubItemCategoryId: 5,
            createdAt: customCreatedAt,
            updatedAt: customUpdatedAt
        )
        
        // Assert
        XCTAssertEqual(accountItem.id, 999)
        XCTAssertEqual(accountItem.currency, "USD")
        XCTAssertEqual(accountItem.memo, "Test memo")
        XCTAssertEqual(accountItem.date, customDate)
        XCTAssertEqual(accountItem.amount, 100.5)
        XCTAssertEqual(accountItem.buyAmountBeforeVat, 90.0)
        XCTAssertEqual(accountItem.buyAmountVat, 10.5)
        XCTAssertEqual(accountItem.sellAmountBeforeVat, 95.0)
        XCTAssertEqual(accountItem.sellAmountVat, 5.5)
        XCTAssertEqual(accountItem.documentIds, [1, 2, 3])
        XCTAssertEqual(accountItem.financialRecordIds, [4, 5, 6])
        XCTAssertEqual(accountItem.accountId, 2)
        XCTAssertEqual(accountItem.payeeId, 3)
        XCTAssertEqual(accountItem.accountItemCategoryId, 4)
        XCTAssertEqual(accountItem.accountSubItemCategoryId, 5)
        XCTAssertEqual(accountItem.createdAt, customCreatedAt)
        XCTAssertEqual(accountItem.updatedAt, customUpdatedAt)
    }
    
    // MARK: - Property Tests
    
    func test_amountProperties() throws {
        // Arrange & Act
        let accountItem = createSampleAccountItem()
        
        // Assert
        XCTAssertEqual(accountItem.amount, 222.0)
        XCTAssertEqual(accountItem.buyAmountBeforeVat, 222.0)
        XCTAssertEqual(accountItem.buyAmountVat, 0.0)
        XCTAssertEqual(accountItem.sellAmountBeforeVat, 222.0)
        XCTAssertEqual(accountItem.sellAmountVat, 0.0)
    }
    
    func test_idProperties() throws {
        // Arrange & Act
        let accountItem = createSampleAccountItem()
        
        // Assert
        XCTAssertEqual(accountItem.id, 12)
        XCTAssertEqual(accountItem.accountId, 1)
        XCTAssertEqual(accountItem.payeeId, 8)
        XCTAssertEqual(accountItem.accountItemCategoryId, 1)
        XCTAssertEqual(accountItem.accountSubItemCategoryId, 1)
    }
    
    func test_arrayProperties() throws {
        // Arrange & Act
        let accountItem = createSampleAccountItem()
        
        // Assert
        XCTAssertTrue(accountItem.documentIds.isEmpty)
        XCTAssertTrue(accountItem.financialRecordIds.isEmpty)
    }
    
    func test_arrayPropertiesWithValues() throws {
        // Arrange
        let documentIds = [1, 2, 3]
        let financialRecordIds = [4, 5, 6]
        
        // Act
        let accountItem = AccountItem(
            id: 1,
            currency: "THB",
            date: Date(),
            amount: 100.0,
            buyAmountBeforeVat: 100.0,
            buyAmountVat: 0.0,
            sellAmountBeforeVat: 100.0,
            sellAmountVat: 0.0,
            documentIds: documentIds,
            financialRecordIds: financialRecordIds,
            accountId: 1,
            payeeId: 1,
            accountItemCategoryId: 1,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        // Assert
        XCTAssertEqual(accountItem.documentIds, documentIds)
        XCTAssertEqual(accountItem.financialRecordIds, financialRecordIds)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 12,
            "currency": "THB",
            "memo": null,
            "amount": "222.0",
            "buy_amount_before_vat": "222.0",
            "buy_amount_vat": "0.0",
            "sell_amount_before_vat": "222.0",
            "sell_amount_vat": "0.0",
            "date": "2020-06-05T08:41:43.056+07:00",
            "created_at": "2020-06-05T08:41:56.562+07:00",
            "updated_at": "2020-06-05T08:41:56.571+07:00",
            "document_ids": [],
            "financial_record_ids": [],
            "account_id": 1,
            "payee_id": 8,
            "account_item_category_id": 1,
            "account_sub_item_category_id": 1
        }
        """.data(using: .utf8)!
        
        // Act
        let accountItem = try JSONDecoder().decode(AccountItem.self, from: json)
        
        // Assert
        XCTAssertEqual(accountItem.id, 12)
        XCTAssertEqual(accountItem.currency, "THB")
        XCTAssertNil(accountItem.memo)
        XCTAssertEqual(accountItem.amount, 222.0)
        XCTAssertEqual(accountItem.buyAmountBeforeVat, 222.0)
        XCTAssertEqual(accountItem.buyAmountVat, 0.0)
        XCTAssertEqual(accountItem.sellAmountBeforeVat, 222.0)
        XCTAssertEqual(accountItem.sellAmountVat, 0.0)
        XCTAssertNotNil(accountItem.date)
        XCTAssertNotNil(accountItem.createdAt)
        XCTAssertNotNil(accountItem.updatedAt)
        XCTAssertTrue(accountItem.documentIds.isEmpty)
        XCTAssertTrue(accountItem.financialRecordIds.isEmpty)
        XCTAssertEqual(accountItem.accountId, 1)
        XCTAssertEqual(accountItem.payeeId, 8)
        XCTAssertEqual(accountItem.accountItemCategoryId, 1)
        XCTAssertEqual(accountItem.accountSubItemCategoryId, 1)
    }
    
    func test_decodingFromJSONWithMemo() throws {
        // Arrange
        let json = """
        {
            "id": 13,
            "currency": "USD",
            "memo": "Test transaction",
            "amount": "150.5",
            "buy_amount_before_vat": "140.0",
            "buy_amount_vat": "10.5",
            "sell_amount_before_vat": "145.0",
            "sell_amount_vat": "5.5",
            "date": "2020-06-05T08:41:43.056+07:00",
            "created_at": "2020-06-05T08:41:56.562+07:00",
            "updated_at": "2020-06-05T08:41:56.571+07:00",
            "document_ids": [1, 2, 3],
            "financial_record_ids": [4, 5],
            "account_id": 2,
            "payee_id": 9,
            "account_item_category_id": 2,
            "account_sub_item_category_id": 2
        }
        """.data(using: .utf8)!
        
        // Act
        let accountItem = try JSONDecoder().decode(AccountItem.self, from: json)
        
        // Assert
        XCTAssertEqual(accountItem.id, 13)
        XCTAssertEqual(accountItem.currency, "USD")
        XCTAssertEqual(accountItem.memo, "Test transaction")
        XCTAssertEqual(accountItem.amount, 150.5)
        XCTAssertEqual(accountItem.buyAmountBeforeVat, 140.0)
        XCTAssertEqual(accountItem.buyAmountVat, 10.5)
        XCTAssertEqual(accountItem.sellAmountBeforeVat, 145.0)
        XCTAssertEqual(accountItem.sellAmountVat, 5.5)
        XCTAssertEqual(accountItem.documentIds, [1, 2, 3])
        XCTAssertEqual(accountItem.financialRecordIds, [4, 5])
        XCTAssertEqual(accountItem.accountId, 2)
        XCTAssertEqual(accountItem.payeeId, 9)
        XCTAssertEqual(accountItem.accountItemCategoryId, 2)
        XCTAssertEqual(accountItem.accountSubItemCategoryId, 2)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let accountItem = createSampleAccountItem()
        
        // Act
        let data = try JSONEncoder().encode(accountItem)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 12)
        XCTAssertEqual(json?["currency"] as? String, "THB")
        XCTAssertEqual(json?["amount"] as? String, "222.0")
        XCTAssertEqual(json?["buy_amount_before_vat"] as? String, "222.0")
        XCTAssertEqual(json?["buy_amount_vat"] as? String, "0.0")
        XCTAssertEqual(json?["sell_amount_before_vat"] as? String, "222.0")
        XCTAssertEqual(json?["sell_amount_vat"] as? String, "0.0")
        XCTAssertEqual(json?["account_id"] as? Int, 1)
        XCTAssertEqual(json?["payee_id"] as? Int, 8)
        XCTAssertEqual(json?["account_item_category_id"] as? Int, 1)
        XCTAssertEqual(json?["account_sub_item_category_id"] as? Int, 1)
    }
    
    // MARK: - Edge Cases Tests
    
    func test_decodingWithInvalidAmountStrings() throws {
        // Arrange
        let json = """
        {
            "id": 14,
            "currency": "THB",
            "memo": null,
            "amount": "invalid",
            "buy_amount_before_vat": "not_a_number",
            "buy_amount_vat": "",
            "sell_amount_before_vat": "null",
            "sell_amount_vat": "undefined",
            "date": "2020-06-05T08:41:43.056+07:00",
            "created_at": "2020-06-05T08:41:56.562+07:00",
            "updated_at": "2020-06-05T08:41:56.571+07:00",
            "document_ids": [],
            "financial_record_ids": [],
            "account_id": 1,
            "payee_id": 8,
            "account_item_category_id": 1,
            "account_sub_item_category_id": 1
        }
        """.data(using: .utf8)!
        
        // Act
        let accountItem = try JSONDecoder().decode(AccountItem.self, from: json)
        
        // Assert - Should default to 0.0 for invalid strings
        XCTAssertEqual(accountItem.amount, 0.0)
        XCTAssertEqual(accountItem.buyAmountBeforeVat, 0.0)
        XCTAssertEqual(accountItem.buyAmountVat, 0.0)
        XCTAssertEqual(accountItem.sellAmountBeforeVat, 0.0)
        XCTAssertEqual(accountItem.sellAmountVat, 0.0)
    }
    
    func test_decodingWithMissingOptionalFields() throws {
        // Arrange
        let json = """
        {
            "id": 15,
            "currency": "THB",
            "amount": "100.0",
            "buy_amount_before_vat": "100.0",
            "buy_amount_vat": "0.0",
            "sell_amount_before_vat": "100.0",
            "sell_amount_vat": "0.0",
            "date": "2020-06-05T08:41:43.056+07:00",
            "created_at": "2020-06-05T08:41:56.562+07:00",
            "updated_at": "2020-06-05T08:41:56.571+07:00",
            "account_id": 1,
            "payee_id": 8,
            "account_item_category_id": 1,
            "account_sub_item_category_id": 1
        }
        """.data(using: .utf8)!
        
        // Act
        let accountItem = try JSONDecoder().decode(AccountItem.self, from: json)
        
        // Assert - Should use defaults for missing optional fields
        XCTAssertNil(accountItem.memo)
        XCTAssertTrue(accountItem.documentIds.isEmpty)
        XCTAssertTrue(accountItem.financialRecordIds.isEmpty)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleAccountItem() -> AccountItem {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return AccountItem(
            id: 12,
            currency: "THB",
            memo: nil,
            date: dateFormatter.date(from: "2020-06-05T08:41:43.056+07:00")!,
            amount: 222.0,
            buyAmountBeforeVat: 222.0,
            buyAmountVat: 0.0,
            sellAmountBeforeVat: 222.0,
            sellAmountVat: 0.0,
            documentIds: [],
            financialRecordIds: [],
            accountId: 1,
            payeeId: 8,
            accountItemCategoryId: 1,
            accountSubItemCategoryId: 1,
            createdAt: dateFormatter.date(from: "2020-06-05T08:41:56.562+07:00")!,
            updatedAt: dateFormatter.date(from: "2020-06-05T08:41:56.571+07:00")!
        )
    }
} 