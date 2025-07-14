//
//  AccountServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

class AccountServiceRequestTests: XCTestCase {
    
    // MARK: - Test FetchAccounts
    
    func test_fetchAccounts_encodesCorrectly() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: .savings,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "SAVINGS")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchAccounts_optionalFields_nil() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["kind"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    func test_fetchAccounts_invalidPage_notEncoded() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: .checking,
            page: 0, // Invalid page (< 1)
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "CHECKING")
        XCTAssertNil(parameters?["page"]) // Should be nil because < 1
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - Test FetchAccountBalance
    
    func test_fetchAccountBalance_encodesCorrectly() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: Date(timeIntervalSince1970: 1609430399.999) // 2020-12-31T23:59:59.999+07:00
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["limit_datetime"] as? String, "2020-12-31T22:59:59.999+07:00")
    }
    
    func test_fetchAccountBalance_optionalFields_nil() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["id"] as? Int, 123)
        XCTAssertNil(parameters?["limit_datetime"])
    }
    
    // MARK: - Test CreateAccount
    
    func test_createAccount_encodesToBody() throws {
        // Arrange
        let openDate = Date(timeIntervalSince1970: 1589001600) // 2020-05-09
        let request = AccountServiceRequest.CreateAccount(
            name: "Test Account",
            startBalance: 1000.0,
            kind: .savings,
            currency: "THB",
            openDate: openDate,
            isDefault: false,
            colorRef: 0,
            iconRef: 0,
            hotelId: 105
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertEqual(json["name"] as? String, "Test Account")
        XCTAssertEqual(json["start_balance"] as? String, "1000.0")
        XCTAssertEqual(json["kind"] as? String, "SAVINGS")
        XCTAssertEqual(json["currency"] as? String, "THB")
        XCTAssertEqual(json["open_date"] as? String, "2020-05-09")
        XCTAssertEqual(json["is_default"] as? Bool, false)
        XCTAssertEqual(json["color_ref"] as? Int, 0)
        XCTAssertEqual(json["icon_ref"] as? Int, 0)
        XCTAssertEqual(json["hotel_id"] as? Int, 105)
    }
    
    func test_createAccount_optionalFields_nil() throws {
        // Arrange
        let openDate = Date(timeIntervalSince1970: 1589001600) // 2020-05-09
        let request = AccountServiceRequest.CreateAccount(
            name: "Test Account",
            startBalance: 1000.0,
            kind: .cash,
            currency: "USD",
            openDate: openDate,
            isDefault: nil,
            colorRef: nil,
            iconRef: nil,
            hotelId: 105
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertEqual(json["name"] as? String, "Test Account")
        XCTAssertEqual(json["start_balance"] as? String, "1000.0")
        XCTAssertEqual(json["kind"] as? String, "CASH")
        XCTAssertEqual(json["currency"] as? String, "USD")
        XCTAssertEqual(json["open_date"] as? String, "2020-05-09")
        XCTAssertEqual(json["hotel_id"] as? Int, 105)
        XCTAssertNil(json["is_default"])
        XCTAssertNil(json["color_ref"])
        XCTAssertNil(json["icon_ref"])
    }
    
    // MARK: - Test UpdateAccount
    
    func test_updateAccount_encodesToBody() throws {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            kind: .checking,
            colorRef: 1,
            iconRef: 1
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertEqual(json["name"] as? String, "Updated Account")
        XCTAssertEqual(json["kind"] as? String, "CHECKING")
        XCTAssertEqual(json["color_ref"] as? Int, 1)
        XCTAssertEqual(json["icon_ref"] as? Int, 1)
        
        // Verify id is not encoded in body (it's used in URL path)
        XCTAssertNil(json["id"])
    }
    
    func test_updateAccount_optionalFields_nil() throws {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: nil,
            kind: nil,
            colorRef: nil,
            iconRef: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertNil(json["name"])
        XCTAssertNil(json["kind"])
        XCTAssertNil(json["color_ref"])
        XCTAssertNil(json["icon_ref"])
        XCTAssertNil(json["id"])
    }
} 
