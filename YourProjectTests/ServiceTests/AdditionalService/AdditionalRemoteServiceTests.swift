//
//  AdditionalRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class AdditionalRemoteServiceTests: XCTestCase {
    
    var sut: AdditionalRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = AdditionalRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchAdditionals
    
    func test_fetchAdditionals_success() async throws {
        // Arrange
        let request = AdditionalServiceRequest.FetchAdditionals(
            hotelId: 105,
            reservationId: 1067,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: .active
        )
        
        let expectedAdditionals = createMockAdditionalsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditionals)
        
        // Act
        let result = try await sut.fetchAdditionals(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedAdditionals.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedAdditionals.items.first?.id)
        XCTAssertEqual(result.items.first?.hotelId, 105)
        XCTAssertEqual(result.items.first?.reservationId, 1067)
        XCTAssertEqual(result.items.first?.status, .active)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchAdditionals_failure() async throws {
        // Arrange
       
        let request =  AdditionalServiceRequest.FetchAdditionals(
            hotelId: 105,
            reservationId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: nil
        )
        
        let error = APIError.unknownError(title: "Stub Error", subtitle: nil, underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (a,b) -> Paginator<Additional> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchAdditionals(request: request)
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
    
    // MARK: - Test fetchAdditionalById
    
    func test_fetchAdditionalById_success() async throws {
        // Arrange
        let request = AdditionalServiceRequest.FetchById(id: 273)
        let expectedAdditional = createMockAdditional()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditional)
        
        // Act
        let result = try await sut.fetchAdditionalById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAdditional.id)
        XCTAssertEqual(result.hotelId, expectedAdditional.hotelId)
        XCTAssertEqual(result.reservationId, expectedAdditional.reservationId)
        XCTAssertEqual(result.status, expectedAdditional.status)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchAdditionalsByCreatedAt
    
    func test_fetchAdditionalsByCreatedAt_success() async throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1619452800)
        let endDate = Date(timeIntervalSince1970: 1745452800)
        
        let request = AdditionalServiceRequest.FetchAdditionalsByCreatedAt(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            periodDate: PeriodDate(start: startDate,
                                   end: endDate),
            status: .active
        )
        
        let expectedAdditionals = createMockAdditionalsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditionals)
        
        // Act
        let result = try await sut.fetchAdditionalsByCreatedAt(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedAdditionals.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedAdditionals.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchAdditionalsByDateIssue
    
    func test_fetchAdditionalsByDateIssue_success() async throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1619452800)
        let endDate = Date(timeIntervalSince1970: 1745452800)
        
        let request = AdditionalServiceRequest.FetchAdditionalsByDateIssue(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .dateIssue,
            sortedOrder: .descending,
            periodDate: PeriodDate(start: startDate,
                                   end: endDate),
            status: nil
        )
        
        let expectedAdditionals = createMockAdditionalsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditionals)
        
        // Act
        let result = try await sut.fetchAdditionalsByDateIssue(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedAdditionals.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedAdditionals.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createAdditional
    
    func test_createAdditional_success() async throws {
        // Arrange
        let dateIssue = Date(timeIntervalSince1970: 1619452800)
        
        let additionalItem = AdditionalServiceRequest.Item(
            price: 111.11,
            quantity: 1,
            itemableId: 130,
            itemableType: .foilo
        )
        
        let request = AdditionalServiceRequest.CreateAdditional(
            hotelId: 105,
            reservationId: 1067,
            note: "Test additional",
            dateIssue: dateIssue,
            additionalItems: [additionalItem]
        )
        
        let expectedAdditional = createMockAdditional()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditional)
        
        // Act
        let result = try await sut.createAdditional(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAdditional.id)
        XCTAssertEqual(result.hotelId, expectedAdditional.hotelId)
        XCTAssertEqual(result.reservationId, expectedAdditional.reservationId)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test updateAdditional
    
    func test_updateAdditional_success() async throws {
        // Arrange
        let request = AdditionalServiceRequest.UpdateAdditional(
            id: 273,
            status: "inactive",
            note: "Updated note",
            dateIssue: nil,
            additionalItems: nil
        )
        
        let expectedAdditional = createMockAdditional()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditional)
        
        // Act
        let result = try await sut.updateAdditional(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAdditional.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test deleteAdditional
    
    func test_deleteAdditional_success() async throws {
        // Arrange
        let request = AdditionalServiceRequest.DeleteAdditional(id: 273)
        
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act
        try await sut.deleteAdditional(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test voidAdditional
    
    func test_voidAdditional_success() async throws {
        // Arrange
        let request = AdditionalServiceRequest.VoidAdditional(id: 273)
        let expectedAdditional = createMockAdditional()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedAdditional)
        
        // Act
        let result = try await sut.voidAdditional(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedAdditional.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockAdditionalsPaginator() -> Paginator<Additional> {
        let additionals = [createMockAdditional()]
        return Paginator(
            items: Collection(array: additionals),
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
    
    private func createMockAdditional() -> Additional {
        let fixedDate = Date(timeIntervalSince1970: 1619452800) // 2021-04-26 12:00:00 UTC
        
        let additionalItem = AdditionalItem(
            id: 454,
            price: 111.11,
            quantity: 1,
            totalAmount: 111.11,
            itemableId: 130,
            itemableType: .foilo,
            additionalId: 273,
            createdAt: fixedDate,
            updatedAt: fixedDate
        )
        
        return Additional(
            id: 273,
            hotelId: 105,
            reservationId: 1067,
            status: .active,
            note: "Test additional", 
            dateIssue: fixedDate,
            totalAmount: 111.11,
            additionalItems: Collection(array: [additionalItem]),
            createdAt: fixedDate,
            updatedAt: fixedDate
        )
    }
} 
