//
//  CategoryRouterServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class CategoryRouterServiceTests: XCTestCase {
    
    func test_fetchCategories_correctPath() throws {
        // Arrange
        let request = CategoryServiceRequest.FetchCategories(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            kind: .product
        )
        let router = CategoryServiceRouter.fetchCategories(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.path.contains("/v4/categories") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("hotel_id=105") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("page=1") ?? false)
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("kind=PRODUCT") ?? false)
    }
    
    func test_createCategory_correctPathAndBody() throws {
        // Arrange
        let request = CategoryServiceRequest.CreateCategory(
            hotelId: 105,
            name: "Test Category",
            kind: .service
        )
        let router = CategoryServiceRouter.createCategory(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertTrue(urlRequest.url?.path.contains("/v4/categories") ?? false)
        XCTAssertNotNil(urlRequest.httpBody)
    }
    
    func test_updateCategory_correctPath() throws {
        // Arrange
        let request = CategoryServiceRequest.UpdateCategory(
            id: 123,
            name: "Updated Category",
            kind: .product
        )
        let router = CategoryServiceRouter.updateCategory(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "PUT")
        XCTAssertTrue(urlRequest.url?.path.contains("/v4/categories/123") ?? false)
    }
    
    func test_deleteCategory_correctPath() throws {
        // Arrange
        let request = CategoryServiceRequest.DeleteCategory(id: 123)
        let router = CategoryServiceRouter.deleteCategory(request: request)
        
        // Act
        let urlRequest = try router.asURLRequest()
        
        // Assert
        XCTAssertEqual(urlRequest.httpMethod, "DELETE")
        XCTAssertTrue(urlRequest.url?.path.contains("/v4/categories/123") ?? false)
    }
} 
