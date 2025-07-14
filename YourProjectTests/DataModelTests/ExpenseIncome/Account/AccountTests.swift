//
//  AccountTests.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

final class AccountTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let account = createSampleAccount()
        
        // Assert
        XCTAssertEqual(account.id, 1)
        XCTAssertEqual(account.name, "บัญชี รอง")
        XCTAssertEqual(account.startBalance, 100.0)
        XCTAssertEqual(account.kind, .savings)
        XCTAssertEqual(account.currency, "THB")
        XCTAssertEqual(account.isDefault, false)
        XCTAssertEqual(account.colorRef, 0)
        XCTAssertEqual(account.iconRef, 0)
        XCTAssertEqual(account.hotelId, 105)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let account = createSampleAccount()
        
        // Assert
        XCTAssertNotNil(account.openDate)
        XCTAssertNotNil(account.createdAt)
        XCTAssertNotNil(account.updatedAt)
        XCTAssertEqual(account.openDate, "2020-05-09".toDate(FormConfig.DateFormat.yyyyMMdd))
    }
    
    // MARK: - Kind Enum Tests
    
    func test_kindRawValues() throws {
        XCTAssertEqual(Account.Kind.savings.rawValue, "SAVINGS")
        XCTAssertEqual(Account.Kind.others.rawValue, "OTHERS")
        XCTAssertEqual(Account.Kind.savings.rawValue, "SAVINGS")
        XCTAssertEqual(Account.Kind.loan.rawValue, "LOAN")
        XCTAssertEqual(Account.Kind.investing.rawValue, "INVESTING")
        XCTAssertEqual(Account.Kind.debitCard.rawValue, "DEBIT_CARD")
        XCTAssertEqual(Account.Kind.creditCard.rawValue, "CREDIT_CARD")
        XCTAssertEqual(Account.Kind.checking.rawValue, "CHECKING")
        XCTAssertEqual(Account.Kind.cash.rawValue, "CASH")
        XCTAssertEqual(Account.Kind.asset.rawValue, "ASSET")
    }
    
    func test_kindDecodingFromString() throws {
        XCTAssertEqual(Account.Kind(rawValue: "SAVINGS"), .savings)
        XCTAssertEqual(Account.Kind(rawValue: "CASH"), .cash)
        XCTAssertEqual(Account.Kind(rawValue: "CHECKING"), .checking)
        XCTAssertEqual(Account.Kind(rawValue: "DEBIT_CARD"), .debitCard)
        XCTAssertEqual(Account.Kind(rawValue: "CREDIT_CARD"), .creditCard)
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
           "id": 1,
           "name": "บัญชี รอง",
           "start_balance": "100.0",
           "kind": "SAVINGS",
           "currency": "THB",
           "open_date": "2020-05-09",
           "is_default": false,
           "color_ref": 0,
           "icon_ref": 0,
           "created_at": "2020-05-09T11:57:30.835+07:00",
           "updated_at": "2020-06-17T14:39:16.935+07:00",
           "hotel_id": 105
        }
        """.data(using: .utf8)!
        
        // Act
        let account = try JSONDecoder().decode(Account.self, from: json)
        
        // Assert
        XCTAssertEqual(account.id, 1)
        XCTAssertEqual(account.name, "บัญชี รอง")
        XCTAssertEqual(account.startBalance, 100.0)
        XCTAssertEqual(account.kind, .savings)
        XCTAssertEqual(account.currency, "THB")
        XCTAssertEqual(account.openDate, "2020-05-09".toDate(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(account.isDefault, false)
        XCTAssertEqual(account.colorRef, 0)
        XCTAssertEqual(account.iconRef, 0)
        XCTAssertEqual(account.hotelId, 105)
        XCTAssertNotNil(account.createdAt)
        XCTAssertNotNil(account.updatedAt)
        XCTAssertEqual(account.createdAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-05-09")
        XCTAssertEqual(account.updatedAt.toDateString(FormConfig.DateFormat.yyyyMMdd), "2020-06-17")
    }
    
    func test_decodingFromJSONWithStringBalance() throws {
        // Arrange - Test that string balance converts to double
        let json = """
        {
           "id": 2,
           "name": "Test Account",
           "start_balance": "2500.50",
           "kind": "CASH",
           "currency": "USD",
           "open_date": "2023-01-15",
           "is_default": true,
           "color_ref": 1,
           "icon_ref": 2,
           "created_at": "2023-01-15T10:30:45.123+07:00",
           "updated_at": "2023-01-15T10:30:45.123+07:00",
           "hotel_id": 200
        }
        """.data(using: .utf8)!
        
        // Act
        let account = try JSONDecoder().decode(Account.self, from: json)
        
        // Assert
        XCTAssertEqual(account.startBalance, 2500.50)
        XCTAssertEqual(account.kind, .cash)
        XCTAssertEqual(account.currency, "USD")
        XCTAssertEqual(account.isDefault, true)
        XCTAssertEqual(account.colorRef, 1)
        XCTAssertEqual(account.iconRef, 2)
        XCTAssertEqual(account.hotelId, 200)
    }
    
    func test_decodingFromJSONWithInvalidBalance() throws {
        // Arrange - Test that invalid balance defaults to 0.0
        let json = """
        {
           "id": 3,
           "name": "Invalid Balance Account",
           "start_balance": "invalid",
           "kind": "CHECKING",
           "currency": "EUR",
           "open_date": "2023-02-01",
           "is_default": false,
           "color_ref": 2,
           "icon_ref": 3,
           "created_at": "2023-02-01T12:00:00.000+07:00",
           "updated_at": "2023-02-01T12:00:00.000+07:00",
           "hotel_id": 300
        }
        """.data(using: .utf8)!
        
        // Act
        let account = try JSONDecoder().decode(Account.self, from: json)
        
        // Assert
        XCTAssertEqual(account.startBalance, 0.0)
        XCTAssertEqual(account.kind, .checking)
        XCTAssertEqual(account.currency, "EUR")
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let account = createSampleAccount()
        
        // Act
        let encodedData = try JSONEncoder().encode(account)
        let decodedAccount = try JSONDecoder().decode(Account.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedAccount.id, account.id)
        XCTAssertEqual(decodedAccount.name, account.name)
        XCTAssertEqual(decodedAccount.startBalance, account.startBalance)
        XCTAssertEqual(decodedAccount.kind, account.kind)
        XCTAssertEqual(decodedAccount.currency, account.currency)
        XCTAssertEqual(decodedAccount.openDate.toDateString(FormConfig.DateFormat.yyyyMMdd), 
                      account.openDate.toDateString(FormConfig.DateFormat.yyyyMMdd))
        XCTAssertEqual(decodedAccount.isDefault, account.isDefault)
        XCTAssertEqual(decodedAccount.colorRef, account.colorRef)
        XCTAssertEqual(decodedAccount.iconRef, account.iconRef)
        XCTAssertEqual(decodedAccount.hotelId, account.hotelId)
    }
    
    func test_encodingStartBalanceAsString() throws {
        // Arrange
        let account = createSampleAccount()
        
        // Act
        let encodedData = try JSONEncoder().encode(account)
        let jsonObject = try JSONSerialization.jsonObject(with: encodedData) as! [String: Any]
        
        // Assert - Check that start_balance is encoded as string
        XCTAssertTrue(jsonObject["start_balance"] is String)
        XCTAssertEqual(jsonObject["start_balance"] as! String, "100.0")
    }
    
    func test_encodingDatesInCorrectFormat() throws {
        // Arrange
        let account = createSampleAccount()
        
        // Act
        let encodedData = try JSONEncoder().encode(account)
        let jsonObject = try JSONSerialization.jsonObject(with: encodedData) as! [String: Any]
        
        // Assert - Check date formats
        XCTAssertEqual(jsonObject["open_date"] as! String, "2020-05-09")
        XCTAssertTrue((jsonObject["created_at"] as! String).contains("T"))
        XCTAssertTrue((jsonObject["updated_at"] as! String).contains("T"))
    }
    
    // MARK: - Helper Methods
    
    private func createSampleAccount() -> Account {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return Account(
            id: 1,
            name: "บัญชี รอง",
            startBalance: 100.0,
            kind: .savings,
            currency: "THB",
            openDate: "2020-05-09".toDate(FormConfig.DateFormat.yyyyMMdd) ?? .now,
            isDefault: false,
            colorRef: 0,
            iconRef: 0,
            createdAt: dateFormatter.date(from: "2020-05-09T11:57:30.835+07:00") ?? .now,
            updatedAt: dateFormatter.date(from: "2020-06-17T14:39:16.935+07:00") ?? .now,
            hotelId: 105
        )
    }
    
    private func createAccountWithKind(_ kind: Account.Kind) -> Account {
        return Account(
            id: 999,
            name: "Test Account",
            startBalance: 1000.0,
            kind: kind,
            currency: "THB",
            openDate: Date(),
            isDefault: false,
            colorRef: 0,
            iconRef: 0,
            createdAt: Date(),
            updatedAt: Date(),
            hotelId: 105
        )
    }
} 
