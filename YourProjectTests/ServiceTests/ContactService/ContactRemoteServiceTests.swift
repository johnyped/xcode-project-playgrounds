//
//  ContactRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class ContactRemoteServiceTests: XCTestCase {
    
    var sut: ContactRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = ContactRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - FetchByHotel Tests
    
    func test_fetchByHotel_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            businessType: nil,
            contactType: nil
        )
        
        let expectedContacts = [ContactStub.corporate]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedContacts),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.id, ContactStub.corporate.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByCompany Tests
    
    func test_fetchByCompany_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCompany(
            hotelId: 105,
            companyId: 123,
            page: 1,
            perPage: .ten,
            sortedBy: .companyName,
            sortedOrder: .ascending,
            businessType: nil,
            contactType: nil
        )
        
        let expectedContacts = [ContactStub.corporate]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedContacts),
            totalItems: 1,
            totalPages: 1,
            perPage: 10,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.companyId, 123)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByCustomer Tests
    
    func test_fetchByCustomer_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.FetchByCustomer(
            hotelId: 105,
            customerId: 456,
            page: 1,
            perPage: .fifty,
            sortedBy: .createdAt,
            sortedOrder: .descending,
            businessType: nil,
            contactType: nil
        )
        
        let expectedContacts = [ContactStub.individual]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedContacts),
            totalItems: 1,
            totalPages: 1,
            perPage: 50,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByCustomer(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.customerId, 456)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchById Tests
    
    func test_fetchById_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.FetchById(id: 18)
        let expectedContact = ContactStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedContact)
        
        // Act
        let result = try await sut.fetchById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 18)
        XCTAssertEqual(result.companyName, expectedContact.companyName)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - CreateContact Tests
    
    func test_createContact_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.CreateContact(
            businessType: .corporate,
            companyName: "New Company Ltd.",
            contactType: .client,
            contactId: nil,
            address: "123 New Street",
            branchName: "Main Branch",
            branchCode: "MB001",
            mobile: "0812345678",
            email: "new@company.com",
            phone: "021234567",
            faxNumber: nil,
            taxId: "1234567890123",
            website: "https://newcompany.com",
            creditDate: nil,
            hotelId: 105,
            customerId: nil,
            companyId: nil
        )
        
        let expectedContact = ContactStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedContact)
        
        // Act
        let result = try await sut.createContact(request: request)
        
        // Assert
        XCTAssertEqual(result.businessType, .corporate)
        XCTAssertEqual(result.contactType, .client)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - UpdateContact Tests
    
    func test_updateContact_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.UpdateContact(
            id: 18,
            businessType: .corporate,
            companyName: "Updated Company Name",
            contactType: nil,
            contactId: nil,
            address: "Updated Address",
            branchName: nil,
            branchCode: nil,
            mobile: "0899999999",
            email: "updated@company.com",
            phone: nil,
            faxNumber: nil,
            taxId: nil,
            website: "https://updated.com",
            creditDate: nil,
            customerId: nil,
            companyId: 999
        )
        
        let expectedContact = ContactStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedContact)
        
        // Act
        let result = try await sut.updateContact(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 18)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - DeleteContact Tests
    
    func test_deleteContact_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = ContactServiceRequest.DeleteContact(id: 18)
        let expectedContact = ContactStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedContact)
        
        // Act
        let result = try await sut.deleteContact(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 18)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
}

// MARK: - Contact Test Stubs

extension ContactRemoteServiceTests {
    
    enum ContactStub {
        static let corporate = Contact(
            id: 18,
            businessType: .corporate,
            companyName: "Test Company Ltd.",
            contactType: .client,
            contactId: nil,
            address: "123 Test Street, Bangkok",
            branchName: "Main Branch",
            branchCode: "MB001",
            mobile: "0812345678",
            email: "test@company.com",
            phone: "021234567",
            faxNumber: "021234568",
            taxId: "1234567890123",
            website: "https://testcompany.com",
            creditDate: "2024-12-31",
            hotelId: 105,
            customerId: nil,
            companyId: 123,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        static let individual = Contact(
            id: 19,
            businessType: .individual,
            companyName: "John Doe",
            contactType: .host,
            contactId: nil,
            address: "456 Individual Street",
            branchName: "",
            branchCode: "",
            mobile: "",
            email: "john@example.com",
            phone: "0987654321",
            faxNumber: "",
            taxId: "9876543210987",
            website: "",
            creditDate: "",
            hotelId: 105,
            customerId: 456,
            companyId: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
} 
