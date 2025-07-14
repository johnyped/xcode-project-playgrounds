//
//  AccountServiceResponseTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

class AccountServiceResponseTests: XCTestCase {
    
    // MARK: - Test BalanceInfo
    
    func test_balanceInfo_decodesCorrectly() throws {
        // Arrange
        let json = """
        {
            "id": 123,
            "name": "Test Account",
            "balance": "1500.50"
        }
        """.data(using: .utf8)!
        
        // Act
        let balanceInfo = try JSONDecoder().decode(AccountServiceResponse.BalanceInfo.self, from: json)
        
        // Assert
        XCTAssertEqual(balanceInfo.id, 123)
        XCTAssertEqual(balanceInfo.name, "Test Account")
        XCTAssertEqual(balanceInfo.balance, 1500.50)
    }
    
    func test_balanceInfo_decodesCorrectly_withInvalidBalance() throws {
        // Arrange
        let json = """
        {
            "id": 123,
            "name": "Test Account",
            "balance": "invalid"
        }
        """.data(using: .utf8)!
        
        // Act
        let balanceInfo = try JSONDecoder().decode(AccountServiceResponse.BalanceInfo.self, from: json)
        
        // Assert
        XCTAssertEqual(balanceInfo.id, 123)
        XCTAssertEqual(balanceInfo.name, "Test Account")
        XCTAssertEqual(balanceInfo.balance, 0.0) // Should default to 0 for invalid balance
    }
    
    func test_balanceInfo_initializesCorrectly() throws {
        // Arrange & Act
        let balanceInfo = AccountServiceResponse.BalanceInfo(
            id: 789,
            name: "Checking Account",
            balance: 500.25
        )
        
        // Assert
        XCTAssertEqual(balanceInfo.id, 789)
        XCTAssertEqual(balanceInfo.name, "Checking Account")
        XCTAssertEqual(balanceInfo.balance, 500.25)
    }
} 
