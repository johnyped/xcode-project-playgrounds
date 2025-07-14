//
//  BankAccountTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class BankAccountTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let bankAccount = createSampleBankAccount()
        
        // Assert
        XCTAssertEqual(bankAccount.id, 2)
        XCTAssertEqual(bankAccount.bankNumber, "3202999102")
        XCTAssertEqual(bankAccount.bankName, "กสิกรไทย")
        XCTAssertEqual(bankAccount.bankBranch, "สยามพารากอน")
        XCTAssertEqual(bankAccount.accountName, "นายสมชาย ชาติทหาร")
        XCTAssertEqual(bankAccount.isDefault, false)
        XCTAssertEqual(bankAccount.hotelId, 105)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let bankAccount = createSampleBankAccount()
        
        // Assert
        XCTAssertNotNil(bankAccount.createdAt)
        XCTAssertNotNil(bankAccount.updatedAt)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 2,
            "bank_number": "3202999102",
            "bank_name": "กสิกรไทย",
            "bank_branch": "สยามพารากอน",
            "account_name": "นายสมชาย ชาติทหาร",
            "is_default": false,
            "created_at": "2023-03-02T22:50:34.406+07:00",
            "updated_at": "2023-06-17T21:10:08.255+07:00",
            "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let bankAccount = try JSONDecoder().decode(BankAccount.self, from: json)
        
        // Assert
        XCTAssertEqual(bankAccount.id, 2)
        XCTAssertEqual(bankAccount.bankNumber, "3202999102")
        XCTAssertEqual(bankAccount.bankName, "กสิกรไทย")
        XCTAssertEqual(bankAccount.bankBranch, "สยามพารากอน")
        XCTAssertEqual(bankAccount.accountName, "นายสมชาย ชาติทหาร")
        XCTAssertEqual(bankAccount.isDefault, false)
        XCTAssertEqual(bankAccount.hotelId, 105)
        XCTAssertNotNil(bankAccount.createdAt)
        XCTAssertNotNil(bankAccount.updatedAt)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let bankAccount = createSampleBankAccount()
        
        // Act
        let encodedData = try JSONEncoder().encode(bankAccount)
        let decodedBankAccount = try JSONDecoder().decode(BankAccount.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedBankAccount.id, bankAccount.id)
        XCTAssertEqual(decodedBankAccount.bankNumber, bankAccount.bankNumber)
        XCTAssertEqual(decodedBankAccount.bankName, bankAccount.bankName)
        XCTAssertEqual(decodedBankAccount.bankBranch, bankAccount.bankBranch)
        XCTAssertEqual(decodedBankAccount.accountName, bankAccount.accountName)
        XCTAssertEqual(decodedBankAccount.isDefault, bankAccount.isDefault)
        XCTAssertEqual(decodedBankAccount.hotelId, bankAccount.hotelId)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleBankAccount() -> BankAccount {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return BankAccount(
            id: 2,
            bankNumber: "3202999102",
            bankName: "กสิกรไทย",
            bankBranch: "สยามพารากอน",
            accountName: "นายสมชาย ชาติทหาร",
            isDefault: false,
            hotelId: 105,
            createdAt: dateFormatter.date(from: "2023-03-02T22:50:34.406+07:00")!,
            updatedAt: dateFormatter.date(from: "2023-06-17T21:10:08.255+07:00")!
        )
    }
}
