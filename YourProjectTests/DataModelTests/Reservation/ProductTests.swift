//
//  ProductTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest


class ProductTests: XCTestCase {
    
    // MARK: - Test Initialization
    
    func testProduct_Initialization() {
        // Given
        let id = 2
        let hotelId = 105
        let name = "Test Product"
        let description = "Test Description"
        let barcode = "123456789"
        let code = "PROD001"
        let categoryId = 1
        let sellingPrice = 11.11
        let sellingVatOption = Product.VatOption.excludedVat
        let buyingPrice = 22.22
        let buyingVatOption = Product.VatOption.includedVat
        let createdAt = Date()
        let updatedAt = Date()
        
        // When
        let product = Product(
            id: id,
            hotelId: hotelId,
            name: name,
            description: description,
            barcode: barcode,
            code: code,
            categoryId: categoryId,
            sellingPrice: sellingPrice,
            sellingVatOption: sellingVatOption,
            buyingPrice: buyingPrice,
            buyingVatOption: buyingVatOption,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // Then
        XCTAssertEqual(product.id, id)
        XCTAssertEqual(product.hotelId, hotelId)
        XCTAssertEqual(product.name, name)
        XCTAssertEqual(product.description, description)
        XCTAssertEqual(product.barcode, barcode)
        XCTAssertEqual(product.code, code)
        XCTAssertEqual(product.categoryId, categoryId)
        XCTAssertEqual(product.sellingPrice, sellingPrice)
        XCTAssertEqual(product.sellingVatOption, sellingVatOption)
        XCTAssertEqual(product.buyingPrice, buyingPrice)
        XCTAssertEqual(product.buyingVatOption, buyingVatOption)
        XCTAssertEqual(product.createdAt, createdAt)
        XCTAssertEqual(product.updatedAt, updatedAt)
    }
    
    func testProduct_InitializationWithDefaults() {
        // Given
        let id = 3
        let hotelId = 105
        let name = "Minimal Product"
        let sellingPrice = 50.0
        let sellingVatOption = Product.VatOption.includedVat
        let buyingPrice = 40.0
        let buyingVatOption = Product.VatOption.excludedVat
        let createdAt = Date()
        let updatedAt = Date()
        
        // When
        let product = Product(
            id: id,
            hotelId: hotelId,
            name: name,
            sellingPrice: sellingPrice,
            sellingVatOption: sellingVatOption,
            buyingPrice: buyingPrice,
            buyingVatOption: buyingVatOption,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        
        // Then
        XCTAssertEqual(product.id, id)
        XCTAssertEqual(product.hotelId, hotelId)
        XCTAssertEqual(product.name, name)
        XCTAssertEqual(product.description, "")
        XCTAssertEqual(product.barcode, "")
        XCTAssertEqual(product.code, "")
        XCTAssertNil(product.categoryId)
        XCTAssertEqual(product.sellingPrice, sellingPrice)
        XCTAssertEqual(product.sellingVatOption, sellingVatOption)
        XCTAssertEqual(product.buyingPrice, buyingPrice)
        XCTAssertEqual(product.buyingVatOption, buyingVatOption)
        XCTAssertEqual(product.createdAt, createdAt)
        XCTAssertEqual(product.updatedAt, updatedAt)
    }
    
    // MARK: - Test JSON Decoding
    
    func testProduct_DecodingFromJSON() throws {
        // Given
        let jsonString = """
        {
            "id": 2,
            "name": "Product",
            "description": "Description",
            "barcode": "",
            "code": "",
            "category_id": null,
            "selling_price": "11.11",
            "selling_vat_option": "EXCLUDED_VAT",
            "buying_price": "22.22",
            "buying_vat_option": "INCLUDED_VAT",
            "created_at": "2025-06-18T11:18:16.296+07:00",
            "updated_at": "2025-06-18T11:18:16.296+07:00",
            "hotel_id": 105
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        // When
        let product = try JSONDecoder().decode(Product.self, from: jsonData)
        
        // Then
        XCTAssertEqual(product.id, 2)
        XCTAssertEqual(product.name, "Product")
        XCTAssertEqual(product.description, "Description")
        XCTAssertEqual(product.barcode, "")
        XCTAssertEqual(product.code, "")
        XCTAssertNil(product.categoryId)
        XCTAssertEqual(product.sellingPrice, 11.11)
        XCTAssertEqual(product.sellingVatOption, .excludedVat)
        XCTAssertEqual(product.buyingPrice, 22.22)
        XCTAssertEqual(product.buyingVatOption, .includedVat)
        XCTAssertEqual(product.hotelId, 105)
    }
    
    func testProduct_DecodingFromJSONWithCategory() throws {
        // Given
        let jsonString = """
        {
            "id": 3,
            "name": "Product with Category",
            "description": "Product Description",
            "barcode": "123456789",
            "code": "PROD001",
            "category_id": 5,
            "selling_price": "99.99",
            "selling_vat_option": "INCLUDED_VAT",
            "buying_price": "79.99",
            "buying_vat_option": "EXCLUDED_VAT",
            "created_at": "2025-06-18T11:18:16.296+07:00",
            "updated_at": "2025-06-18T11:18:16.296+07:00",
            "hotel_id": 105
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        // When
        let product = try JSONDecoder().decode(Product.self, from: jsonData)
        
        // Then
        XCTAssertEqual(product.id, 3)
        XCTAssertEqual(product.name, "Product with Category")
        XCTAssertEqual(product.description, "Product Description")
        XCTAssertEqual(product.barcode, "123456789")
        XCTAssertEqual(product.code, "PROD001")
        XCTAssertEqual(product.categoryId, 5)
        XCTAssertEqual(product.sellingPrice, 99.99)
        XCTAssertEqual(product.sellingVatOption, .includedVat)
        XCTAssertEqual(product.buyingPrice, 79.99)
        XCTAssertEqual(product.buyingVatOption, .excludedVat)
        XCTAssertEqual(product.hotelId, 105)
    }
    
    // MARK: - Test JSON Encoding
    
    func testProduct_EncodingToJSON() throws {
        // Given
        let product = Product(
            id: 4,
            hotelId: 105,
            name: "Encoded Product",
            description: "Encoded Description",
            barcode: "987654321",
            code: "ENC001",
            categoryId: 3,
            sellingPrice: 75.50,
            sellingVatOption: .includedVat,
            buyingPrice: 60.25,
            buyingVatOption: .excludedVat,
            createdAt: Date(timeIntervalSince1970: 1624019896), // Fixed date for testing
            updatedAt: Date(timeIntervalSince1970: 1624019896)
        )
        
        // When
        let jsonData = try JSONEncoder().encode(product)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? Int, 4)
        XCTAssertEqual(json?["name"] as? String, "Encoded Product")
        XCTAssertEqual(json?["description"] as? String, "Encoded Description")
        XCTAssertEqual(json?["barcode"] as? String, "987654321")
        XCTAssertEqual(json?["code"] as? String, "ENC001")
        XCTAssertEqual(json?["category_id"] as? Int, 3)
        XCTAssertEqual(json?["selling_price"] as? String, "75.5")
        XCTAssertEqual(json?["selling_vat_option"] as? String, "INCLUDED_VAT")
        XCTAssertEqual(json?["buying_price"] as? String, "60.25")
        XCTAssertEqual(json?["buying_vat_option"] as? String, "EXCLUDED_VAT")
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(json?["created_at"])
        XCTAssertNotNil(json?["updated_at"])
    }
    
    // MARK: - Test VatOption Enum
    
    func testVatOption_RawValues() {
        XCTAssertEqual(Product.VatOption.includedVat.rawValue, "INCLUDED_VAT")
        XCTAssertEqual(Product.VatOption.excludedVat.rawValue, "EXCLUDED_VAT")
    }
    
    func testVatOption_Codable() throws {
        // Test encoding
        let includedVat = Product.VatOption.includedVat
        let excludedVat = Product.VatOption.excludedVat
        
        let includedData = try JSONEncoder().encode(includedVat)
        let excludedData = try JSONEncoder().encode(excludedVat)
        
        let includedString = String(data: includedData, encoding: .utf8)
        let excludedString = String(data: excludedData, encoding: .utf8)
        
        XCTAssertEqual(includedString, "\"INCLUDED_VAT\"")
        XCTAssertEqual(excludedString, "\"EXCLUDED_VAT\"")
        
        // Test decoding
        let decodedIncluded = try JSONDecoder().decode(Product.VatOption.self, from: includedData)
        let decodedExcluded = try JSONDecoder().decode(Product.VatOption.self, from: excludedData)
        
        XCTAssertEqual(decodedIncluded, .includedVat)
        XCTAssertEqual(decodedExcluded, .excludedVat)
    }
    
    // MARK: - Test Encoding Error Handling
    
    func testProduct_InvalidPriceDecoding() {
        // Given
        let jsonString = """
        {
            "id": 5,
            "name": "Invalid Product",
            "description": "Invalid Price",
            "barcode": "",
            "code": "",
            "category_id": null,
            "selling_price": "invalid_price",
            "selling_vat_option": "EXCLUDED_VAT",
            "buying_price": "22.22",
            "buying_vat_option": "INCLUDED_VAT",
            "created_at": "2025-06-18T11:18:16.296+07:00",
            "updated_at": "2025-06-18T11:18:16.296+07:00",
            "hotel_id": 105
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(Product.self, from: jsonData)) { error in
            // Expect decoding error due to invalid price format
            XCTAssertTrue(error is DecodingError || error is NSError)
        }
    }
    
    func testProduct_InvalidDateDecoding() {
        // Given
        let jsonString = """
        {
            "id": 6,
            "name": "Invalid Date Product",
            "description": "Invalid Date",
            "barcode": "",
            "code": "",
            "category_id": null,
            "selling_price": "11.11",
            "selling_vat_option": "EXCLUDED_VAT",
            "buying_price": "22.22",
            "buying_vat_option": "INCLUDED_VAT",
            "created_at": "invalid_date",
            "updated_at": "2025-06-18T11:18:16.296+07:00",
            "hotel_id": 105
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(Product.self, from: jsonData)) { error in
            // Expect decoding error due to invalid date format
            XCTAssertTrue(error is DecodingError || error is NSError)
        }
    }
} 
