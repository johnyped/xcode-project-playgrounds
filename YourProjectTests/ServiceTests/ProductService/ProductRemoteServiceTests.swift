//
//  ProductRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class ProductRemoteServiceTests: XCTestCase {
    
    var sut: ProductRemoteService!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    var mockAPIManager: MockAPIManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        mockAPIManager = MockAPIManagerProtocal()
        sut = ProductRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockLocalStorage = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchByHotel
    
    func testFetchByHotel_Success() async throws {
        // Arrange
        let expectedPaginator = createMockPaginator()
        
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "abc"
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.lists.count, 2)
        XCTAssertEqual(result.items.lists.first?.name, "Test Product 1")
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchByHotel_Failure_APIError() async throws {
        // Arrange
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "abc"
        )
        
        let error = APIError.unknownError(title: "Stub Error",
                                        subtitle: nil,
                                        underlying: nil)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> Paginator<Product> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchByHotel(request: request)
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
     
    // MARK: - Test fetchById
    
    func testFetchById_Success() async throws {
        // Arrange
        let expectedProduct = createMockProducts()[0]
        let request = ProductServiceRequest.FetchById(id: 2)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProduct)
        
        // Act
        let result = try await sut.fetchById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 2)
        XCTAssertEqual(result.name, "Test Product 1")
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createProduct
    
    func testCreateProduct_Success() async throws {
        // Arrange
        let expectedProduct = createMockProducts()[0]
        let request = ProductServiceRequest.CreateProduct(
            hotelId: 105,
            name: "New Product",
            description: "Test Description",
            barcode: "123456789",
            code: "PROD001",
            categoryId: 1,
            sellingPrice: 100.0,
            sellingVatOption: .excludedVat,
            buyingPrice: 80.0,
            buyingVatOption: .includedVat
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProduct)
        
        // Act
        let result = try await sut.createProduct(request: request)
        
        // Assert
        XCTAssertEqual(result.name, "Test Product 1")
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test updateProduct
    
    func testUpdateProduct_Success() async throws {
        // Arrange
        let expectedProduct = createMockProducts()[0]
        let request = ProductServiceRequest.UpdateProduct(
            id: 2,
            hotelId: 105,
            name: "Updated Product",
            description: "Updated Description",
            barcode: "987654321",
            code: "PROD002",
            categoryId: 2,
            sellingPrice: 120.0,
            sellingVatOption: .includedVat,
            buyingPrice: 90.0,
            buyingVatOption: .excludedVat
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProduct)
        
        // Act
        let result = try await sut.updateProduct(request: request)
        
        // Assert
        XCTAssertEqual(result.name, "Test Product 1")
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test deleteProduct
    
    func testDeleteProduct_Success() async throws {
        // Arrange
        let expectedProduct = createMockProducts()[0]
        let request = ProductServiceRequest.DeleteProduct(id: 2)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProduct)
        
        // Act
        let result = try await sut.deleteProduct(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 2)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockProducts() -> [Product] {
        return [
            Product(
                id: 2,
                hotelId: 105,
                name: "Test Product 1",
                description: "Test Description 1",
                barcode: "123456789",
                code: "PROD001",
                categoryId: 1,
                sellingPrice: 11.11,
                sellingVatOption: .excludedVat,
                buyingPrice: 22.22,
                buyingVatOption: .includedVat,
                createdAt: Date(),
                updatedAt: Date()
            ),
            Product(
                id: 3,
                hotelId: 105,
                name: "Test Product 2",
                description: "Test Description 2",
                barcode: "987654321",
                code: "PROD002",
                categoryId: 2,
                sellingPrice: 33.33,
                sellingVatOption: .includedVat,
                buyingPrice: 44.44,
                buyingVatOption: .excludedVat,
                createdAt: Date(),
                updatedAt: Date()
            )
        ]
    }
    
    private func createMockPaginator() -> Paginator<Product> {
        let products = createMockProducts()
        return Paginator<Product>(
            items: Collection(array: products),
            totalItems: 2,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
}
