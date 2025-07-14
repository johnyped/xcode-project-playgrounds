//
//  CompanyRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class CompanyRemoteServiceTests: XCTestCase {
    
    var sut: CompanyRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = CompanyRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
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
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            query: "Test Company",
            onlyHidden: false,
            businessType: .corporate
        )
        
        let expectedCompanies = [CompanyStub.corporate]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedCompanies),
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
        XCTAssertEqual(result.items.first?.id, CompanyStub.corporate.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByGuest Tests
    
    func test_fetchByGuest_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByGuest(
            guestId: 310,
            page: 1,
            perPage: .ten,
            sortedBy: .name,
            sortedOrder: .ascending,
            businessType: .individual
        )
        
        let expectedCompanies = [CompanyStub.individual]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedCompanies),
            totalItems: 1,
            totalPages: 1,
            perPage: 10,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.name, CompanyStub.individual.name)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByHotel with BusinessType Filter Tests
    
    func test_fetchByHotel_withBusinessTypeFilter_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .fifty,
            sortedBy: .name,
            sortedOrder: .descending,
            query: nil,
            onlyHidden: nil,
            businessType: .individual
        )
        
        let expectedCompanies = [CompanyStub.individual]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedCompanies),
            totalItems: 1,
            totalPages: 1,
            perPage: 50,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.busineseType, .individual)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchByHotel_withNilBusinessType_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            query: nil,
            onlyHidden: false,
            businessType: nil
        )
        
        let expectedCompanies = [CompanyStub.corporate, CompanyStub.individual]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedCompanies),
            totalItems: 2,
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
        XCTAssertEqual(result.items.count, 2)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchByGuest with BusinessType Filter Tests
    
    func test_fetchByGuest_withBusinessTypeFilter_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByGuest(
            guestId: 310,
            page: 1,
            perPage: .hundred,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            businessType: .corporate
        )
        
        let expectedCompanies = [CompanyStub.corporate]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedCompanies),
            totalItems: 1,
            totalPages: 1,
            perPage: 100,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.busineseType, .corporate)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchByGuest_withNilBusinessType_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.FetchByGuest(
            guestId: 310,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            businessType: nil
        )
        
        let expectedCompanies = [CompanyStub.corporate, CompanyStub.individual]
        let expectedPaginator = Paginator(
            items: Collection(array: expectedCompanies),
            totalItems: 2,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 2)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchById Tests
    
    func test_fetchById_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.FetchById(id: 6)
        let expectedCompany = CompanyStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCompany)
        
        // Act
        let result = try await sut.fetchById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 6)
        XCTAssertEqual(result.name, expectedCompany.name)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - CreateCompany Tests
    
    func test_createCompany_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.CreateCompany(
            userId: 38,
            hotelId: 105,
            businessType: .corporate,
            contactId: nil,
            name: "New Company Ltd.",
            address: "123 New Street",
            district: "New District",
            province: "New Province",
            zipCode: "12345",
            country: "THA",
            taxID: "1234567890123",
            branchName: "Main Branch",
            branchCode: "001",
            phone: "0812345678",
            fax: nil,
            email: "new@company.com",
            taxIncluded: false,
            logoUrl: nil
        )
        
        let expectedCompany = CompanyStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCompany)
        
        // Act
        let result = try await sut.createCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.busineseType, .corporate)
        XCTAssertEqual(result.hotelId, 105)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - UpdateCompany Tests
    
    func test_updateCompany_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.UpdateCompany(
            id: 6,
            userId: 38,
            businessType: .corporate,
            contactId: nil,
            name: "Updated Company Name",
            address: nil,
            district: nil,
            province: nil,
            zipCode: nil,
            country: nil,
            taxID: nil,
            branchName: "Updated Branch",
            branchCode: nil,
            phone: "0999999999",
            fax: nil,
            email: "updated@company.com",
            taxIncluded: true,
            logoUrl: nil
        )
        
        let expectedCompany = CompanyStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCompany)
        
        // Act
        let result = try await sut.updateCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 6)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - HideCompany Tests
    
    func test_hideCompany_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.HideCompany(id: 6)
        let expectedCompany = CompanyStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCompany)
        
        // Act
        let result = try await sut.hideCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 6)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - UnhideCompany Tests
    
    func test_unhideCompany_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.UnhideCompany(id: 6)
        let expectedCompany = CompanyStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCompany)
        
        // Act
        let result = try await sut.unhideCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 6)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - DeleteCompany Tests
    
    func test_deleteCompany_callsAPIManagerWithCorrectRouter() async throws {
        // Arrange
        let request = CompanyServiceRequest.DeleteCompany(id: 6)
        let expectedCompany = CompanyStub.corporate
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCompany)
        
        // Act
        let result = try await sut.deleteCompany(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 6)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
}

// MARK: - Company Test Stubs

extension CompanyRemoteServiceTests {
    
    enum CompanyStub {
        static let corporate = Company(
            id: 6,
            userId: 38,
            hotelId: 105,
            busineseType: .corporate,
            contactId: nil,
            name: "Test Company Ltd.",
            address: Address(
                houseNumber: "992/1",
                district: "Bang Bua Thong",
                province: "Nonthaburi",
                zipCode: "11110",
                countryCode: "THA"
            ),
            taxID: "9999999999999",
            taxIncluded: false,
            branchName: "สำนักงานใหญ่",
            branchCode: "001",
            phone: "0928228229",
            fax: "2222222222",
            email: "abc@email.com",
            isHidden: false,
            logoUrl: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        static let individual = Company(
            id: 7,
            userId: nil,
            hotelId: 105,
            busineseType: .individual,
            contactId: nil,
            name: "Individual Company",
            address: Address(
                houseNumber: "123 Individual Street",
                district: "Individual District",
                province: "Individual Province",
                zipCode: "12345",
                countryCode: "THA"
            ),
            taxID: "1234567890123",
            taxIncluded: true,
            branchName: "Main Branch",
            branchCode: "001",
            phone: "0987654321",
            fax: "",
            email: "individual@example.com",
            isHidden: false,
            logoUrl: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
} 
