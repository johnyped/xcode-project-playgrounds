//
//  ProductUnitRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable


class ProductUnitRemoteServiceTests: XCTestCase {
    
    var sut: ProductUnitRemoteService!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    var mockAPIManager: MockAPIManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        mockAPIManager = MockAPIManagerProtocal()
        sut = ProductUnitRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
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
        let expectedPaginator = createMockProductUnitPaginator()
        
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: nil
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.lists.count, 2)
        XCTAssertEqual(result.items.lists.first?.unit, "piece")
        XCTAssertEqual(result.items.lists.first?.kind, .product)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchByHotel_Failure_APIError() async throws {
        // Arrange
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: nil
        )
        
        let error = APIError.unknownError(title: "Stub Error",
                                        subtitle: nil,
                                        underlying: nil)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> Paginator<ProductUnit> in
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
        let expectedProductUnit = createMockProductUnits()[0]
        let request = ProductUnitServiceRequest.FetchById(id: 1)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProductUnit)
        
        // Act
        let result = try await sut.fetchById(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.unit, "piece")
        XCTAssertEqual(result.kind, .product)
        XCTAssertEqual(result.hotelId, 105)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchById_Failure_NotFound() async throws {
        // Arrange
        let request = ProductUnitServiceRequest.FetchById(id: 999)
                
        let error = APIError.unknownError(title: "ProductUnit not found",
                                          subtitle: nil,
                                          underlying: nil)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> ProductUnit in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchById(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _, _):
                XCTAssertEqual(title, "ProductUnit not found")
            default:
                XCTFail("Unexpected error type")
            }
        }
    }
    
    // MARK: - Test createProductUnit
    
    func testCreateProductUnit_Success() async throws {
        // Arrange
        let expectedProductUnit = createMockProductUnits()[0]
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "piece",
            kind: .product
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProductUnit)
        
        // Act
        let result = try await sut.createProductUnit(request: request)
        
        // Assert
        XCTAssertEqual(result.unit, "piece")
        XCTAssertEqual(result.kind, .product)
        XCTAssertEqual(result.hotelId, 105)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testCreateProductUnit_Failure_ValidationError() async throws {
        // Arrange
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "", // Invalid empty unit
            kind: .product
        )
        
        let error = APIError.unknownError(title: "Validation failed",
                                          subtitle: "Unit cannot be empty",
                                          underlying: nil)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> ProductUnit in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.createProductUnit(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, let subtitle, _):
                XCTAssertEqual(title, "Validation failed")
                XCTAssertEqual(subtitle, "Unit cannot be empty")
            default:
                XCTFail("Unexpected error type")
            }
        }
    }
    
    // MARK: - Test updateProductUnit
    
    func testUpdateProductUnit_Success() async throws {
        // Arrange
        let expectedProductUnit = ProductUnit(
            id: 1,
            unit: "kilogram",
            kind: .service,
            hotelId: 105,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let request = ProductUnitServiceRequest.UpdateProductUnit(
            id: 1,
            hotelId: 105,
            unit: "kilogram",
            kind: .service
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProductUnit)
        
        // Act
        let result = try await sut.updateProductUnit(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.unit, "kilogram")
        XCTAssertEqual(result.kind, .service)
        XCTAssertEqual(result.hotelId, 105)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test deleteProductUnit
    
    func testDeleteProductUnit_Success() async throws {
        // Arrange
        let expectedProductUnit = createMockProductUnits()[0]
        let request = ProductUnitServiceRequest.DeleteProductUnit(id: 1)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedProductUnit)
        
        // Act
        let result = try await sut.deleteProductUnit(request: request)
        
        // Assert
        XCTAssertEqual(result.id, 1)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testDeleteProductUnit_Failure_NotFound() async throws {
        // Arrange
        let request = ProductUnitServiceRequest.DeleteProductUnit(id: 999)
        
        let error = APIError.unknownError(title: "ProductUnit not found",
                                    subtitle: nil,
                                    underlying: nil)
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce{ (a,b) -> ProductUnit in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.deleteProductUnit(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _, _):
                XCTAssertEqual(title, "ProductUnit not found")
            default:
                XCTFail("Unexpected error type")
            }
        }
    }
    
    // MARK: - Test fetchByHotel with filtering
    
    func testFetchByHotel_WithKindFilter_Success() async throws {
        // Arrange
        let expectedPaginator = createMockProductUnitPaginator()
        
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: .product,
            query: nil
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.lists.count, 2)
        XCTAssertEqual(result.items.lists.first?.kind, .product)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchByHotel_WithQueryFilter_Success() async throws {
        // Arrange
        let expectedPaginator = createMockProductUnitPaginator()
        
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: nil,
            query: "piece"
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.lists.count, 2)
        XCTAssertEqual(result.items.lists.first?.unit, "piece")
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func testFetchByHotel_WithBothKindAndQueryFilter_Success() async throws {
        // Arrange
        let expectedPaginator = createMockProductUnitPaginator()
        
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .fifty,
            sortedBy: .kind,
            sortedOrder: .descending,
            kind: .service,
            query: "hour"
        )
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)
        
        // Act
        let result = try await sut.fetchByHotel(request: request)
        
        // Assert
        XCTAssertEqual(result.items.lists.count, 2)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockProductUnits() -> [ProductUnit] {
        return [
            ProductUnit(
                id: 1,
                unit: "piece",
                kind: .product,
                hotelId: 105,
                createdAt: Date(),
                updatedAt: Date()
            ),
            ProductUnit(
                id: 2,
                unit: "hour",
                kind: .service,
                hotelId: 105,
                createdAt: Date(),
                updatedAt: Date()
            )
        ]
    }
    
    private func createMockProductUnitPaginator() -> Paginator<ProductUnit> {
        let mockProductUnits = createMockProductUnits()
        let collection = ProductUnits(array: mockProductUnits)
        return Paginator<ProductUnit>(
            items: collection,
            totalItems: mockProductUnits.count,
            totalPages: 1,
            perPage: 20,
            page: 1
        )
    }
} 
