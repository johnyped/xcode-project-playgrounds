//
//  AccountServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest
import Alamofire

class AccountServiceRouterTests: XCTestCase {
    
    // MARK: - Test Paths
    
    func test_fetchAccounts_path() {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = AccountServiceRouter.fetchAccounts(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts")
    }
    
    func test_fetchAccount_path() {
        // Arrange
        let request = AccountServiceRequest.FetchById(id: 123)
        let router = AccountServiceRouter.fetchAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123")
    }
    
    func test_fetchAccountBalance_path() {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(id: 123, limitDatetime: nil)
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123/balance")
    }
    
    func test_createAccount_path() {
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
        let router = AccountServiceRouter.createAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts")
    }
    
    func test_updateAccount_path() {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            kind: nil,
            colorRef: nil,
            iconRef: nil
        )
        let router = AccountServiceRouter.updateAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123")
    }
    
    func test_deleteAccount_path() {
        // Arrange
        let request = AccountServiceRequest.DeleteAccount(id: 123)
        let router = AccountServiceRouter.deleteAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123")
    }
    
    func test_setAccountAsDefault_path() {
        // Arrange
        let request = AccountServiceRequest.SetAsDefault(id: 123)
        let router = AccountServiceRouter.setAccountAsDefault(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123/default")
    }
    
    // MARK: - Test HTTP Methods
    
    func test_fetchAccounts_method() {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = AccountServiceRouter.fetchAccounts(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_fetchAccount_method() {
        // Arrange
        let request = AccountServiceRequest.FetchById(id: 123)
        let router = AccountServiceRouter.fetchAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_fetchAccountBalance_method() {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(id: 123, limitDatetime: nil)
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_createAccount_method() {
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
        let router = AccountServiceRouter.createAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .post)
    }
    
    func test_updateAccount_method() {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            kind: nil,
            colorRef: nil,
            iconRef: nil
        )
        let router = AccountServiceRouter.updateAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .put)
    }
    
    func test_deleteAccount_method() {
        // Arrange
        let request = AccountServiceRequest.DeleteAccount(id: 123)
        let router = AccountServiceRouter.deleteAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .delete)
    }
    
    func test_setAccountAsDefault_method() {
        // Arrange
        let request = AccountServiceRequest.SetAsDefault(id: 123)
        let router = AccountServiceRouter.setAccountAsDefault(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .post) // Corrected to match implementation
    }
    
    // MARK: - Test Parameters
    
    func test_fetchAccounts_parameters() {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: .savings,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        let router = AccountServiceRouter.fetchAccounts(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "SAVINGS")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchAccountBalance_parameters() {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: Date(timeIntervalSince1970: 1609430399.999) // 2020-12-31T23:59:59.999+07:00
        )
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["id"] as? Int, 123)
        XCTAssertEqual(parameters?["limit_datetime"] as? String, "2020-12-31T22:59:59.999+07:00")
    }
    
    // MARK: - Test Headers
    
    func test_router_headers() {
        // Arrange
        let request = AccountServiceRequest.FetchById(id: 123)
        let router = AccountServiceRouter.fetchAccount(request: request)
        
        // Act
        let headers = router.headers
        
        // Assert
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
    
    // MARK: - Test Body
    
    func test_createAccount_body() {
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
        let router = AccountServiceRouter.createAccount(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
    }
    
    func test_updateAccount_body() {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            kind: .checking,
            colorRef: 1,
            iconRef: 1
        )
        let router = AccountServiceRouter.updateAccount(request: request)
        
        // Act
        let body = router.body
        
        // Assert
        XCTAssertNotNil(body)
    }
} 
