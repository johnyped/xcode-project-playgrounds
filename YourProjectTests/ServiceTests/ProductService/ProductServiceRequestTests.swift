//
//  ProductServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest


class ProductServiceRequestTests: XCTestCase {
    
    // MARK: - Test FetchByHotel
    
    func testFetchByHotel_EncodingWithAllParameters() throws {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: 1,
            query: "test"
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["category_id"] as? Int, 1)
        XCTAssertEqual(parameters?["q"] as? String, "test")
    }
    
    func testFetchByHotel_EncodingWithMinimalParameters() throws {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            categoryId: nil,
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
        XCTAssertNil(parameters?["category_id"])
        XCTAssertNil(parameters?["query"])
    }
    
    func testFetchByHotel_EncodingWithInvalidPage() throws {
        // Given
        let request = ProductServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 0, // Invalid page number
            perPage: .twenty,
            sortedBy: .name,
            sortedOrder: .ascending,
            categoryId: nil,
            query: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertNil(parameters?["page"]) // Should be nil for invalid page
    }
    
    // MARK: - Test CreateProduct
    
    func testCreateProduct_EncodingWithAllParameters() throws {
        // Given
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
        
        // When
        let bodyData = request.body
        
        // Then
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "New Product")
        XCTAssertEqual(json?["description"] as? String, "Test Description")
        XCTAssertEqual(json?["barcode"] as? String, "123456789")
        XCTAssertEqual(json?["code"] as? String, "PROD001")
        XCTAssertEqual(json?["category_id"] as? Int, 1)
        XCTAssertEqual(json?["selling_price"] as? String, "100.0")
        XCTAssertEqual(json?["selling_vat_option"] as? String, "EXCLUDED_VAT")
        XCTAssertEqual(json?["buying_price"] as? String, "80.0")
        XCTAssertEqual(json?["buying_vat_option"] as? String, "INCLUDED_VAT")
    }
    
    func testCreateProduct_EncodingWithMinimalParameters() throws {
        // Given
        let request = ProductServiceRequest.CreateProduct(
            hotelId: 105,
            name: "Minimal Product",
            description: "Minimal Description",
            barcode: nil,
            code: nil,
            categoryId: nil,
            sellingPrice: 50.0,
            sellingVatOption: .includedVat,
            buyingPrice: 40.0,
            buyingVatOption: .excludedVat
        )
        
        // When
        let bodyData = request.body
        
        // Then
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "Minimal Product")
        XCTAssertEqual(json?["description"] as? String, "Minimal Description")
        XCTAssertNil(json?["barcode"])
        XCTAssertNil(json?["code"])
        XCTAssertNil(json?["category_id"])
        XCTAssertEqual(json?["selling_price"] as? String, "50.0")
        XCTAssertEqual(json?["selling_vat_option"] as? String, "INCLUDED_VAT")
        XCTAssertEqual(json?["buying_price"] as? String, "40.0")
        XCTAssertEqual(json?["buying_vat_option"] as? String, "EXCLUDED_VAT")
    }
    
    // MARK: - Test UpdateProduct
    
    func testUpdateProduct_EncodingWithAllParameters() throws {
        // Given
        let request = ProductServiceRequest.UpdateProduct(
            id: 2,
            hotelId: 105,
            name: "Updated Product",
            description: "Updated Description",
            barcode: "987654321",
            code: "UPROD001",
            categoryId: 2,
            sellingPrice: 120.0,
            sellingVatOption: .includedVat,
            buyingPrice: 90.0,
            buyingVatOption: .excludedVat
        )
        
        // When
        let bodyData = request.body
        
        // Then
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "Updated Product")
        XCTAssertEqual(json?["description"] as? String, "Updated Description")
        XCTAssertEqual(json?["barcode"] as? String, "987654321")
        XCTAssertEqual(json?["code"] as? String, "UPROD001")
        XCTAssertEqual(json?["category_id"] as? Int, 2)
        XCTAssertEqual(json?["selling_price"] as? String, "120.0")
        XCTAssertEqual(json?["selling_vat_option"] as? String, "INCLUDED_VAT")
        XCTAssertEqual(json?["buying_price"] as? String, "90.0")
        XCTAssertEqual(json?["buying_vat_option"] as? String, "EXCLUDED_VAT")
    }
    
    // MARK: - Test SortedBy Enum
    
    func testSortedBy_RawValues() {
        XCTAssertEqual(ProductServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(ProductServiceRequest.SortedBy.name.rawValue, "NAME")
        XCTAssertEqual(ProductServiceRequest.SortedBy.sellingPrice.rawValue, "SELLING_PRICE")
        XCTAssertEqual(ProductServiceRequest.SortedBy.buyingPrice.rawValue, "BUYING_PRICE")
        XCTAssertEqual(ProductServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(ProductServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
    
    // MARK: - Test ByID Struct
    
    func testByID_Initialization() {
        let byId = ProductServiceRequest.ByID(id: 123)
        XCTAssertEqual(byId.id, 123)
    }
    
    func testFetchById_TypeAlias() {
        let fetchById: ProductServiceRequest.FetchById = ProductServiceRequest.ByID(id: 456)
        XCTAssertEqual(fetchById.id, 456)
    }
    
    func testDeleteProduct_TypeAlias() {
        let deleteProduct: ProductServiceRequest.DeleteProduct = ProductServiceRequest.ByID(id: 789)
        XCTAssertEqual(deleteProduct.id, 789)
    }
} 
