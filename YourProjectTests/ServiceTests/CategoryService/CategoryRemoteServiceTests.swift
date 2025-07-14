//
//  CategoryRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class CategoryRemoteServiceTests: XCTestCase {
    
    var sut: CategoryRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = CategoryRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - FetchCategories Tests
    
    func test_fetchCategories_success() async throws {
        // Arrange
        let request = CategoryServiceRequest.FetchCategories(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            kind: .product
        )
        
        let category = createMockCategory()
        let collection = Categories(array: [category])
        let mockPaginator = Paginator<Category>(
            items: collection,
            totalItems: 1,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(mockPaginator)
        
        // Act
        let result = try await sut.fetchCategories(request: request)
        
        // Assert
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items.first?.id, 1)
        XCTAssertEqual(result.items.first?.name, "Test Category")
        XCTAssertEqual(result.items.first?.kind, .product)
        XCTAssertEqual(result.items.first?.hotelId, 105)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchCategories_failure() async throws {
        // Arrange
        let request = CategoryServiceRequest.FetchCategories(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            kind: nil
        )
        
        let expectError = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> Paginator<Category> in
                throw expectError
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchCategories(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _ , _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail()
            }
        }
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - FetchCategoryById Tests
    
    func test_fetchCategoryById_success() async throws {
        // Arrange
        let request = CategoryServiceRequest.FetchById(id: 1)
        let mockCategory = createMockCategory()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(mockCategory)
        
        // Act
        let result = try await sut.fetchCategoryById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Test Category")
        XCTAssertEqual(result.kind, .product)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - CreateCategory Tests
    
    func test_createCategory_success() async throws {
        // Arrange
        let request = CategoryServiceRequest.CreateCategory(
            hotelId: 105,
            name: "New Category",
            kind: .service
        )
        
        let mockCategory = createMockCategory(
            name: "New Category",
            kind: .service
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(mockCategory)
        
        // Act
        let result = try await sut.createCategory(request: request)
        
        // Assert
        XCTAssertEqual(result.name, "New Category")
        XCTAssertEqual(result.kind, .service)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - UpdateCategory Tests
    
    func test_updateCategory_success() async throws {
        // Arrange
        let request = CategoryServiceRequest.UpdateCategory(
            id: 1,
            name: "Updated Category",
            kind: .product
        )
        
        let mockCategory = createMockCategory(
            name: "Updated Category",
            kind: .product
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(mockCategory)
        
        // Act
        let result = try await sut.updateCategory(request: request)
        
        // Assert
        XCTAssertEqual(result.name, "Updated Category")
        XCTAssertEqual(result.kind, .product)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - DeleteCategory Tests
    
    func test_deleteCategory_success() async throws {
        // Arrange
        let request = CategoryServiceRequest.DeleteCategory(id: 1)
        
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act
        try await sut.deleteCategory(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockCategory(
        id: Int = 1,
        name: String = "Test Category",
        kind: Category.Kind = .product,
        hotelId: Int = 105
    ) -> Category {
        let fixedDate = Date(timeIntervalSince1970: 1619452800) // 2021-04-26 12:00:00 UTC
        
        return Category(
            id: id,
            name: name,
            kind: kind,
            hotelId: hotelId,
            createdAt: fixedDate,
            updatedAt: fixedDate
        )
    }
} 
