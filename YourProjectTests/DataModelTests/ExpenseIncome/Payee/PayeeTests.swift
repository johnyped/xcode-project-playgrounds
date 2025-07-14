//
//  PayeeTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class PayeeTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let payee = createSamplePayee()
        
        // Assert
        XCTAssertEqual(payee.id, 1)
        XCTAssertEqual(payee.name, "ค่าไฟ้า")
        XCTAssertEqual(payee.memo, "memo")
        XCTAssertEqual(payee.buyVatType, .sevenPercent)
        XCTAssertEqual(payee.sellVatType, .sevenPercent)
        XCTAssertEqual(payee.hotelId, 105)
        XCTAssertEqual(payee.accountItemCategoryId, 5)
        XCTAssertNotNil(payee.createdAt)
        XCTAssertNotNil(payee.updatedAt)
    }
    
    func test_initWithOptionalProperties() throws {
        // Arrange & Act
        let payee = createSamplePayee()
        
        // Assert
        XCTAssertNil(payee.accountSubItemCategoryId)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let payee = createSamplePayee()
        
        // Assert
        XCTAssertNotNil(payee.createdAt)
        XCTAssertNotNil(payee.updatedAt)
    
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        XCTAssertEqual(payee.createdAt.toDateString(dateFormat), "2020-05-10T07:28:39.742+07:00")
        XCTAssertEqual(payee.updatedAt.toDateString(dateFormat), "2020-06-04T10:56:19.759+07:00")
    }
    
    // MARK: - VatType Tests
    
    func test_vatTypeRawValues() throws {
        XCTAssertEqual(Payee.VatType.sevenPercent.rawValue, "7_PERCENT")
        XCTAssertEqual(Payee.VatType.noVat.rawValue, "NO_VAT")
        XCTAssertEqual(Payee.VatType.tenPercent.rawValue, "10_PERCENT")
    }
    
    func test_vatTypeAllCases() throws {
        let allCases: [Payee.VatType] = [.sevenPercent, .noVat, .tenPercent]
        
        // Assert all cases can be created from raw values
        for vatType in allCases {
            XCTAssertNotNil(Payee.VatType(rawValue: vatType.rawValue))
        }
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "name": "ค่าไฟ้า",
            "memo": "memo",
            "buy_vat_type": "7_PERCENT",
            "sell_vat_type": "7_PERCENT",
            "created_at": "2020-05-10T06:28:39.742+07:00",
            "updated_at": "2020-06-04T10:56:19.759+07:00",
            "hotel_id": 105,
            "account_item_category_id": 5,
            "account_sub_item_category_id": null
        }
        """.data(using: .utf8)!
        
        // Act
        let payee = try JSONDecoder().decode(Payee.self, from: json)
        
        // Assert
        XCTAssertEqual(payee.id, 1)
        XCTAssertEqual(payee.name, "ค่าไฟ้า")
        XCTAssertEqual(payee.memo, "memo")
        XCTAssertEqual(payee.buyVatType, .sevenPercent)
        XCTAssertEqual(payee.sellVatType, .sevenPercent)
        XCTAssertEqual(payee.hotelId, 105)
        XCTAssertEqual(payee.accountItemCategoryId, 5)
        XCTAssertNil(payee.accountSubItemCategoryId)
        XCTAssertNotNil(payee.createdAt)
        XCTAssertNotNil(payee.updatedAt)
        XCTAssertEqual(payee.createdAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-05-10")
        XCTAssertEqual(payee.updatedAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-06-04")
    }
    
    func test_decodingFromJSONWithMissingMemo() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "name": "ค่าไฟ้า",
            "buy_vat_type": "NO_VAT",
            "sell_vat_type": "10_PERCENT",
            "created_at": "2020-05-10T06:28:39.742+07:00",
            "updated_at": "2020-06-04T10:56:19.759+07:00",
            "hotel_id": 105,
            "account_item_category_id": 5,
            "account_sub_item_category_id": 10
        }
        """.data(using: .utf8)!
        
        // Act
        let payee = try JSONDecoder().decode(Payee.self, from: json)
        
        // Assert
        XCTAssertEqual(payee.id, 1)
        XCTAssertEqual(payee.name, "ค่าไฟ้า")
        XCTAssertEqual(payee.memo, "") // Should default to empty string
        XCTAssertEqual(payee.buyVatType, .noVat)
        XCTAssertEqual(payee.sellVatType, .tenPercent)
        XCTAssertEqual(payee.hotelId, 105)
        XCTAssertEqual(payee.accountItemCategoryId, 5)
        XCTAssertEqual(payee.accountSubItemCategoryId, 10)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let payee = createSamplePayee()
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(payee)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        // Assert
        XCTAssertEqual(json["id"] as? Int, 1)
        XCTAssertEqual(json["name"] as? String, "ค่าไฟ้า")
        XCTAssertEqual(json["memo"] as? String, "memo")
        XCTAssertEqual(json["buy_vat_type"] as? String, "7_PERCENT")
        XCTAssertEqual(json["sell_vat_type"] as? String, "7_PERCENT")
        XCTAssertEqual(json["hotel_id"] as? Int, 105)
        XCTAssertEqual(json["account_item_category_id"] as? Int, 5)
        XCTAssertNil(json["account_sub_item_category_id"])
        XCTAssertNotNil(json["created_at"])
        XCTAssertNotNil(json["updated_at"])
    }
    
    func test_encodingAndDecodingRoundTrip() throws {
        // Arrange
        let originalPayee = createSamplePayee()
        
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(originalPayee)
        let decodedPayee = try JSONDecoder().decode(Payee.self, from: data)
        
        // Assert
        XCTAssertEqual(originalPayee.id, decodedPayee.id)
        XCTAssertEqual(originalPayee.name, decodedPayee.name)
        XCTAssertEqual(originalPayee.memo, decodedPayee.memo)
        XCTAssertEqual(originalPayee.buyVatType, decodedPayee.buyVatType)
        XCTAssertEqual(originalPayee.sellVatType, decodedPayee.sellVatType)
        XCTAssertEqual(originalPayee.hotelId, decodedPayee.hotelId)
        XCTAssertEqual(originalPayee.accountItemCategoryId, decodedPayee.accountItemCategoryId)
        XCTAssertEqual(originalPayee.accountSubItemCategoryId, decodedPayee.accountSubItemCategoryId)
        // Note: Dates might have slight precision differences, so we compare formatted strings
        XCTAssertEqual(
            originalPayee.createdAt.toDateString(FormConfig.DateFormat.datetimeISO),
            decodedPayee.createdAt.toDateString(FormConfig.DateFormat.datetimeISO)
        )
        XCTAssertEqual(
            originalPayee.updatedAt.toDateString(FormConfig.DateFormat.datetimeISO),
            decodedPayee.updatedAt.toDateString(FormConfig.DateFormat.datetimeISO)
        )
    }
    
    // MARK: - Helper Methods
    
    private func createSamplePayee() -> Payee {
        let createdAt = Date(timeIntervalSince1970: 1589070519.742) // 2020-05-10T06:28:39.742+07:00
        let updatedAt = Date(timeIntervalSince1970: 1591242979.759) // 2020-06-04T10:56:19.759+07:00
        
        return Payee(
            id: 1,
            name: "ค่าไฟ้า",
            memo: "memo", 
            buyVatType: .sevenPercent,
            sellVatType: .sevenPercent,
            hotelId: 105,
            accountItemCategoryId: 5,
            accountSubItemCategoryId: nil,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    private func createSamplePayeeWithOptionalValues() -> Payee {
        let createdAt = Date(timeIntervalSince1970: 1589070519.742) // 2020-05-10T06:28:39.742+07:00
        let updatedAt = Date(timeIntervalSince1970: 1591242979.759) // 2020-06-04T10:56:19.759+07:00
        
        return Payee(
            id: 2,
            name: "Test Payee",
            memo: "Test memo",
            buyVatType: .noVat,
            sellVatType: .tenPercent,
            hotelId: 106,
            accountItemCategoryId: 6,
            accountSubItemCategoryId: 10,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
} 
