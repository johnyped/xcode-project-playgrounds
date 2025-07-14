//
//  CategoryServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class CategoryServiceRequestTests: XCTestCase {
    
    // MARK: - FetchCategories Tests
    
    func test_fetchCategories_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = CategoryServiceRequest.FetchCategories(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            kind: .product
        )
        
        // Act
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Assert
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? String, "20")
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters["kind"] as? String, "PRODUCT")
    }
    
    func test_fetchCategories_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = CategoryServiceRequest.FetchCategories(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            kind: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["kind"])
    }
    
    func test_fetchCategories_withInvalidPage_excludesPageFromParameters() throws {
        // Arrange
        let request = CategoryServiceRequest.FetchCategories(
            hotelId: 105,
            page: 0, // Invalid page
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            kind: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"]) // Should be nil for invalid page
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertNil(parameters?["kind"])
    }
    
    // MARK: - CreateCategory Tests
    
    func test_createCategory_correctSerialization() throws {
        // Arrange
        let request = CategoryServiceRequest.CreateCategory(
            hotelId: 105,
            name: "Test Category",
            kind: .service
        )
        
        // Act
        let body = request.body
        let decodedData = try JSONSerialization.jsonObject(with: body!) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(body)
        XCTAssertEqual(decodedData?["hotel_id"] as? Int, 105)
        XCTAssertEqual(decodedData?["name"] as? String, "Test Category")
        XCTAssertEqual(decodedData?["kind"] as? String, "FOLIOS")
    }
    
    // MARK: - UpdateCategory Tests
    
    func test_updateCategory_withAllFields_correctSerialization() throws {
        // Arrange
        let request = CategoryServiceRequest.UpdateCategory(
            id: 123,
            name: "Updated Category",
            kind: .product
        )
        
        // Act
        let body = request.body
        let decodedData = try JSONSerialization.jsonObject(with: body!) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(body)
        // ID should not be in body as it's used in URL path
        XCTAssertNil(decodedData?["id"])
        XCTAssertEqual(decodedData?["name"] as? String, "Updated Category")
        XCTAssertEqual(decodedData?["kind"] as? String, "PRODUCT")
    }
    
    func test_updateCategory_withPartialFields_correctSerialization() throws {
        // Arrange
        let request = CategoryServiceRequest.UpdateCategory(
            id: 123,
            name: "Updated Name Only",
            kind: nil
        )
        
        // Act
        let body = request.body
        let decodedData = try JSONSerialization.jsonObject(with: body!) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(body)
        XCTAssertEqual(decodedData?["name"] as? String, "Updated Name Only")
        XCTAssertNil(decodedData?["kind"])
    }
} 
