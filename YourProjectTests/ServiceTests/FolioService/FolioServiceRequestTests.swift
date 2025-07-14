//
//  FolioServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class FolioServiceRequestTests: XCTestCase {
    
    // MARK: - FetchFolios Tests
    
    func test_fetchFolios_withAllParameters_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: .available,
            vatOption: .zeroVat
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["status"] as? String, "AVAILABLE")
        XCTAssertEqual(parameters?["vat_option"] as? String, "ZERO_VAT")
    }
    
    func test_fetchFolios_withMinimalParameters_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            status: nil,
            vatOption: nil
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
        XCTAssertNil(parameters?["status"])
        XCTAssertNil(parameters?["vat_option"])
    }
    
    func test_fetchFolios_withDifferentSortOptions_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 105,
            page: 2,
            perPage: .fifty,
            sortedBy: .name,
            sortedOrder: .descending,
            status: .available,
            vatOption: .excludedVat
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["status"] as? String, "AVAILABLE")
        XCTAssertEqual(parameters?["vat_option"] as? String, "EXCLUDED_VAT")
    }
    
    func test_fetchFolios_withCreatedAtSort_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 105,
            page: 3,
            perPage: .hundred,
            sortedBy: .createdAt,
            sortedOrder: .ascending,
            status: .available,
            vatOption: .includedVat
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["status"] as? String, "AVAILABLE")
        XCTAssertEqual(parameters?["vat_option"] as? String, "INCLUDED_VAT")
    }
    
    func test_fetchFolios_withUpdatedAtSort_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 105,
            page: 1,
            perPage: .ten,
            sortedBy: .updatedAt,
            sortedOrder: .descending,
            status: .available,
            vatOption: .zeroVat
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertEqual(parameters?["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
        XCTAssertEqual(parameters?["status"] as? String, "AVAILABLE")
        XCTAssertEqual(parameters?["vat_option"] as? String, "ZERO_VAT")
    }
    
    // MARK: - FetchFoliosByCategory Tests
    
    func test_fetchFoliosByCategory_withValidParameters_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFoliosByCategory(
            hotelId: 105,
            categoryId: 5
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["category_id"] as? Int, 5)
    }
    
    func test_fetchFoliosByCategory_withZeroValues_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFoliosByCategory(
            hotelId: 0,
            categoryId: 0
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 0)
        XCTAssertEqual(parameters?["category_id"] as? Int, 0)
    }
    
    func test_fetchFoliosByCategory_withLargeValues_correctSerialization() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFoliosByCategory(
            hotelId: 999999,
            categoryId: 888888
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 999999)
        XCTAssertEqual(parameters?["category_id"] as? Int, 888888)
    }
    
    func test_fetchFoliosByCategory_encoding_correctFormat() throws {
        // Arrange
        let request = FolioServiceRequest.FetchFoliosByCategory(
            hotelId: 105,
            categoryId: 10
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["category_id"] as? Int, 10)
    }
    
    // MARK: - FetchFolio Tests
    
    func test_fetchFolio_withValidId_correctInitialization() throws {
        // Arrange & Act
        let request = FolioServiceRequest.FetchFolio(id: 123)
        
        // Assert
        XCTAssertEqual(request.id, 123)
    }
    
    // MARK: - CreateFolio Tests
    
    func test_createFolio_withAllParameters_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "Test Folio",
            amount: 150.75,
            description: "Test Description",
            categoryId: 5,
            amountVatOption: .includedVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "Test Folio")
        XCTAssertEqual(json?["amount"] as? String, "150.75")
        XCTAssertEqual(json?["description"] as? String, "Test Description")
        XCTAssertEqual(json?["category_id"] as? Int, 5)
        XCTAssertEqual(json?["amount_vat_option"] as? String, "INCLUDED_VAT")
    }
    
    func test_createFolio_withMinimalParameters_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "Minimal Folio",
            amount: 100.0,
            description: nil,
            categoryId: nil,
            amountVatOption: .excludedVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["name"] as? String, "Minimal Folio")
        XCTAssertEqual(json?["amount"] as? String, "100.0")
        XCTAssertNil(json?["description"])
        XCTAssertNil(json?["category_id"])
        XCTAssertEqual(json?["amount_vat_option"] as? String, "EXCLUDED_VAT")
    }
    
    func test_createFolio_withZeroVatOption_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "Zero VAT Folio",
            amount: 200.0,
            description: "Zero VAT Description",
            categoryId: 10,
            amountVatOption: .zeroVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["amount_vat_option"] as? String, "ZERO_VAT")
    }
    
    func test_createFolio_withNoVatOption_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "No VAT Folio",
            amount: 300.0,
            description: "No VAT Description",
            categoryId: 15,
            amountVatOption: .noVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["amount_vat_option"] as? String, "NO_VAT")
    }
    
    // MARK: - UpdateFolio Tests
    
    func test_updateFolio_withAllParameters_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.UpdateFolio(
            id: 123,
            name: "Updated Folio",
            amount: 250.50,
            description: "Updated Description",
            categoryId: 8,
            amountVatOption: .includedVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["name"] as? String, "Updated Folio")
        XCTAssertEqual(json?["amount"] as? String, "250.5")
        XCTAssertEqual(json?["description"] as? String, "Updated Description")
        XCTAssertEqual(json?["category_id"] as? Int, 8)
        XCTAssertEqual(json?["amount_vat_option"] as? String, "INCLUDED_VAT")
        // ID should not be in the encoded JSON as it's used in URL path
        XCTAssertNil(json?["id"])
    }
    
    func test_updateFolio_withMinimalParameters_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.UpdateFolio(
            id: 123,
            name: nil,
            amount: nil,
            description: nil,
            categoryId: nil,
            amountVatOption: nil
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertNotNil(json)
        XCTAssertNil(json?["name"])
        XCTAssertNil(json?["amount"])
        XCTAssertNil(json?["description"])
        XCTAssertNil(json?["category_id"])
        XCTAssertNil(json?["amount_vat_option"])
        XCTAssertNil(json?["id"])
    }
    
    func test_updateFolio_withPartialParameters_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.UpdateFolio(
            id: 123,
            name: "Partially Updated",
            amount: 175.25,
            description: nil,
            categoryId: 12,
            amountVatOption: nil
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["name"] as? String, "Partially Updated")
        XCTAssertEqual(json?["amount"] as? String, "175.25")
        XCTAssertNil(json?["description"])
        XCTAssertEqual(json?["category_id"] as? Int, 12)
        XCTAssertNil(json?["amount_vat_option"])
    }
    
    // MARK: - DeleteFolio Tests
    
    func test_deleteFolio_withValidId_correctInitialization() throws {
        // Arrange & Act
        let request = FolioServiceRequest.DeleteFolio(id: 456)
        
        // Assert
        XCTAssertEqual(request.id, 456)
    }
    
    // MARK: - Enum Tests
    
    func test_sortedBy_allCases_correctRawValues() throws {
        // Assert
        XCTAssertEqual(FolioServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(FolioServiceRequest.SortedBy.name.rawValue, "NAME")
        XCTAssertEqual(FolioServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(FolioServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
    }
    
    func test_vatOption_allCases_correctRawValues() throws {
        // Assert
        XCTAssertEqual(FolioServiceRequest.VatOption.excludedVat.rawValue, "EXCLUDED_VAT")
        XCTAssertEqual(FolioServiceRequest.VatOption.includedVat.rawValue, "INCLUDED_VAT")
        XCTAssertEqual(FolioServiceRequest.VatOption.zeroVat.rawValue, "ZERO_VAT")
        XCTAssertEqual(FolioServiceRequest.VatOption.noVat.rawValue, "NO_VAT")
    }
    
    // MARK: - Edge Cases Tests
    
    func test_createFolio_withZeroAmount_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "Zero Amount Folio",
            amount: 0.0,
            description: "Zero amount test",
            categoryId: 1,
            amountVatOption: .noVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["amount"] as? String, "0.0")
    }
    
    func test_createFolio_withNegativeAmount_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "Negative Amount Folio",
            amount: -50.0,
            description: "Negative amount test",
            categoryId: 1,
            amountVatOption: .excludedVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["amount"] as? String, "-50.0")
    }
    
    func test_createFolio_withLargeAmount_correctEncoding() throws {
        // Arrange
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 105,
            name: "Large Amount Folio",
            amount: 999999.99,
            description: "Large amount test",
            categoryId: 1,
            amountVatOption: .includedVat
        )
        
        // Act
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Assert
        XCTAssertEqual(json?["amount"] as? String, "999999.99")
    }
} 
