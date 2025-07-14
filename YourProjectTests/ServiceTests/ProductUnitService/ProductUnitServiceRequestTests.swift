//
//  ProductUnitServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest


class ProductUnitServiceRequestTests: XCTestCase {
    
    // MARK: - Test FetchByHotel
    
    func testFetchByHotel_EncodingWithAllParameters() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: .product,
            query: "test search"
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UNIT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["kind"] as? String, "PRODUCT")
        XCTAssertEqual(parameters?["q"] as? String, "test search")
    }
    
    func testFetchByHotel_EncodingWithMinimalParameters() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            kind: nil,
            query: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["kind"])
        XCTAssertNil(parameters?["q"])
    }
    
    func testFetchByHotel_EncodingWithServiceKind() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .fifty,
            sortedBy: .kind,
            sortedOrder: .descending,
            kind: .service,
            query: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "KIND")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["kind"] as? String, "SERVICE")
        XCTAssertNil(parameters?["q"])
    }
    
    func testFetchByHotel_EncodingWithQueryOnly() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            kind: nil,
            query: "piece"
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["kind"])
        XCTAssertEqual(parameters?["q"] as? String, "piece")
    }
    
    func testFetchByHotel_EncodingWithInvalidPage() throws {
        // Given
        let request = ProductUnitServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 0, // Invalid page number
            perPage: .twenty,
            sortedBy: .unit,
            sortedOrder: .ascending,
            kind: .product,
            query: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertNil(parameters?["page"]) // Should be nil for invalid page
        XCTAssertEqual(parameters?["kind"] as? String, "PRODUCT")
    }
    
    func testFetchByHotel_AllSortedByOptions() throws {
        // Test all SortedBy enum cases
        let sortedByOptions: [ProductUnitServiceRequest.SortedBy] = [
            .id, .unit, .kind, .createdAt, .updatedAt
        ]
        
        for sortedBy in sortedByOptions {
            // Given
            let request = ProductUnitServiceRequest.FetchByHotel(
                hotelId: 105,
                page: 1,
                perPage: .twenty,
                sortedBy: sortedBy,
                sortedOrder: .ascending,
                kind: nil,
                query: nil
            )
            
            // When
            let parameters = request.parameters
            
            // Then
            XCTAssertNotNil(parameters)
            XCTAssertEqual(parameters?["sorted_by"] as? String, sortedBy.rawValue)
        }
    }
    
    // MARK: - Test CreateProductUnit
    
    func testCreateProductUnit_EncodingWithProductKind() throws {
        // Given
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "piece",
            kind: .product
        )
        
        // When
        let bodyData = request.body
        
        // Then
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["unit"] as? String, "piece")
        XCTAssertEqual(json?["kind"] as? String, "PRODUCT")
    }
    
    func testCreateProductUnit_EncodingWithServiceKind() throws {
        // Given
        let request = ProductUnitServiceRequest.CreateProductUnit(
            hotelId: 105,
            unit: "hour",
            kind: .service
        )
        
        // When
        let bodyData = request.body
        
        // Then
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["unit"] as? String, "hour")
        XCTAssertEqual(json?["kind"] as? String, "SERVICE")
    }
    
    // MARK: - Test UpdateProductUnit
    
    func testUpdateProductUnit_EncodingWithAllParameters() throws {
        // Given
        let request = ProductUnitServiceRequest.UpdateProductUnit(
            id: 1,
            hotelId: 105,
            unit: "kg",
            kind: .product
        )
        
        // When
        let bodyData = request.body
        
        // Then
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["unit"] as? String, "kg")
        XCTAssertEqual(json?["kind"] as? String, "PRODUCT")
        // Note: id is not included in the body, it's in the URL path
    }
    
    // MARK: - Test ByID Struct
    
    func testByID_InitializationAndAccess() {
        // Given
        let byId = ProductUnitServiceRequest.ByID(id: 123)
        
        // Then
        XCTAssertEqual(byId.id, 123)
    }
    
    // MARK: - Test Type Aliases
    
    func testTypeAliases() {
        // Verify that type aliases are correctly defined
        let fetchById: ProductUnitServiceRequest.FetchById = ProductUnitServiceRequest.ByID(id: 1)
        let deleteRequest: ProductUnitServiceRequest.DeleteProductUnit = ProductUnitServiceRequest.ByID(id: 2)
        
        XCTAssertEqual(fetchById.id, 1)
        XCTAssertEqual(deleteRequest.id, 2)
    }
} 
