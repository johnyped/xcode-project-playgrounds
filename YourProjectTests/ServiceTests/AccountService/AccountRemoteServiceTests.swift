//
//  AccountRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest
import Mockable

class AccountRemoteServiceTests: XCTestCase {
    
    var sut: AccountRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = AccountRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchAccounts
    
    func test_fetchAccounts_success() async throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: .savings,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let expectedAccounts = createMockAccountsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccounts)
        
        // Act
        let result = try await sut.fetchAccounts(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedAccounts.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedAccounts.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchAccounts_failure() async throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )
        
        let error = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (a, b) -> Paginator<Account> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchAccounts(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _, _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail("Unexpected error type")
            }
        }
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchAccount
    
    func test_fetchAccount_success() async throws {
        // Arrange
        let request = AccountServiceRequest.FetchById(id: 123)
        let expectedAccount = createMockAccount()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccount)
        
        // Act
        let result = try await sut.fetchAccount(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAccount.id)
        XCTAssertEqual(result.name, expectedAccount.name)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchAccountBalance
    
    func test_fetchAccountBalance_success() async throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: Date(timeIntervalSince1970: 1609430399.999) // 2020-12-31T23:59:59.999+07:00
        )
        let expectedBalance = AccountServiceResponse.BalanceInfo(
            id: 123,
            name: "Test Account",
            balance: 1000.00
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedBalance)
        
        // Act
        let result = try await sut.fetchAccountBalance(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedBalance.id)
        XCTAssertEqual(result.name, expectedBalance.name)
        XCTAssertEqual(result.balance, expectedBalance.balance)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createAccount
    
    func test_createAccount_success() async throws {
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
        let expectedAccount = createMockAccount()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccount)
        
        // Act
        let result = try await sut.createAccount(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAccount.id)
        XCTAssertEqual(result.name, expectedAccount.name)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test updateAccount
    
    func test_updateAccount_success() async throws {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            kind: .checking,
            colorRef: 1,
            iconRef: 1
        )
        let expectedAccount = createMockAccount()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccount)
        
        // Act
        let result = try await sut.updateAccount(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAccount.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test deleteAccount
    
    func test_deleteAccount_success() async throws {
        // Arrange
        let request = AccountServiceRequest.DeleteAccount(id: 123)
        
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act
        try await sut.deleteAccount(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test setAccountAsDefault
    
    func test_setAccountAsDefault_success() async throws {
        // Arrange
        let request = AccountServiceRequest.SetAsDefault(id: 123)
        let expectedAccount = createMockAccount()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAccount)
        
        // Act
        let result = try await sut.setAccountAsDefault(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAccount.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockAccount() -> Account {
        return Account(
            id: 1,
            name: "Test Account",
            startBalance: 100.0,
            kind: .savings,
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
    
    private func createMockAccountsPaginator() -> Paginator<Account> {
        let account = createMockAccount()
        return Paginator<Account>(items: Accounts(array: [account]),
                                  totalItems: 1,
                                  totalPages: 1,
                                  perPage: 20,
                                  page: 1)
        
    }
} 
