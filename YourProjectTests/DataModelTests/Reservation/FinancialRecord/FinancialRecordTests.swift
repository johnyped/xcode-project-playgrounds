//
//  FinancialRecordTests.swift
//  YourProject
//
//  Created by IntrodexMini on 18/5/2568 BE.
//

import XCTest

final class FinancialRecordTests: XCTestCase {
    
    // MARK: - Helper Methods
    
    private func createSampleFinancialRecord() -> FinancialRecord {
        return FinancialRecord(
            id: 440,
            name: "PAYMENT",
            paymentMethod: "Bank Transfer",
            note: nil,
            timestamp: Date(timeIntervalSince1970: 1000),
            amount: 2111.11,
            recordableId: 1067,
            recordableType: .reservation,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000),
            hotelId: 105,
            bankAccountId: nil
        )
    }
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() {
        // Arrange & Act
        let record = createSampleFinancialRecord()
        
        // Assert
        XCTAssertEqual(record.id, 440)
        XCTAssertEqual(record.name, "PAYMENT")
        XCTAssertEqual(record.paymentMethod, "Bank Transfer")
        XCTAssertNil(record.note)
        XCTAssertEqual(record.amount, 2111.11)
        XCTAssertEqual(record.recordableId, 1067)
        XCTAssertEqual(record.recordableType, .reservation)
        XCTAssertEqual(record.hotelId, 105)
        XCTAssertNil(record.bankAccountId)
    }
    
    func test_initWithOptionalPropertiesPresent() {
        // Arrange & Act
        let record = FinancialRecord(
            id: 440,
            name: "PAYMENT",
            paymentMethod: "Bank Transfer", 
            note: "Test note",
            timestamp: Date(timeIntervalSince1970: 1000),
            amount: 2111.11,
            recordableId: 1067,
            recordableType: .reservation,
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000),
            hotelId: 105,
            bankAccountId: 1234567890
        )
        
        // Assert
        XCTAssertEqual(record.note, "Test note")
        XCTAssertEqual(record.bankAccountId, 1234567890)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 440,
            "name": "PAYMENT",
            "payment_method": "Bank Transfer",
            "note": null,
            "timestamp": "2024-04-21T13:33:54.748+07:00",
            "amount": "2111.11",
            "recordable_id": 1067,
            "recordable_type": "RESERVATION",
            "created_at": "2024-04-21T13:33:54.756+07:00",
            "updated_at": "2024-04-21T13:33:54.756+07:00",
            "hotel_id": 105,
            "bank_account": null
        }
        """.data(using: .utf8)!
        
        // Act
        let record = try JSONDecoder().decode(FinancialRecord.self, from: json)
        
        // Assert
        XCTAssertEqual(record.id, 440)
        XCTAssertEqual(record.name, "PAYMENT")
        XCTAssertEqual(record.paymentMethod, "Bank Transfer")
        XCTAssertNil(record.note)
        XCTAssertEqual(record.amount, 2111.11)
        XCTAssertEqual(record.recordableId, 1067)
        XCTAssertEqual(record.recordableType, .reservation)
        XCTAssertEqual(record.hotelId, 105)
        XCTAssertNil(record.bankAccountId)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let record = createSampleFinancialRecord()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(record)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 440"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"PAYMENT\""))
        XCTAssertTrue(jsonString.contains("\"payment_method\" : \"Bank Transfer\""))
        XCTAssertTrue(jsonString.contains("\"amount\" : \"2111.11\""))
        XCTAssertTrue(jsonString.contains("\"recordable_id\" : 1067"))
        XCTAssertTrue(jsonString.contains("\"recordable_type\" : \"RESERVATION\""))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 105"))
    }
    
    // MARK: - CashFlowType Tests
    
    func test_cashFlowType_income() {
        // Arrange
        let record = FinancialRecord(
            id: 1,
            name: "PAYMENT",
            paymentMethod: "Cash",
            note: nil,
            timestamp: Date(),
            amount: 1000.0,
            recordableId: 1,
            recordableType: .reservation,
            createdAt: Date(),
            updatedAt: Date(),
            hotelId: 1,
            bankAccountId: nil
        )
        
        // Act & Assert
        XCTAssertEqual(record.cashFlowType, .income)
    }
    
    func test_cashFlowType_expense() {
        // Arrange
        let record = FinancialRecord(
            id: 1,
            name: "REFUND",
            paymentMethod: "Cash",
            note: nil,
            timestamp: Date(),
            amount: -500.0,
            recordableId: 1,
            recordableType: .reservation,
            createdAt: Date(),
            updatedAt: Date(),
            hotelId: 1,
            bankAccountId: nil
        )
        
        // Act & Assert
        XCTAssertEqual(record.cashFlowType, .expense)
    }
}
